#!/bin/bash
# Generate markdown file for an episode
# $1 = target (e.g., 001-episode-title.md)
# $2 = basename without extension (e.g., 001-episode-title)

SLUG=$(basename "$2")
redo-ifchange metadata/episodes.json

# Find episode data by slug
EPISODE_JSON=$(jq --arg slug "$SLUG" '.[] | select(.slug == $slug)' metadata/episodes.json)

if [ -z "$EPISODE_JSON" ]; then
    echo "Error: No episode found for slug $SLUG" >&2
    exit 1
fi

# Extract fields
EPISODE_NUM=$(echo "$EPISODE_JSON" | jq -r '.episode')
TITLE=$(echo "$EPISODE_JSON" | jq -r '.title')
DESCRIPTION=$(echo "$EPISODE_JSON" | jq -r '.description')
YOUTUBE_ID=$(echo "$EPISODE_JSON" | jq -r '.youtubeId')
YOUTUBE_URL=$(echo "$EPISODE_JSON" | jq -r '.youtubeUrl')
DURATION=$(echo "$EPISODE_JSON" | jq -r '.duration')
UPLOAD_DATE=$(echo "$EPISODE_JSON" | jq -r '.uploadDate')

# Audio file info
AUDIO_FILE="audio/${SLUG}.mp3"
AUDIO_URL="https://dabase.com/podcast/${SLUG}.mp3"

# Get audio file size if exists
if [ -f "$AUDIO_FILE" ]; then
    AUDIO_SIZE=$(stat -f%z "$AUDIO_FILE" 2>/dev/null || stat -c%s "$AUDIO_FILE" 2>/dev/null)
else
    AUDIO_SIZE=0
fi

# Format date (YYYYMMDD -> YYYY-MM-DD)
FORMATTED_DATE="${UPLOAD_DATE:0:4}-${UPLOAD_DATE:4:2}-${UPLOAD_DATE:6:2}"

echo "Generating markdown for episode $EPISODE_NUM: $TITLE" >&2

# Generate markdown
cat > "$3" <<EOF
---
title: "$TITLE"
date: ${FORMATTED_DATE}T12:00:00Z
description: "$DESCRIPTION"
draft: false

podcast:
  episode: $EPISODE_NUM
  season: 1
  episodeType: "full"
  duration: $DURATION
  audioUrl: "$AUDIO_URL"
  audioSize: $AUDIO_SIZE
  youtubeId: "$YOUTUBE_ID"
  youtubeUrl: "$YOUTUBE_URL"
---

$DESCRIPTION

[Watch on YouTube]($YOUTUBE_URL)
EOF
