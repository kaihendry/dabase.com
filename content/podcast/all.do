#!/bin/sh
# Main entry point - builds everything
# Usage: redo all

echo "Starting podcast build..." >&2

# Step 1: Fetch latest episodes from YouTube playlist
redo-ifchange metadata/episodes.json

# Step 2: Generate markdown files and download audio for all episodes (parallel)
echo "Generating episode markdown files..." >&2
redo-ifchange $(jq -r '.[].slug' metadata/episodes.json | sed 's/$/.md/')

echo "Downloading audio files..." >&2
redo-ifchange $(jq -r '.[].slug' metadata/episodes.json | sed 's|.*|audio/&.mp3|')

# Step 3: Upload to S3
redo-ifchange upload-audio

echo "Podcast build complete!" >&2

# Create a marker file
date > "$3"
