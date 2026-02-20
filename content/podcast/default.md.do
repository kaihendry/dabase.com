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
# Escape double quotes for YAML frontmatter (body content uses raw DESCRIPTION)
DESCRIPTION_YAML=$(echo "$DESCRIPTION" | sed 's/"/\\"/g')
YOUTUBE_ID=$(echo "$EPISODE_JSON" | jq -r '.youtubeId')
YOUTUBE_URL=$(echo "$EPISODE_JSON" | jq -r '.youtubeUrl')
DURATION=$(echo "$EPISODE_JSON" | jq -r '.duration')
UPLOAD_DATE=$(echo "$EPISODE_JSON" | jq -r '.uploadDate')

# Audio file info
AUDIO_FILE="audio/${SLUG}.mp3"
AUDIO_URL="/podcast/audio/${SLUG}.mp3"

# YouTube thumbnail (hqdefault is 480x360, always available)
THUMBNAIL_URL="https://img.youtube.com/vi/${YOUTUBE_ID}/hqdefault.jpg"

# Get audio file size if exists
if [ -f "$AUDIO_FILE" ]; then
    AUDIO_SIZE=$(stat -f%z "$AUDIO_FILE" 2>/dev/null || stat -c%s "$AUDIO_FILE" 2>/dev/null)
else
    AUDIO_SIZE=0
fi

# Format date (YYYYMMDD -> YYYY-MM-DD)
FORMATTED_DATE="${UPLOAD_DATE:0:4}-${UPLOAD_DATE:4:2}-${UPLOAD_DATE:6:2}"

echo "Generating markdown for episode $EPISODE_NUM: $TITLE" >&2

# Paths for summary cache and slides
SUMMARY_CACHE_DIR="metadata/summaries"
mkdir -p "$SUMMARY_CACHE_DIR"
SUMMARY_CACHE="$SUMMARY_CACHE_DIR/${YOUTUBE_ID}.json"

# Slides land in ../../static/podcast/slides/${VIDEO_ID}/youtube-${VIDEO_ID}/
SLIDES_OUT_DIR="../../static/podcast/slides/${YOUTUBE_ID}"
SLIDES_JSON="${SLIDES_OUT_DIR}/youtube-${YOUTUBE_ID}/slides.json"

# Use cache if both summary JSON and slides.json exist (unless FORCE=1)
if [ -f "$SUMMARY_CACHE" ] && [ -f "$SLIDES_JSON" ] && [ "$FORCE" != "1" ]; then
    echo "  Using cached summary + slides for $YOUTUBE_ID..." >&2
    SUMMARY_JSON=$(cat "$SUMMARY_CACHE")
else
    echo "  Fetching AI summary + slides for $YOUTUBE_ID..." >&2
    if SUMMARY_JSON=$(summarize "https://youtu.be/$YOUTUBE_ID" --timestamps --slides --slides-dir "$SLIDES_OUT_DIR" --json 2>/dev/null); then
        echo "$SUMMARY_JSON" > "$SUMMARY_CACHE"
        echo "  Cached summary + slides for $YOUTUBE_ID" >&2
    else
        echo "  WARN: summarize failed for $YOUTUBE_ID, skipping summary section" >&2
        SUMMARY_JSON=""
    fi
fi

# Build the summary section using a temp Python script to avoid bash quoting issues
# (backticks and double-quotes in the heading string conflict with -c "..." syntax)
SUMMARY_SECTION=""
if [ -n "$SUMMARY_JSON" ]; then
    PY_SCRIPT=$(mktemp /tmp/podcast_summary_XXXXXX.py)
    cat > "$PY_SCRIPT" <<'PYEOF'
import json, re, sys, os

video_id = os.environ['VIDEO_ID']
slides_json_path = os.environ['SLIDES_JSON_PATH']
data = json.load(sys.stdin)
model = data.get('llm', {}).get('model', 'unknown')
raw = data.get('summary', '')

# Load slides metadata if available
slides_map = {}
if os.path.exists(slides_json_path):
    with open(slides_json_path) as f:
        slides_data = json.load(f)
    for slide in slides_data.get('slides', []):
        idx = slide['index']
        ts = int(slide['timestamp'])
        fname = slide['imagePath']
        slides_map[idx] = {'ts': ts, 'fname': fname}

def replace_ts(m):
    parts = m.group(1).split(':')
    secs = int(parts[0]) * 3600 + int(parts[1]) * 60 + int(parts[2]) if len(parts) == 3 else int(parts[0]) * 60 + int(parts[1])
    return '[{}](https://youtu.be/{}?t={})'.format(m.group(1), video_id, secs)

def replace_slide(m):
    n = int(m.group(1))
    if n not in slides_map:
        return ''
    s = slides_map[n]
    img_url = '/podcast/slides/{vid}/youtube-{vid}/{fname}'.format(vid=video_id, fname=s['fname'])
    yt_url = 'https://youtu.be/{}?t={}'.format(video_id, s['ts'])
    return '[![Slide {}]({})]({})'.format(n, img_url, yt_url)

linked = re.sub(r'\[(\d+:\d{2}(?::\d{2})?)\]', replace_ts, raw)
linked = re.sub(r'\[slide:(\d+)\]', replace_slide, linked)
heading = '## `summarize "https://youtu.be/' + video_id + '" --timestamps --slides`'
print('{}\n\n{}\n\n*Model: {}*'.format(heading, linked, model))
PYEOF

    SUMMARY_SECTION=$(VIDEO_ID="$YOUTUBE_ID" SLIDES_JSON_PATH="$SLIDES_JSON" \
        python3 "$PY_SCRIPT" <<< "$SUMMARY_JSON")
    rm -f "$PY_SCRIPT"
fi

# Generate markdown
cat > "$3" <<EOF
---
title: "$TITLE"
date: ${FORMATTED_DATE}T12:00:00Z
description: "$DESCRIPTION_YAML"
image: "$THUMBNAIL_URL"
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

$SUMMARY_SECTION
EOF
