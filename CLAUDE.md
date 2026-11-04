Hugo-based static blog hosted on AWS S3/CloudFront. Main config: `hugo.yaml`

## Build Commands

```bash
hugo              # Build site to public/
hugo server -D      # Local dev server with live reload and include draft posts
npm ci             # Install the pinned Pagefind build dependency
redo site          # Build Hugo and Pagefind, without refreshing the podcast
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

Uses a small local stylesheet in `assets/css/site.css`, minified and fingerprinted
by `layouts/partials/head.html`. Keep it minimal and readable, with system fonts
and light/dark colours. If a blog post needs extra CSS, embed styles directly in
the markdown. Search uses Pagefind after the Hugo build; see README.md for previewing it.

## Agent skills

Skills live in `.agents/skills/`; `.claude/skills` is a symlink to it, so Claude Code
and Codex share them:

- [blog](.agents/skills/blog/SKILL.md): create a blog post.
- [podcast-publishing](.agents/skills/podcast-publishing/SKILL.md): produce and publish
  an AI Infrastructure episode, from the Zoom recording to the YouTube upload
  (monetization On, AI Infrastructure playlist), S3 media, the page and feeds, and
  replacements of published audio.

## Podcast Episodes

Episodes are in `content/podcast/`, numbered chronologically (oldest = Episode 1) by
their position in the AI Infrastructure YouTube playlist. Follow the
podcast-publishing skill. Audio, artwork and transcripts must be on S3 before pushing,
because GitHub Actions cannot download from YouTube.

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
