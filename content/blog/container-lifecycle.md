---
title: Container Lifecycle
date: 2023-04-27T05:27:00+08:00
description: Container repository tagging for Build Once, Deploy Anywhere
---

In a Docker container delivery CI/CD pipeline with <abbr title="Build Once, Deploy Anywhere">BODA</abbr>, we need to promote the container image artifact from one environment to the next. Instead of [simply building from source](/blog/2023/build-from-source/).

Once the artifact life is up, we need to clean it up, **delete it**. Though without deleting it whilst in use, causing a common **CannotPullContainerError** outage.

What are our requirements?

1. A clear mapping to the commit SHA that was used to build the image
2. The digest of the image does not change
3. When the image whilst on its [path to production](https://youtu.be/3DV7m0_R23Q) is tested or signed off on
4. We need to know which image is running in production
5. We need to know which image was running in production for a rollback

> “Latest” simply means “the last build/tag that ran without a specific tag/version specified”.

https://medium.com/@mccode/the-misunderstood-docker-tag-latest-af3babfd6375

<img src="https://s.natalian.org/2023-04-27/lifecycle.svg">

{{< tweet user="nathankpeck" id="1650552853835001865" >}}

# Watch out

[It's non-trivial to delete a tag](https://github.com/containers/skopeo/issues/1432), you might delete the whole artifact!