#!/bin/sh
# Main entry point - builds everything
# Usage: redo all

echo "Starting podcast build..." >&2

# Step 1: Fetch latest episodes from YouTube playlist
redo-ifchange metadata/episodes.json

# Videos kept in the playlist for episode-numbering continuity but which aren't
# real episodes. They get no markdown file at all — we don't use Hugo drafts.
NON_EPISODES='["X-SEYqhB7Rw"]'

# Step 2: Generate markdown files and download audio for all episodes (parallel)
echo "Generating episode markdown files..." >&2
redo-ifchange $(jq -r --argjson skip "$NON_EPISODES" \
    '.[] | select(.youtubeId | IN($skip[]) | not) | .slug' metadata/episodes.json | sed 's/$/.md/')

echo "Downloading audio files..." >&2
redo-ifchange $(jq -r '.[].slug' metadata/episodes.json | sed 's|.*|.audio/&.mp3|')

echo "Generating episode artwork..." >&2
redo-ifchange $(jq -r '.[].slug' metadata/episodes.json | sed 's|.*|.images/&.jpg|')

echo "Generating transcripts..." >&2
redo-ifchange $(jq -r '.[].slug' metadata/episodes.json | sed 's|.*|.transcripts/&.vtt .transcripts/&.txt|')

# Step 3: Upload to S3
redo-ifchange upload-audio upload-images upload-transcripts

echo "Podcast build complete!" >&2

# Create a marker file
date > "$3"
