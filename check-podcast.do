#!/bin/sh
set -eu
redo-always
hugo >&2
python3 scripts/validate_podcast.py --deep >&2
date > "$3"
