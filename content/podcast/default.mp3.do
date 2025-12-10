#!/bin/sh
# Download audio from YouTube (idempotent - checks local, then S3, then downloads)
# $1 = target (e.g., audio/001-episode-title.mp3)
# $2 = basename without extension

SLUG=$(basename "$2")
LOCAL_PATH="audio/${SLUG}.mp3"
S3_PATH="s3://dabase.com/podcast/audio/${SLUG}.mp3"

# Check 1: Local copy exists and is larger than 1KB
if [ -f "$LOCAL_PATH" ]; then
    LOCAL_SIZE=$(stat -c%s "$LOCAL_PATH" 2>/dev/null || stat -f%z "$LOCAL_PATH" 2>/dev/null)
    if [ "$LOCAL_SIZE" -gt 1000 ] 2>/dev/null; then
        echo "Using local copy: $LOCAL_PATH (${LOCAL_SIZE} bytes)" >&2
        cp "$LOCAL_PATH" "$3"
        exit 0
    fi
fi

# Check 2: Already exists on S3 - download from there
if aws s3 ls "$S3_PATH" >/dev/null 2>&1; then
    S3_SIZE=$(aws s3 ls "$S3_PATH" | awk '{print $3}')
    # Only use if file is larger than 1KB (not a placeholder)
    if [ "$S3_SIZE" -gt 1000 ] 2>/dev/null; then
        echo "Downloading from S3: $SLUG (${S3_SIZE} bytes)" >&2
        aws s3 cp "$S3_PATH" "$3" --only-show-errors
        exit 0
    fi
fi

redo-ifchange metadata/episodes.json

# Find episode data
YOUTUBE_URL=$(jq -r --arg slug "$SLUG" \
    '.[] | select(.slug == $slug) | .youtubeUrl' \
    metadata/episodes.json)

if [ -z "$YOUTUBE_URL" ] || [ "$YOUTUBE_URL" = "null" ]; then
    echo "Error: No YouTube URL found for $SLUG" >&2
    exit 1
fi

echo "Downloading audio for $SLUG from YouTube..." >&2

mkdir -p audio

# Download and convert to MP3 192kbps
# yt-dlp adds .mp3 extension, so we strip it from output template
# Note: redirect stdout to stderr because redo captures stdout as target file
OUTPUT_BASE="${3%.mp3}"
yt-dlp \
    --extract-audio \
    --audio-format mp3 \
    --audio-quality 192K \
    --output "$OUTPUT_BASE" \
    --no-playlist \
    "$YOUTUBE_URL" >&2

# yt-dlp creates file with .mp3 extension, move to expected location
if [ -f "${OUTPUT_BASE}.mp3" ]; then
    mv "${OUTPUT_BASE}.mp3" "$3"
fi

FILE_SIZE=$(stat -f%z "$3" 2>/dev/null || stat -c%s "$3" 2>/dev/null)
echo "Downloaded: $1 ($(numfmt --to=iec-i --suffix=B $FILE_SIZE 2>/dev/null || echo $FILE_SIZE bytes))" >&2
