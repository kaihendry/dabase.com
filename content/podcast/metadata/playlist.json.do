#!/bin/sh
# Fetch YouTube playlist metadata
# Dependencies: yt-dlp

PLAYLIST_URL="https://www.youtube.com/playlist?list=PLiKgVPlhUNuyTXzN03gCB1lqvaHXxPLak"

echo "Fetching playlist metadata..." >&2

# Download playlist metadata (without videos)
yt-dlp \
    --skip-download \
    --dump-json \
    --flat-playlist \
    "$PLAYLIST_URL" | jq -s '.' > "$3"

EPISODE_COUNT=$(jq 'length' "$3")
echo "Fetched metadata for $EPISODE_COUNT episodes" >&2
