---
title: Path to Production
date: 2022-05-21T06:52:21+08:00
description: The devil in the details in your deployment pipeline
---

<img src="https://s.natalian.org/2022-05-23/path-to-production.png" alt="Path to Production">

Assuming a {<abbr title="Development">dev</abbr>,<abbr
title="Staging">stg</abbr>,<abbr title="Production">prd</abbr>} account (three AWS accounts), **how
does a cross functional service team deploy to production** in a rigorous manner?

1. Develop and commit to dev
2. Cut a dev commit to staging
3. Promote a tested staging commit to production

# The simplest way to do it

Each {dev,stg,prd} account has an AWS Code{Commit,Build,Pipeline} that triggers
a build/deployment pipeline once code has been pushed to it.

The workflow is simple:

1. git commit and git push # dev is default
2. git push stg <commit> # cut a dev commit to staging account
3. git push prd <commit> # promote same commit to production

Pros:

- Simple
- Code is the source of truth
- Dependencies tracked with a lock file
- Full git history with integrity
- Easy to add Approval stage for <abbr title="Product Owner">PO</abbr> sign-off in the Production account
- Changes happen via Git API
- Minimises code duplication (no difference between environments given a commit)

Cons:

- In each Environment a **build is required** and that might be slow or non-reproducible in some languages
- Without some trivial checks in place (check stg has commit) or approval stages, a `git push prd` could happen
- Each stack (e.g. Infra, App) typically is a separate Code{Commit,Build,Pipeline} and inevitably some manual co-ordination will be needed. I.e. Infra pushed before App

# Using Github

Workflows are great, but to effectively deploy to your {dev,stg,prd}
environments, **Github needs to assume an Administrator role across your Service accounts**!

Pros:

- Workflows have far more mindshare that AWS's basic buildspec.yml
- Github comes with lot of great developer experiences

Cons:

- Could dissuade teams from using trunk based development
- Github effectively has a back door to your entire service which is a security risk

# Using some CI/CD tool in a dedicated account in your AWS Organisation

Also described as a [One stack definition managed with a
pipeline](https://medium.com/@kief/https-medium-com-kief-using-pipelines-to-manage-environments-with-infrastructure-as-code-b37285a1cbf5),
however the problem is that "the pipeline" is often centralised unlike "The simplest way to do it"
above, where the pipeline is minimal, native to each AWS account and driven exclusively via `git push`.

Pros:

- **Focuses on build artefacts** which might be easier to work with than code
- Should speed up the pipelines, since we are working with artifacts
- Should allow for more complex workflows with (non-code) dependencies et al
- Guarantees that every change has been applied to each environment (i.e. less mistakes)
- Often comes with a nice dashboard and visualisation map

Cons:

- The fact that it can accommodate more complexity, means that **the CI/CD server will be far more complex**
- The CI/CD tool becomes over arching and bloated, responsible for co-ordinating the whole path with roles to deploy in their respective environment
- CI/CD and artefact store is typically **centralised** which can become a bottle neck or security target
- Source of truth might be less obvious
