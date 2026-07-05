#!/bin/sh
# Episode transcript: YouTube auto-captions -> clean WebVTT
# Dedupes YouTube's rolling caption cues, strips inline word-timing tags,
# applies metadata/transcript-corrections.sed
# $1 = target (e.g., .transcripts/001-episode-title.vtt)
# $2 = basename without extension

SLUG=$(basename "$2")
redo-ifchange metadata/episodes.json metadata/transcript-corrections.sed

YOUTUBE_URL=$(jq -r --arg slug "$SLUG" \
    '.[] | select(.slug == $slug) | .youtubeUrl' \
    metadata/episodes.json)

if [ -z "$YOUTUBE_URL" ] || [ "$YOUTUBE_URL" = "null" ]; then
    echo "Error: No episode found for slug $SLUG" >&2
    exit 1
fi

mkdir -p .transcripts
SUBDIR=$(mktemp -d)

yt-dlp --skip-download --write-auto-subs --sub-format vtt --sub-langs en \
    --output "$SUBDIR/sub" "$YOUTUBE_URL" >&2

RAW="$SUBDIR/sub.en.vtt"
if [ ! -f "$RAW" ]; then
    echo "WARN: no auto-captions for $SLUG, writing empty transcript" >&2
    printf 'WEBVTT\n' > "$3"
    rm -rf "$SUBDIR"
    exit 0
fi

python3 - "$RAW" <<'PYEOF' | sed -f metadata/transcript-corrections.sed > "$3"
import html, re, sys

cues = []  # (start, end, text)
cur = None
for line in open(sys.argv[1]):
    m = re.match(r'(\d\d:\d\d:\d\d\.\d\d\d) --> (\d\d:\d\d:\d\d\.\d\d\d)', line)
    if m:
        cur = (m.group(1), m.group(2))
        continue
    if cur is None:
        continue
    text = html.unescape(re.sub(r'<[^>]+>', '', line)).strip()
    if text:
        cues.append((cur[0], cur[1], text))

# YouTube repeats the previous line in each rolling cue; keep first occurrence
lines = []
last = None
for start, end, text in cues:
    if text != last:
        lines.append((start, text))
        last = text

print('WEBVTT')
print()
for i, (start, text) in enumerate(lines):
    end = lines[i + 1][0] if i + 1 < len(lines) else cues[-1][1]
    print(f'{start} --> {end}')
    print(text.replace('<', '&lt;'))
    print()
PYEOF

rm -rf "$SUBDIR"
