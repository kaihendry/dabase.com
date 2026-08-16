#!/bin/bash
set -euo pipefail
# Generate markdown file for an episode
# $1 = target (e.g., 001-episode-title.md)
# $2 = basename without extension (e.g., 001-episode-title)

SLUG=$(basename "$2")
# The corrections also clean the AI summary, which summarize generates from its
# own caption fetch — so caption errors ("Kira Crew") reach the page and the
# meta description, not just the transcripts
redo-ifchange metadata/episodes.json metadata/transcript-corrections.sed

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
AUDIO_FILE=".audio/${SLUG}.mp3"
AUDIO_URL="https://dabase.com/podcast/audio/${SLUG}.mp3"

# Self-hosted artwork (both built by default.jpg.do); URLs must change for
# Spotify/Apple to re-fetch, so never point at img.youtube.com here.
# image: square, for the feed's itunes:image. thumbnail: 16:9, for web + OG.
THUMBNAIL_URL="https://dabase.com/podcast/images/${SLUG}.jpg"
WIDE_URL="https://dabase.com/podcast/images/${SLUG}-wide.jpg"

# Build the audio before reading its size. all.do generates markdown before
# downloading audio, so without this a new episode's first build wrote
# audioSize: 0 — a zero-length RSS enclosure that no test catches.
if ! redo-ifchange "$AUDIO_FILE"; then
    echo "Error: could not build $AUDIO_FILE" >&2
    exit 1
fi

AUDIO_SIZE=$(stat -f%z "$AUDIO_FILE" 2>/dev/null || stat -c%s "$AUDIO_FILE" 2>/dev/null)
if [ -z "$AUDIO_SIZE" ] || [ "$AUDIO_SIZE" = "0" ]; then
    echo "Error: $AUDIO_FILE is missing or empty, refusing to write audioSize: 0" >&2
    exit 1
fi

# Prefer YouTube's exact publish time. A hardcoded time-of-day (we used to use
# noon) puts same-day episodes in the future, and Hugo silently drops those.
PUBLISHED=$(jq -r '.timestamp // empty' "metadata/cache/${YOUTUBE_ID}.json" 2>/dev/null)
if [ -n "$PUBLISHED" ]; then
    PUB_DATE=$(date -u -r "$PUBLISHED" "+%Y-%m-%dT%H:%M:%SZ" 2>/dev/null \
        || date -u -d "@$PUBLISHED" "+%Y-%m-%dT%H:%M:%SZ")
else
    PUB_DATE="${UPLOAD_DATE:0:4}-${UPLOAD_DATE:4:2}-${UPLOAD_DATE:6:2}T00:00:00Z"
fi

# No draft: key is ever emitted. Videos in the playlist that aren't real
# episodes (see NON_EPISODES in all.do) simply don't get a markdown file.

echo "Generating markdown for episode $EPISODE_NUM: $TITLE" >&2

# Paths for summary cache and slides
SUMMARY_CACHE_DIR="metadata/summaries"
mkdir -p "$SUMMARY_CACHE_DIR"
SUMMARY_CACHE="$SUMMARY_CACHE_DIR/${YOUTUBE_ID}.json"

# Slides land in ../../static/podcast/slides/${VIDEO_ID}/youtube-${VIDEO_ID}/
SLIDES_OUT_DIR="../../static/podcast/slides/${YOUTUBE_ID}"
SLIDES_JSON="${SLIDES_OUT_DIR}/youtube-${YOUTUBE_ID}/slides.json"

# Use cache if both summary JSON and slides.json exist (unless FORCE=1)
if [ -f "$SUMMARY_CACHE" ] && [ -f "$SLIDES_JSON" ] && [ "${FORCE:-}" != "1" ]; then
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
        python3 "$PY_SCRIPT" <<< "$SUMMARY_JSON" \
        | sed -f metadata/transcript-corrections.sed)
    rm -f "$PY_SCRIPT"
fi

