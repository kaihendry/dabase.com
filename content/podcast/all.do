#!/bin/bash
set -euo pipefail
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
# Capture first, then split: inlining this as redo-ifchange $(jq ...) would turn
# a failing jq into "redo-ifchange" with no arguments, which builds nothing and
# reports success. set -o pipefail only helps if the failure is in an assignment.
MD_LIST=$(jq -r --argjson skip "$NON_EPISODES" \
    '.[] | select(.youtubeId | IN($skip[]) | not) | .slug' metadata/episodes.json | sed 's/$/.md/')
# A read loop rather than mapfile: /bin/bash on macOS is 3.2, where mapfile
# does not exist
MD_FILES=()
while IFS= read -r LINE; do
    [ -n "$LINE" ] && MD_FILES+=("$LINE")
done <<< "$MD_LIST"

if [ "${#MD_FILES[@]}" -eq 0 ] || [ -z "${MD_FILES[0]}" ]; then
    echo "Error: no episodes found in metadata/episodes.json" >&2
    exit 1
fi

redo-ifchange "${MD_FILES[@]}"

# Step 3: Audio, artwork and transcripts to S3. Each upload target depends on
# the files it syncs, so building these builds those too — listing them here as
# well would just be duplication that can drift.
echo "Building and uploading audio, artwork and transcripts..." >&2
redo-ifchange upload-audio upload-images upload-transcripts

echo "Podcast build complete!" >&2

# Create a marker file
date > "$3"
