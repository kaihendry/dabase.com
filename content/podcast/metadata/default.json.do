#!/bin/bash
set -euo pipefail
# Recheck one episode before goredo decides whether its dependants changed.
redo-always
redo-ifchange episodes.json

# Artwork's -wide suffix is an alias; an exact episode slug takes precedence.
jq -ce --arg slug "$(basename "$2")" '
    (map(select(.slug == $slug)) | first) //
    (map(select(.audioSlug == $slug)) | first) //
    (map(select(.slug == ($slug | rtrimstr("-wide")))) | first) //
    error("Unknown episode: " + $slug)
' episodes.json > "$3"
