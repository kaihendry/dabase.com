#!/bin/sh
# Upload episode artwork to S3
# Dependencies: aws cli configured

IMAGES_DIR=".images"
S3_BUCKET="s3://dabase.com/podcast/images/"
S3_REGION="ap-southeast-1"

if [ ! -d "$IMAGES_DIR" ]; then
    echo "No images directory found" >&2
    exit 0
fi

echo "Syncing episode artwork to S3..." >&2

aws s3 sync "$IMAGES_DIR/" "$S3_BUCKET" \
    --profile "${AWS_PROFILE:-mine}" \
    --region "$S3_REGION" \
    --exclude ".*" \
    --content-type "image/jpeg" \
    --metadata-directive REPLACE \
    --cache-control "public, max-age=31536000" \
    --only-show-errors

echo "Episode artwork synced to $S3_BUCKET" >&2

date > "$3"
