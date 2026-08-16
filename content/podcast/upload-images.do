#!/bin/bash
set -euo pipefail
# Upload episode artwork to S3
# Dependencies: aws cli configured

# See upload-audio.do: without redo-always the marker file makes this a no-op
# forever, so new artwork silently never reaches S3, and without depending on
# the files themselves the sync can run before they are built.
redo-always

redo-ifchange metadata/episodes.json
# A read loop rather than mapfile: /bin/bash on macOS is 3.2, no mapfile there
SLUG_LIST=$(jq -r '.[].slug' metadata/episodes.json)
IMAGE_FILES=()
while IFS= read -r SLUG; do
    [ -n "$SLUG" ] && IMAGE_FILES+=(".images/${SLUG}.jpg" ".images/${SLUG}-wide.jpg")
done <<< "$SLUG_LIST"

redo-ifchange "${IMAGE_FILES[@]}"

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
