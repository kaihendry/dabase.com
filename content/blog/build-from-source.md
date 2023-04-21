---
title: Build From Source
date: 2023-04-21T09:51:59+08:00
description: Instead of promoting artifacts, why not build from source?
---

A critique of my Gitlab Path to Production video is that it **builds and tests**
for every deployment whether it be:

1. Development (dev)
2. Staging (stg)
3. Production (prd)

{{< youtube 3DV7m0_R23Q >}}

I've also blogged about [Path to Production](/blog/2022/path-to-production/)
where I essentially promote source code through three (eventually consistent)
git repos mapped to three AWS accounts mapped to three environments: dev, stg,
prd.

# What's wrong with re-building?

Rebuilding everytime a pipeline runs, may be:
* Wasteful
* Time consuming
* May produce different results if an underlying dependency changes

A better practice is considered to "Build once, deploy many" or <abbr
title="Build Once Deploy Anywhere">BODA</abbr> and some consider it part of the
[twelve factor app](https://12factor.net/codebase) principal. Though if you
actually read the 12factor site it will say "One codebase tracked in revision
control, many deploys".

# What's wrong with <abbr title="Build Once Deploy Anywhere">BODA</abbr>?

Promoting artifacts makes pipelines complex.

Each language, framework, runtime, packaging format presents challenges. 

Higher environments now need to break isolation to be able to retrieve lower
environment artifacts.

Some artifacts can be large and now we need to keep/track copies somewhere since
someone might need them.

Artifacts must be immutable and their checksum tracked carefully.

What happens if a rebuild is needed on the same $CI_COMMIT_SHA but the checksum changes?

# Your builds aren't reproduciable!

Did you ask yourself:

> May produce different results if an underlying dependency changes

> What happens if a rebuild is needed on the same $CI_COMMIT_SHA but the checksum changes?

It's because you don't have [reproduciable builds](https://en.wikipedia.org/wiki/Reproducible_builds).

# How to get Reproduciable builds?!

There are initatives to get you there. The Go language helps.
[NixOS](https://nixos.org/) makes it their goal.

Though ask yourself, which CI/CD pipeline design will get you reproduciable
builds faster?

1. Engineering a complex pipeline for <abbr title="Build Once Deploy Anywhere">BODA</abbr>?
2. Rebuilding your source code at each environment?
