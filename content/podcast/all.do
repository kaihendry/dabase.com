#!/bin/sh
# Main entry point - builds everything
# Usage: redo all

echo "Starting podcast build..." >&2

# Step 1: Fetch playlist metadata
redo-ifchange metadata/playlist.json

# Step 2: Process into episodes.json
redo-ifchange metadata/episodes.json

# Step 3: Generate markdown files for all episodes
echo "Generating episode markdown files..." >&2
jq -r '.[].slug' metadata/episodes.json | while read slug; do
    redo-ifchange "episodes/${slug}.md"
done

# Step 4: Download audio files for all episodes
echo "Downloading audio files..." >&2
jq -r '.[].slug' metadata/episodes.json | while read slug; do
    redo-ifchange "audio/${slug}.mp3"
done

# Step 5: Upload to S3
redo-ifchange upload-audio

echo "Podcast build complete!" >&2

# Create a marker file
date > "$3"
