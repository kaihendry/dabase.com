#!/bin/sh
set -eu
redo-always
npm run build >&2
date > "$3"
