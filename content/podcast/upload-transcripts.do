#!/bin/bash
set -euo pipefail
# Upload episode transcripts to S3
# Dependencies: aws cli configured

# See upload-audio.do: without redo-always the marker file makes this a no-op
# forever, so corrected transcripts silently never reach S3, and without
# depending on the files themselves the sync can run before they are rebuilt —
# which is how a transcript-corrections.sed edit shipped the uncorrected text.
redo-always

redo-ifchange metadata/episodes.json
# A read loop rather than mapfile: /bin/bash on macOS is 3.2, no mapfile there
SLUG_LIST=$(jq -r '.[].slug' metadata/episodes.json)
TRANSCRIPT_FILES=()
while IFS= read -r SLUG; do
    [ -n "$SLUG" ] && TRANSCRIPT_FILES+=(".transcripts/${SLUG}.vtt" ".transcripts/${SLUG}.txt")
done <<< "$SLUG_LIST"

redo-ifchange "${TRANSCRIPT_FILES[@]}"

TRANSCRIPTS_DIR=".transcripts"
S3_BUCKET="s3://dabase.com/podcast/transcripts/"
S3_REGION="ap-southeast-1"

if [ ! -d "$TRANSCRIPTS_DIR" ]; then
    echo "No transcripts directory found" >&2
    exit 0
fi

echo "Syncing transcripts to S3..." >&2

# Short cache: transcripts get corrected in place at the same URL
for ext_type in "vtt:text/vtt" "txt:text/plain"; do
    EXT="${ext_type%%:*}"
    TYPE="${ext_type#*:}"
    aws s3 sync "$TRANSCRIPTS_DIR/" "$S3_BUCKET" \
        --profile "${AWS_PROFILE:-mine}" \
        --region "$S3_REGION" \
        --exclude "*" \
        --include "*.${EXT}" \
        --content-type "${TYPE}; charset=utf-8" \
        --metadata-directive REPLACE \
        --cache-control "public, max-age=86400" \
        --only-show-errors
done

echo "Transcripts synced to $S3_BUCKET" >&2

date > "$3"
