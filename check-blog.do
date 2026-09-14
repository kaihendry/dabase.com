#!/bin/sh
set -eu
redo-always
redo site
python3 scripts/validate_blog.py >&2
date > "$3"
