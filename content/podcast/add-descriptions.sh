#!/bin/bash
cd "$(dirname "$0")"

for md in 00*.md; do
  if [ -f "$md" ]; then
    # Extract title
    title=$(grep '^title:' "$md" | sed 's/title: "\(.*\)"/\1/')

    # Replace empty description with title
    sed -i.bak "s/^description: \"\"$/description: \"$title\"/" "$md"
    echo "Updated $md"
  fi
done

rm -f *.bak
echo "Done!"
