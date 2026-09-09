#!/bin/sh
# Build everything for publishing
# Usage: redo
set -eu

echo "=== Syncing podcast from YouTube ===" >&2
redo-ifchange content/podcast/all

echo "=== Building Hugo site and search index ===" >&2
redo-ifchange site

echo "=== Done! ===" >&2
echo "Run 'git add -A && git commit -m \"Update podcast\" && git push' to publish" >&2
