#!/bin/sh
# Episode artwork: fetch YouTube thumbnail, make 1400x1400 square JPEG for podcast apps
# Self-hosted so the feed URL changes when artwork changes (Spotify/Apple cache by URL)
# $1 = target (e.g., .images/001-episode-title.jpg)
# $2 = basename without extension

SLUG=$(basename "$2")
redo-ifchange metadata/episodes.json

YOUTUBE_ID=$(jq -r --arg slug "$SLUG" \
    '.[] | select(.slug == $slug) | .youtubeId' \
    metadata/episodes.json)

if [ -z "$YOUTUBE_ID" ] || [ "$YOUTUBE_ID" = "null" ]; then
    echo "Error: No episode found for slug $SLUG" >&2
    exit 1
fi

mkdir -p .images
TMP=$(mktemp)
OUT=$(mktemp).jpg

# maxresdefault (1280x720) preferred; older videos only have hqdefault (480x360, 4:3 letterboxed)
if ! curl -fsS "https://img.youtube.com/vi/${YOUTUBE_ID}/maxresdefault.jpg" -o "$TMP"; then
    curl -fsS "https://img.youtube.com/vi/${YOUTUBE_ID}/hqdefault.jpg" -o "$TMP"
fi

# Crop letterbox bars (no-op on 16:9), scale to 1400 wide, pad to 1400x1400 on white
ffmpeg -loglevel error -y -i "$TMP" \
    -vf "crop=iw:min(ih\,iw*9/16),scale=1400:-2,pad=1400:1400:0:(oh-ih)/2:white" \
    -q:v 2 "$OUT"

mv "$OUT" "$3"
rm -f "$TMP"
