#!/bin/bash
set -euo pipefail
# Episode artwork, two variants from one .do (both match default.jpg.do):
#   NNN-slug.jpg       1400x1400 square, required by Apple/Spotify for the feed
#   NNN-slug-wide.jpg  1280x720 16:9, for the web pages and social cards
# Self-hosted so the feed URL changes when artwork changes (Spotify/Apple cache by URL)
# $1 = target (e.g., .images/001-episode-title.jpg)
# $2 = basename without extension

SLUG=$(basename "$2")
redo-ifchange "metadata/${SLUG}.json"

# Prefer an exact slug match, so a real episode title ending in "-wide" still
# resolves to its own square cover rather than being read as the variant suffix
YOUTUBE_ID=$(jq -r '.youtubeId' "metadata/${SLUG}.json")
VARIANT=square
if [ "$SLUG" != "$(jq -r '.slug' "metadata/${SLUG}.json")" ]; then
    VARIANT=wide
fi

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

# Crop letterbox bars first (no-op on 16:9), so hqdefault's 4:3 padding doesn't
# survive into either variant. Square then pads back out to 1400x1400 on white.
case "$VARIANT" in
wide)   FILTER="crop=iw:min(ih\,iw*9/16),scale=1280:720" ;;
*)      FILTER="crop=iw:min(ih\,iw*9/16),scale=1400:-2,pad=1400:1400:0:(oh-ih)/2:white" ;;
esac

ffmpeg -loglevel error -y -i "$TMP" -vf "$FILTER" -q:v 2 "$OUT"

mv "$OUT" "$3"
rm -f "$TMP"
