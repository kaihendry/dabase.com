#!/bin/sh
# Main entry point - builds everything
# Usage: redo all

echo "Starting podcast build..." >&2

# Step 1: Fetch latest episodes from YouTube playlist
redo-ifchange metadata/episodes.json

# Step 2: Generate markdown files for all episodes
echo "Generating episode markdown files..." >&2
jq -r '.[].slug' metadata/episodes.json | while read slug; do
    redo-ifchange "${slug}.md"
done

# Step 2: Download audio files for all episodes
echo "Downloading audio files..." >&2
jq -r '.[].slug' metadata/episodes.json | while read slug; do
    redo-ifchange "audio/${slug}.mp3"
done

# Step 3: Upload to S3
redo-ifchange upload-audio

echo "Podcast build complete!" >&2

# Create a marker file
date > "$3"
