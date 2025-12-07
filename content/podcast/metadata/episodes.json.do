#!/bin/sh
# Process playlist.json into episodes.json
# Assigns episode numbers, generates slugs, structures data

redo-ifchange metadata/playlist.json

echo "Processing playlist metadata..." >&2

jq '[
  to_entries | .[] |
  {
    episode: (.key + 1),
    season: 1,
    title: .value.title,
    description: (.value.description // ""),
    youtubeId: .value.id,
    youtubeUrl: "https://www.youtube.com/watch?v=\(.value.id)",
    uploadDate: .value.upload_date,
    duration: .value.duration,
    slug: (
      ((.key + 1) | tostring | ("000" + .) | .[-3:]) +
      "-" +
      (.value.title | ascii_downcase | gsub("[^a-z0-9]+"; "-") | gsub("^-|-$"; ""))
    )
  }
]' metadata/playlist.json > "$3"

EPISODE_COUNT=$(jq 'length' "$3")
echo "Processed $EPISODE_COUNT episodes" >&2
