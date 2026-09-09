#!/bin/bash
set -euo pipefail
redo-always
# Refresh before traversing episode dependencies: goredo can otherwise check
# always-targets against the old playlist during its out-of-date scan.
redo metadata/episodes.json
redo pages upload-audio upload-images upload-transcripts
date > "$3"
