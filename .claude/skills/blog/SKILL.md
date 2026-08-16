---
name: blog
description: Create a new blog post for dabase.com using Hugo with SEO-friendly title and description
---

# Blog Post Creation Skill

You are helping the user create a new blog post for their Hugo-based blog at dabase.com.

## Your Task

1. **Determine the current year**:
   - Run: `date +%Y` to get the current year dynamically

2. **Ask the user** for:
   - What is the blog post about? (Get a detailed description of the topic/content)
   - What title do they want? (Or offer to generate one based on the topic)

3. **Generate an SEO-friendly title and description**:
   - Create a concise, compelling title if they don't provide one
   - Write a brief, SEO-optimized description (1-2 sentences) based on what the blog is about
   - Confirm both with the user before proceeding

4. **Generate the filename** from the title:
   - Convert to lowercase
   - Replace spaces with hyphens
   - Remove special characters (keep only alphanumeric and hyphens)
   - Example: "My Great Post!" → "my-great-post.md"

5. **Create the blog post** using Hugo:
   - Run: `hugo new content/blog/YEAR/[filename].md` (where YEAR is from step 1)
   - Hugo will automatically create the file with the correct frontmatter

6. **Update the frontmatter**:
   - Read the newly created file
   - Update the `title` field with the confirmed title
   - Update the `description` field with the SEO-friendly description
   - Keep the auto-generated `date` field

7. **Confirm completion**:
   - Show the file path: `content/blog/YEAR/filename.md`
   - Let them know they can start writing content
   - Suggest running `hugo server` to preview if needed

## Publishing gotchas — check these when a post won't render

Hugo silently drops content instead of erroring, so "it built fine but the page
isn't there" is nearly always one of these two:

1. **A `date` in the future.** Compare against `date -u`, not local time — BST/SGT
   local time is ahead of UTC, so a post stamped `T12:00:00Z` at 11:20 UTC is
   invisible until noon. Never hardcode a time of day; use the real publish
   instant. This bit the podcast generator (`content/podcast/default.md.do`),
   which now reads YouTube's `.timestamp` from the metadata cache.
2. **A `draft:` key.** We don't use Hugo drafts at all — they slow things down.
   Omit the key entirely; don't write `draft: false`. To keep something out of
   the feed, don't generate a file for it (see `NON_EPISODES` in
   `content/podcast/all.do`).
3. **A podcast episode missing from the YouTube playlist.** `redo all` discovers
   episodes solely by enumerating the "AI Infrastructure" playlist
   (`PLiKgVPlhUNuyTXzN03gCB1lqvaHXxPLak`) in `metadata/episodes.json.do`, and
   episode numbers come from position in it — reversed, so the newest video
   becomes the highest number. A published-but-unlisted video generates no
   markdown at all and the build looks like a no-op. Add it to the playlist
   rather than working around the script.

## Changing the podcast generator

The episode markdown and `metadata/episodes.json` are committed *and* are redo
targets, because GitHub Actions can't run `yt-dlp` (YouTube rate-limits it) so
the site build needs them in the repo. redo won't rebuild a target it has no
record of building, `.redo/` is gitignored, and `redo -f` respects that too:

    warn 040-benchmarking-ai-infrastructure.md: already existing: not redoing

So editing `default.md.do` appears to work while silently changing only
brand-new episodes. Run `redo regen` (see `regen.do`) to delete the derived
files and rebuild the whole back catalogue, then review `git diff`. With no
pipeline change a regen is a no-op in git, which is the signal it worked.

After publishing, verify rather than assume — `hugo --quiet` then confirm the
page and, for podcasts, that `grep -c '<item>' public/podcast/index.xml` matches
the number of episode files. CI (`.github/workflows/test.yml`) enforces that.

## Important Notes
- Use `date +%Y` to dynamically determine the current year
- Use Hugo's `hugo new` command to bootstrap the post
- Generate SEO-friendly titles and descriptions
- Confirm the title and description with the user before creating the file
