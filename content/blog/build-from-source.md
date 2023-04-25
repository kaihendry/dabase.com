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

**Rebuilding everytime is inefficient**, though I did consciously to ensure
the [workflow was
simple](https://gitlab.com/kaihendry/p2p-demo/-/blob/main/.gitlab-ci.yml) and
the consistent across environments.

# What's wrong with re-building?

Rebuilding every time a pipeline runs, may be:
* Wasteful
* Time consuming
* May produce different results if an underlying dependency changes

A better practice is considered to "Build once, deploy many" or <abbr
title="Build Once Deploy Anywhere">BODA</abbr> and some consider it part of the
[twelve factor app](https://12factor.net/codebase) principal. Though if you
actually read the 12factor site it will say "One codebase tracked in revision
control, many deploys".

Rebuilding can be fast if you have a good cache.

# What's wrong with <abbr title="Build Once Deploy Anywhere">BODA</abbr>?

Promoting artifacts makes pipelines complex.

Each language, framework, runtime, packaging format presents challenges. 

Higher environments now need some mechanism to pull artifacts from lower environments, or to pull artifacts from a central repository. Or perhaps lower environment need to push artifacts to higher environments.

Some artifacts can be large and now we need to create a lifecycle policy for images that do not get used.

Artifacts must be immutable and their checksum/digest tagged and ideally signed.

The source of truth becomes the artifact and not the source code.

What happens if a rebuild is needed on the same $CI_COMMIT_SHA but the checksum changes?

# Your builds aren't reproducible!

Did you ask yourself:

> May produce different results if an underlying dependency changes

> What happens if a rebuild is needed on the same $CI_COMMIT_SHA but the checksum changes?

It's because you don't have [reproducible builds](https://en.wikipedia.org/wiki/Reproducible_builds).

# How to get Reproducible builds?!

There are initiatives to get you there. The Go language helps.
[NixOS](https://nixos.org/) makes it their goal.

Though ask yourself, which CI/CD pipeline design will get you reproducible
builds faster?

1. Engineering a complex pipeline for <abbr title="Build Once Deploy Anywhere">BODA</abbr>?
2. Rebuilding your source code at each environment?

Once each build environment's output artifacts are the same from a $CI_COMMIT_SHA build source,
you can be confident that your build chain is consistent and uncompromised. Promoting artifacts aka <abbr title="Build Once Deploy Anywhere">BODA</abbr> will not give you that confidence and will make your pipelines brittle.

Achieving reproducible builds is more difficult than relying on artifacts, though it does have its inherit audit benefits as well as making CI/CD pipelines simpler.
