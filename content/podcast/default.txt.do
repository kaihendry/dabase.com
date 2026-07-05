#!/bin/sh
# Plain-text transcript derived from the WebVTT, for on-page rendering
# $1 = target (e.g., .transcripts/001-episode-title.txt)

SLUG=$(basename "$2")
VTT=".transcripts/${SLUG}.vtt"
redo-ifchange "$VTT"

awk '!/-->/ && !/^WEBVTT/ && NF' "$VTT" > "$3"
