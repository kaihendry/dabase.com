#!/bin/bash
set -euo pipefail
redo-ifchange metadata/episodes.json

# Videos kept in the playlist for episode-numbering continuity but which aren't
# real episodes. They get no markdown file at all — we don't use Hugo drafts.
NON_EPISODES='["X-SEYqhB7Rw"]'

# Generate episode pages; each page depends on its audio.
echo "Generating episode markdown files..." >&2
# Capture first, then split: inlining this as redo-ifchange $(jq ...) would turn
# a failing jq into "redo-ifchange" with no arguments, which builds nothing and
# reports success. set -o pipefail only helps if the failure is in an assignment.
MD_LIST=$(jq -r --argjson skip "$NON_EPISODES" \
    '.[] | select(.youtubeId | IN($skip[]) | not) | .slug' metadata/episodes.json | sed 's/$/.md/')
# A read loop rather than mapfile: /bin/bash on macOS is 3.2, where mapfile
# does not exist
MD_FILES=()
while IFS= read -r LINE; do
    [ -n "$LINE" ] && MD_FILES+=("$LINE")
done <<< "$MD_LIST"

if [ "${#MD_FILES[@]}" -eq 0 ] || [ -z "${MD_FILES[0]}" ]; then
    echo "Error: no episodes found in metadata/episodes.json" >&2
    exit 1
fi

redo-ifchange "${MD_FILES[@]}"

date > "$3"
