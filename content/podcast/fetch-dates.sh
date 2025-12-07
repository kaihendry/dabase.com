#!/bin/bash
cd "$(dirname "$0")"

jq -c '.[]' metadata/episodes.json | while read episode; do
  url=$(echo "$episode" | jq -r '.youtubeUrl')
  slug=$(echo "$episode" | jq -r '.slug')

  echo "Fetching date for $slug..."
  date=$(yt-dlp --skip-download --print "%(upload_date)s" "$url" 2>/dev/null)

  if [ -n "$date" ] && [ "$date" != "null" ]; then
    # Update markdown file with correct date
    formatted="${date:0:4}-${date:4:2}-${date:6:2}"
    sed -i.bak "s/date: 2024-11-30T12:00:00Z/date: ${formatted}T12:00:00Z/" "${slug}.md"
    echo "  Updated to $formatted"
  fi
done

rm -f *.bak
echo "Done!"
