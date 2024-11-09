---
title: GoCD versus Gitlab
date: 2023-03-08T14:33:33+08:00
description: Differences between two delivery pipelines
---

<img width=200 src="https://s.natalian.org/2023-03-08/GoCD_White_Logo@4x.png" alt="GoCD">

<img width=200 src="https://s.natalian.org/2023-03-08/gitlab-logo-400.png" alt="Gitlab">

# Operationally

GoCD agents requires Java, the server requires Java and Postgres, and often
requires manual migration steps to keep upto to date on an underlying platform.

Gitlab server is managed and the agent are called runners, which are largely
self-contained static binaries. However it does require at least Git 2.x, basic
utilities like `su` and ideally Docker for docker based builds.

# Tags

GoCD tag logic is a little counter intuitive. If you have two servers each with
a tag A and tag B respecitively, you cannot deploy to "A, B". You need to
instead create a new tag C and apply to both machines to deploy to both.

# UI

GoCD has numerous UX issues:

- Lots of modals usage
- No way to permalink a specific pipeline
- There is a focus on the <abbr title="Visual Stream Map">VSM</abbr> and allows to express interdepenecies.

Gitlab by contrast has all the builds steps in `gitlab-ci.yml` with a [handy instant visualisation](https://docs.gitlab.com/ee/ci/pipeline_editor/#visualize-ci-configuration)

# Version control

GoCD pipelines are edited via the UI form. There is no version control.
