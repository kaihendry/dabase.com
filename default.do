#!/bin/sh
# Build everything for publishing
# Usage: redo

echo "=== Syncing podcast from YouTube ===" >&2
redo-ifchange content/podcast/all

echo "=== Building Hugo site ===" >&2
hugo

echo "=== Done! ===" >&2
echo "Run 'git add -A && git commit -m \"Update podcast\" && git push' to publish" >&2
