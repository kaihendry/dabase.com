#!/bin/sh
# Download audio from YouTube
# $1 = target (e.g., audio/001-episode-title.mp3)
# $2 = basename without extension

SLUG=$(basename "$2")
redo-ifchange metadata/episodes.json

# Find episode data
YOUTUBE_URL=$(jq -r --arg slug "$SLUG" \
    '.[] | select(.slug == $slug) | .youtubeUrl' \
    metadata/episodes.json)

if [ -z "$YOUTUBE_URL" ] || [ "$YOUTUBE_URL" = "null" ]; then
    echo "Error: No YouTube URL found for $SLUG" >&2
    exit 1
fi

echo "Downloading audio for $SLUG..." >&2

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
