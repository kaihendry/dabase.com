#!/bin/bash
cd "$(dirname "$0")"

jq -r '.[1:] | .[] | "\(.slug) \(.youtubeUrl)"' metadata/episodes.json | while read slug url; do
  if [ ! -f "audio/${slug}.mp3" ]; then
    echo "Downloading $slug..."
    yt-dlp --extract-audio --audio-format mp3 --audio-quality 192K \
      --output "audio/${slug}.mp3" --no-playlist "$url"
  else
    echo "Skipping $slug (already exists)"
  fi
done

echo "All downloads complete!"
