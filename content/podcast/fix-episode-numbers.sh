#!/bin/bash
cd "$(dirname "$0")"

jq -c '.[]' metadata/episodes.json | while read episode; do
  slug=$(echo "$episode" | jq -r '.slug')
  ep_num=$(echo "$episode" | jq -r '.episode')

  if [ -f "${slug}.md" ]; then
    sed -i.bak "s/episode: [0-9]*/episode: $ep_num/" "${slug}.md"
    echo "Updated $slug to episode $ep_num"
  fi
done

rm -f *.bak
echo "Done!"