# Frontmatter description: this is the page's meta description, the Open Graph
# description and the podcast feed's episode summary. When the YouTube
# description is nothing but a chapter list ("0:00 Intro", ...) that makes a
# useless one, so drop the chapter lines and fall back to the AI summary's
# opening sentences.
PY_DESC=$(mktemp /tmp/podcast_desc_XXXXXX.py)
cat > "$PY_DESC" <<'PYEOF'
import json, os, re, sys

LIMIT = 300
# Lines that carry no prose: chapter markers, and lines that are a bare URL
# (some descriptions are nothing but links to what we discussed)
chapter = re.compile(r'^\s*\d{1,2}:\d{2}(?::\d{2})?\s+\S')
bare_url = re.compile(r'^\s*<?https?://\S+>?\s*$')

def clean(text):
    text = re.sub(r'!?\[([^\]]*)\]\([^)]*\)', r'\1', text)   # links/images -> label
    text = re.sub(r'[*_`#>]', '', text)                      # markdown emphasis
    return re.sub(r'\s+', ' ', text).strip()

def truncate(text):
    if len(text) <= LIMIT:
        return text
    cut = text[:LIMIT]
    # Prefer a sentence boundary, else the last whole word
    end = max(cut.rfind('. '), cut.rfind('! '), cut.rfind('? '))
    if end > LIMIT // 3:
        return cut[:end + 1]
    return cut[:cut.rfind(' ')].rstrip(',;:') + '...'

prose = clean('\n'.join(
    line for line in os.environ.get('DESCRIPTION', '').split('\n')
    if line.strip() and not chapter.match(line) and not bare_url.match(line)))

if not prose:
    raw = sys.stdin.read().strip()
    if raw:
        prose = clean(json.loads(raw).get('summary', '').split('\n')[0])

print(truncate(prose))
PYEOF

DESCRIPTION_YAML=$(DESCRIPTION="$DESCRIPTION" python3 "$PY_DESC" <<< "$SUMMARY_JSON" \
    | sed -f metadata/transcript-corrections.sed | sed 's/"/\\"/g')
rm -f "$PY_DESC"

if [ -z "$DESCRIPTION_YAML" ]; then
    echo "  WARN: no usable description for $SLUG" >&2
fi

# The description goes into the body verbatim, but Markdown collapses single
# newlines, so a chapter list renders as one run-together paragraph. Turn
# "12:34 Title" lines into a list linking into the video; leave the rest alone.
PY_BODY=$(mktemp /tmp/podcast_body_XXXXXX.py)
cat > "$PY_BODY" <<'PYEOF'
import os, re, sys

video_id = os.environ['VIDEO_ID']
chapter = re.compile(r'^\s*(\d{1,2}:\d{2}(?::\d{2})?)\s+(\S.*?)\s*$')

def to_secs(stamp):
    p = [int(x) for x in stamp.split(':')]
    return p[0] * 3600 + p[1] * 60 + p[2] if len(p) == 3 else p[0] * 60 + p[1]

out = []
for line in sys.stdin.read().split('\n'):
    m = chapter.match(line)
    if m:
        out.append('- [{}](https://youtu.be/{}?t={}) {}'.format(
            m.group(1), video_id, to_secs(m.group(1)), m.group(2)))
    else:
        out.append(line)
print('\n'.join(out).strip())
PYEOF

DESCRIPTION_BODY=$(VIDEO_ID="$YOUTUBE_ID" python3 "$PY_BODY" <<< "$DESCRIPTION" \
    | sed -f metadata/transcript-corrections.sed)
rm -f "$PY_BODY"

# Generate markdown
cat > "$3" <<EOF
---
title: "$TITLE"
date: $PUB_DATE
description: "$DESCRIPTION_YAML"
image: "$THUMBNAIL_URL"
thumbnail: "$WIDE_URL"

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

$DESCRIPTION_BODY

[Watch on YouTube]($YOUTUBE_URL)

$SUMMARY_SECTION
EOF
