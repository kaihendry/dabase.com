---
title: Gitlab Workflow
date: 2022-12-07T09:59:40+08:00
---

When making a change my workflow is:

1. `git status` to see if every
1. `git branch` to check which is likely the "main" branch
1. `git checkout main` - switch to "main" branch
1. `git pull` make sure I'm working with the latest
1. `git checkout -b $name-of-thing-I-will-work-on` - wish I could say naming the branch is easy
1. [Stage a prefect commit](https://simonwillison.net/2022/Oct/29/the-perfect-commit/)
1. `git commit` with [Jira tag], often requires a look up in a browser because I can't remember
1. git push
1. Follow push message: `To create a merge request for $name-of-thing-I-will-work, visit:`
1. Click create <abbr title="Merge Request">MR</abbr> and remove weird closes [Jira tag] in description autofilled by Gitlab 🤷
1. Click **Approve** if I can, otherwise goto slack and paste URL for someone to hopefully review
1. Try merge if I can (after CI is complete, wait ~5mins)
1. Back to terminal, perhaps delete merge branch
