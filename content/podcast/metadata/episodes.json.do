#!/bin/bash
# Fetch episodes from YouTube playlist and generate episodes.json
# Usage: redo metadata/episodes.json

PLAYLIST_URL="https://www.youtube.com/playlist?list=PLiKgVPlhUNuyTXzN03gCB1lqvaHXxPLak"

echo "Fetching playlist metadata from YouTube..." >&2

# Fetch playlist with flat mode first to get video IDs
PLAYLIST_TMP=$(mktemp)
yt-dlp -J --flat-playlist "$PLAYLIST_URL" > "$PLAYLIST_TMP"

# Extract video IDs in playlist order (reversed because playlist shows newest first)
VIDEO_IDS=$(jq -r '.entries | reverse | .[].id' "$PLAYLIST_TMP")
TOTAL=$(echo "$VIDEO_IDS" | wc -l | tr -d ' ')

echo "Found $TOTAL videos in playlist" >&2

# Now fetch individual video details
echo "Fetching individual video details..." >&2

TEMP_FILE=$(mktemp)
echo "[" > "$TEMP_FILE"

EPISODE_NUM=0
FIRST=true
for VIDEO_ID in $VIDEO_IDS; do
    EPISODE_NUM=$((EPISODE_NUM + 1))
    
    echo "  Fetching details for episode $EPISODE_NUM (video $VIDEO_ID)..." >&2
    
    # Fetch individual video metadata and transform directly with jq
    VIDEO_TMP=$(mktemp)
    if yt-dlp -j "https://www.youtube.com/watch?v=$VIDEO_ID" > "$VIDEO_TMP" 2>/dev/null; then
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
    fi
    rm -f "$VIDEO_TMP"
done

echo "]" >> "$TEMP_FILE"

# Format the final JSON nicely
jq '.' "$TEMP_FILE" > "$3"

rm -f "$PLAYLIST_TMP" "$TEMP_FILE"

# Validate that the number of episodes matches the playlist count
ACTUAL_COUNT=$(jq 'length' "$3")
echo "Generated episodes.json with $ACTUAL_COUNT episodes" >&2

if [ "$ACTUAL_COUNT" -ne "$TOTAL" ]; then
    echo "ERROR: Episode count mismatch! Expected $TOTAL videos from playlist, but got $ACTUAL_COUNT episodes in JSON" >&2
    exit 1
fi

echo "✓ Validation passed: All $TOTAL playlist videos were successfully processed" >&2
