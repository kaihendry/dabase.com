#!/bin/sh
# Upload all audio files to S3
# Dependencies: aws cli configured

# This target's only output is the marker file below, so without redo-always
# redo considers it up to date forever and silently stops syncing — a new
# episode's audio never reaches S3 while the build still reports success.
# The sync itself is a cheap no-op when nothing changed.
redo-always

# Depend on what we upload, or redo is free to run this sync *before* building
# the files — which uploads the previous version and reports success.
redo-ifchange metadata/episodes.json
redo-ifchange $(jq -r '.[].slug' metadata/episodes.json | sed 's|.*|.audio/&.mp3|')

AUDIO_DIR=".audio"
S3_BUCKET="s3://dabase.com/podcast/audio/"
S3_REGION="ap-southeast-1"

if [ ! -d "$AUDIO_DIR" ]; then
    echo "No audio directory found" >&2
    exit 0
fi

echo "Syncing audio files to S3..." >&2

# Upload only changed files
aws s3 sync "$AUDIO_DIR/" "$S3_BUCKET" \
    --profile "${AWS_PROFILE:-mine}" \
    --region "$S3_REGION" \
    --exclude ".*" \
    --content-type "audio/mpeg" \
    --metadata-directive REPLACE \
    --cache-control "public, max-age=31536000" \
    --only-show-errors

echo "Audio files synced to $S3_BUCKET" >&2

# Create a marker file to indicate completion
date > "$3"
