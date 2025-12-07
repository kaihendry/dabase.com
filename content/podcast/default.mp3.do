#!/bin/sh
# Download audio from YouTube (idempotent - skips if already on S3)
# $1 = target (e.g., audio/001-episode-title.mp3)
# $2 = basename without extension

SLUG=$(basename "$2")
S3_BUCKET="s3://dabase.com/podcast"

# Check if already exists on S3 - skip download if so
if aws s3 ls "${S3_BUCKET}/${SLUG}.mp3" >/dev/null 2>&1; then
    echo "Skipping $SLUG - already on S3" >&2
    # Download from S3 to local for redo dependency tracking
    aws s3 cp "${S3_BUCKET}/${SLUG}.mp3" "$3" --only-show-errors
    exit 0
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
yt-dlp \
    --extract-audio \
    --audio-format mp3 \
    --audio-quality 192K \
    --output "$3" \
    --no-playlist \
    "$YOUTUBE_URL"

FILE_SIZE=$(stat -f%z "$3" 2>/dev/null || stat -c%s "$3" 2>/dev/null)
echo "Downloaded: $1 ($(numfmt --to=iec-i --suffix=B $FILE_SIZE 2>/dev/null || echo $FILE_SIZE bytes))" >&2
