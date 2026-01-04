#!/bin/bash
# Fetch episodes from YouTube playlist and generate episodes.json
# Usage: redo metadata/episodes.json

PLAYLIST_URL="https://www.youtube.com/playlist?list=PLiKgVPlhUNuyTXzN03gCB1lqvaHXxPLak"

echo "Fetching playlist metadata from YouTube..." >&2

# Fetch playlist with flat mode first to get video IDs
PLAYLIST_TMP=$(mktemp)
PLAYLIST_STDERR=$(mktemp)
yt-dlp -J --flat-playlist "$PLAYLIST_URL" > "$PLAYLIST_TMP" 2>"$PLAYLIST_STDERR"
cat "$PLAYLIST_STDERR" >&2

# Extract video IDs in playlist order (reversed because playlist shows newest first)
VIDEO_IDS=$(jq -r '.entries | reverse | .[].id' "$PLAYLIST_TMP")
TOTAL=$(echo "$VIDEO_IDS" | wc -l | tr -d ' ')

# Check for unavailable videos warning and adjust expected count
UNAVAILABLE=$(grep -oP '\d+(?= unavailable video)' "$PLAYLIST_STDERR" || echo "0")
EXPECTED=$((TOTAL - UNAVAILABLE))
rm -f "$PLAYLIST_STDERR"

if [ "$UNAVAILABLE" -gt 0 ]; then
    echo "Note: $UNAVAILABLE video(s) are unavailable and will be skipped" >&2
fi

echo "Found $TOTAL videos in playlist" >&2

# Now fetch individual video details
echo "Fetching individual video details..." >&2

# Create cache directory
CACHE_DIR="$(dirname "$3")/cache"
mkdir -p "$CACHE_DIR"

# Initialize cache statistics
CACHED_COUNT=0
FETCHED_COUNT=0

TEMP_FILE=$(mktemp)
echo "[" > "$TEMP_FILE"

EPISODE_NUM=0
FIRST=true
for VIDEO_ID in $VIDEO_IDS; do
    CACHE_FILE="$CACHE_DIR/${VIDEO_ID}.json"

    # Fetch individual video metadata and transform directly with jq
    VIDEO_TMP=$(mktemp)
    VIDEO_ERR=$(mktemp)

    # Check if cached metadata exists and use it (unless FORCE=1)
    if [ -f "$CACHE_FILE" ] && [ "$FORCE" != "1" ]; then
        echo "  Using cached video $VIDEO_ID..." >&2
        cp "$CACHE_FILE" "$VIDEO_TMP"
        CACHED_COUNT=$((CACHED_COUNT + 1))
        # Only increment episode number for successfully cached videos
        EPISODE_NUM=$((EPISODE_NUM + 1))
        echo "    -> Episode $EPISODE_NUM (cached)" >&2

        # Generate slug: 00X-title-slug
        SLUG_PREFIX=$(printf "%03d" "$EPISODE_NUM")

        if [ "$FIRST" = true ]; then
            FIRST=false
        else
            echo "," >> "$TEMP_FILE"
        fi

        # Build JSON entry directly from yt-dlp output
        jq --argjson ep "$EPISODE_NUM" --arg prefix "$SLUG_PREFIX" '
            {
                episode: $ep,
                season: 1,
                title: .title,
                description: (.description // ""),
                youtubeId: .id,
                youtubeUrl: "https://www.youtube.com/watch?v=\(.id)",
                uploadDate: (.upload_date // "unknown"),
                duration: (.duration // 0),
                slug: ($prefix + "-" + (.title | gsub("[^a-zA-Z0-9 ]"; "") | gsub("  +"; " ") | ascii_downcase | gsub(" "; "-"))[0:60])
            }
        ' "$VIDEO_TMP" >> "$TEMP_FILE"
    else
        # Fetch from YouTube
        echo "  Fetching video $VIDEO_ID..." >&2
        if yt-dlp -j --no-warnings --skip-download "https://www.youtube.com/watch?v=$VIDEO_ID" > "$VIDEO_TMP" 2>"$VIDEO_ERR"; then
            # Save to cache
            cp "$VIDEO_TMP" "$CACHE_FILE"
            FETCHED_COUNT=$((FETCHED_COUNT + 1))
            # Only increment episode number for successfully fetched videos
            EPISODE_NUM=$((EPISODE_NUM + 1))
            echo "    -> Episode $EPISODE_NUM (fetched)" >&2

            # Generate slug: 00X-title-slug
            SLUG_PREFIX=$(printf "%03d" "$EPISODE_NUM")

            if [ "$FIRST" = true ]; then
                FIRST=false
            else
                echo "," >> "$TEMP_FILE"
            fi

            # Build JSON entry directly from yt-dlp output
            jq --argjson ep "$EPISODE_NUM" --arg prefix "$SLUG_PREFIX" '
                {
                    episode: $ep,
                    season: 1,
                    title: .title,
                    description: (.description // ""),
                    youtubeId: .id,
                    youtubeUrl: "https://www.youtube.com/watch?v=\(.id)",
                    uploadDate: (.upload_date // "unknown"),
                    duration: (.duration // 0),
                    slug: ($prefix + "-" + (.title | gsub("[^a-zA-Z0-9 ]"; "") | gsub("  +"; " ") | ascii_downcase | gsub(" "; "-"))[0:60])
                }
            ' "$VIDEO_TMP" >> "$TEMP_FILE"
        else
            echo "    WARN: Failed to fetch $VIDEO_ID" >&2
            cat "$VIDEO_ERR" >&2
        fi
    fi
    rm -f "$VIDEO_TMP" "$VIDEO_ERR"
done

echo "]" >> "$TEMP_FILE"

# Format the final JSON nicely
jq '.' "$TEMP_FILE" > "$3"

rm -f "$PLAYLIST_TMP" "$TEMP_FILE"

# Validate that the number of episodes matches the playlist count
ACTUAL_COUNT=$(jq 'length' "$3")
echo "Generated episodes.json with $ACTUAL_COUNT episodes" >&2

# Output cache statistics
if [ "$FORCE" = "1" ]; then
    echo "Cache statistics: Force mode - fetched all $FETCHED_COUNT from YouTube (cache bypassed)" >&2
else
    echo "Cache statistics: $CACHED_COUNT cached, $FETCHED_COUNT fetched from YouTube" >&2
fi

if [ "$ACTUAL_COUNT" -ne "$EXPECTED" ]; then
    echo "ERROR: Episode count mismatch! Expected $EXPECTED available videos from playlist, but got $ACTUAL_COUNT episodes in JSON" >&2
    exit 1
fi

echo "✓ Validation passed: All $EXPECTED available playlist videos were successfully processed" >&2
