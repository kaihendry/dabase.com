**Note**: This project uses [bd (beads)](https://github.com/steveyegge/beads) for issue tracking. Use `bd` commands instead of markdown TODOs.

Hugo-based static blog hosted on AWS S3/CloudFront. Main config: `hugo.yaml`

## Build Commands

```bash
hugo              # Build site to public/
hugo server -D      # Local dev server with live reload and include draft posts
```

In general we like to use [redo](https://goredo.dabase.com/) instead of
Make to build. See https://redo.readthedocs.io/en/latest/cookbook/hello/ for a
short tutorial.

## Link Checking

A pre-commit hook checks links in staged Markdown files using
[lychee](https://lychee.cli.rs/) (`brew install lychee`). Enable it once per clone:

```bash
git config core.hooksPath .githooks
```

Note: this only catches real HTTP errors (404s, timeouts). Some sites (e.g. octopus.energy)
return HTTP 200 for any path ("soft 404"), so broken links there won't be caught automatically —
double check those by hand.

## Deployment

Push to `main` branch triggers GitHub Actions workflow that:
1. Builds Hugo site
2. Syncs to S3 bucket `dabase.com`
3. Invalidates CloudFront cache

## Content Structure

- `content/blog/` - Blog posts, permalinks: `/blog/:year/:contentbasename/`
- `content/tips/` - Tips section, permalinks: `/:sections/:year/:title/`
- `content/podcast/` - Podcast episodes, permalinks: `/podcast/:contentbasename/`

## Styling Philosophy

Uses minimal [new.css](https://newcss.net/) framework loaded in `layouts/partials/head.html`. If a blog post needs extra CSS, embed styles directly in the markdown.

## Podcast Episodes

Episode numbers are chronological (oldest = Episode 1). Episodes stored in `content/podcast/` with frontmatter containing episode number, audio URL, YouTube link, and duration.

### Adding New Podcast Episodes

**IMPORTANT**: Audio files MUST be uploaded to S3 before pushing to GitHub, since GitHub Actions cannot download from YouTube due to rate limiting.

Workflow for new episodes:
```bash
cd content/podcast

# 1. Fetch metadata and build (uses cache, only fetches new episodes)
redo all

# 2. Upload audio to S3 (CRITICAL - do this before git push!)
redo upload-audio

# 3. Verify upload
aws s3 ls s3://dabase.com/podcast/audio/ --human-readable | tail -5

# 4. Commit and push
git add .
git commit -m "Add Episode X"
git push
```

**Cache system**: Episode metadata is cached in `metadata/cache/{video_id}.json` to speed up builds from ~22min to ~3min. Use `FORCE=1 redo metadata/episodes.json` to bypass cache and refetch all episodes.

**Transcripts**: Cleaned YouTube auto-captions, built by `default.vtt.do`/`default.txt.do` into `.transcripts/` and synced to `s3://dabase.com/podcast/transcripts/` (referenced by `<podcast:transcript>` in the feed and rendered on episode pages). Recurring caption errors (e.g. "Cloud Code" → "Claude Code") are fixed in `metadata/transcript-corrections.sed`; after editing it, rebuild with `redo .transcripts/*.vtt .transcripts/*.txt && redo upload-transcripts`.

**YouTube bot detection**: If `yt-dlp` is blocked ("Sign in to confirm you're not a bot"), use Chrome cookies:
- Fetch metadata: `yt-dlp --cookies-from-browser chrome -j --no-warnings --skip-download "URL" > metadata/cache/VIDEO_ID.json`
- Download audio: `yt-dlp --cookies-from-browser chrome --extract-audio --audio-format mp3 --audio-quality 192K --output ".audio/SLUG" --no-playlist "URL"`
- Generate summary: `SUMMARIZE_YT_DLP_COOKIES_FROM_BROWSER=chrome summarize "URL" --timestamps --slides ...`

**Future dates**: Hugo doesn't build content with future dates by default. If a new episode isn't appearing, check that its `date:` in frontmatter isn't in the future (dates are in UTC).

# AWS access

If aws credentials are not available like:

    dabase.com $ sts
    {
        "UserId": "AROAV5XVAVSZGQSIGP7TI:hendry",
        "Account": "407461997746",
        "Arn": "arn:aws:sts::407461997746:assumed-role/AWSReservedSSO_AdministratorAccess_faa8fd51f242b1ab/hendry"
    }
    dabase.com $ alias sts
    alias sts='aws sts get-caller-identity'

Prompt the user to run `aws sso login --profile mine`

# Debugging Github workflows

Given for example:
    https://github.com/kaihendry/dabase.com/actions/runs/20007003839/job/57370782882

use:
    gh run view --log --job=57370782882
