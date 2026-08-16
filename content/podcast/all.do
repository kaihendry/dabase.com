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

# Step 3: Audio, artwork and transcripts to S3. Each upload target depends on
# the files it syncs, so building these builds those too — listing them here as
# well would just be duplication that can drift.
echo "Building and uploading audio, artwork and transcripts..." >&2
redo-ifchange upload-audio upload-images upload-transcripts

echo "Podcast build complete!" >&2

# Create a marker file
date > "$3"
