#!/bin/sh
# Upload all audio files to S3
# Dependencies: aws cli configured

AUDIO_DIR="audio"
S3_BUCKET="s3://dabase.com/podcast/audio/"
S3_REGION="ap-southeast-1"

if [ ! -d "$AUDIO_DIR" ]; then
    echo "No audio directory found" >&2
    exit 0
fi

echo "Syncing audio files to S3..." >&2

# Upload only changed files
aws s3 sync "$AUDIO_DIR/" "$S3_BUCKET" \
    --region "$S3_REGION" \
    --exclude ".*" \
    --content-type "audio/mpeg" \
    --metadata-directive REPLACE \
    --cache-control "public, max-age=31536000" \
    --only-show-errors

echo "Audio files synced to $S3_BUCKET" >&2

# Create a marker file to indicate completion
date > "$3"
