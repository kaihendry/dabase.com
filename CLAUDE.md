**Note**: This project uses [bd (beads)](https://github.com/steveyegge/beads) for issue tracking. Use `bd` commands instead of markdown TODOs.

Hugo-based static blog hosted on AWS S3/CloudFront. Main config: `hugo.yaml`

## Build Commands

```bash
hugo              # Build site to public/
hugo server -D      # Local dev server with live reload and include draft posts
```

In general we like to use [redo](http://www.goredo.cypherpunks.su/) instead of Make to build. See https://redo.readthedocs.io/en/latest/cookbook/hello/ for a short tutorial.

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