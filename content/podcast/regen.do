#!/bin/bash
set -euo pipefail
# Regenerate every derived episode file. Use after changing default.md.do or
# metadata/episodes.json.do, then review `git diff`.
#
# Why this exists: the episode markdown and metadata/episodes.json are both
# committed (GitHub Actions can't run yt-dlp — YouTube rate-limits it — so the
# site build needs them in the repo) *and* redo targets. redo refuses to rebuild
# a target it has no record of building, and .redo/ is gitignored, so after a
# clone every episode looks like a hand-written source file:
#
#   warn 040-....md: already existing: not redoing
#
# Even `redo -f` respects that. The upshot is that editing default.md.do
# silently changes only brand-new episodes, leaving the back catalogue stale.
# Deleting the targets first is the only way to hand them back to redo.
#
# This is safe: the markdown is fully derived from metadata/cache/*.json and
# metadata/summaries/*.json, which are committed, so a regen with no pipeline
# change is a no-op in git.

redo-always

# Only the markdown, deliberately: going via `all` would also invalidate every
# transcript and re-download 41 lots of captions from YouTube for nothing. Use
# `redo all` for a new episode, or after editing transcript-corrections.sed.
shopt -s nullglob
MD_FILES=([0-9][0-9][0-9]-*.md)
shopt -u nullglob

if [ "${#MD_FILES[@]}" -eq 0 ]; then
    echo "No episode markdown to regenerate — run 'redo all' first" >&2
    exit 1
fi

echo "Removing ${#MD_FILES[@]} derived episode files so redo will own them again..." >&2
rm -f metadata/episodes.json "${MD_FILES[@]}"

redo-ifchange metadata/episodes.json
redo-ifchange "${MD_FILES[@]}"

date > "$3"
