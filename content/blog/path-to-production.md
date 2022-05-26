---
title: Path to Production
date: 2022-05-21T06:52:21+08:00
description: The devil in the details in your deployment pipeline
---

<img src="https://s.natalian.org/2022-05-23/path-to-production.png" alt="Path to Production">

> A common pattern is that a single group within the organization is
> responsible for both: designing the organization, vending accounts and
> implementing the security control. this group/team could use org-formation to
> do all of this using git-ops.

> Service teams would get vended a set of accounts (e.g: dev, stg,
> prd) that contain it-security guardrails (e.g. predefined roles that can be
> assumed) or other resources that are commonly used within the organization. An
> example of this could be integration with CI/CD. Service teams would use the
> accounts (dev, stg, prd) to develop software, typically with a different IaC
> solution (e.g terraform or cdk). These tools offer better ergonomics for
> application development. - [Olaf Conijn](https://twitter.com/OConijn)

Assuming three accounts {<abbr title="Development">dev</abbr>,<abbr
title="Staging">stg</abbr>,<abbr title="Production">prd</abbr>} accounts, **how
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
- Dependencies tracked with a lock file or "vendored"
- Full git history with integrity
- Easy to add Approval stage for <abbr title="Product Owner">PO</abbr> sign-off in the Production account
- Changes happen via Git API
- Minimises code duplication (no difference between environments given a commit)
- Empowers service team
- CI/CD is managed by AWS, no third party set up or trust required

Cons:

- In each Environment a **build is required** and that might be slow or non-reproducible in some languages
- Without some checks in place (check stg has commit) or approval stages, a `git push prd` could happen
- Each stack (e.g. Infra, App) typically is a separate Code{Commit,Build,Pipeline} and inevitably some manual co-ordination will be needed. I.e. Infra pushed before App
- Assumes trunk based development - complex branching strategies might make the flow ... complex
- At scale, the pipelines might become unwieldly, with organisational policies difficult to enforce.
- On fresh AWS accounts, AWS Code\* services are typically your only choice to work with

# Using Github

Workflows are great, but to effectively deploy to your {dev,stg,prd}
environments, **Github needs to be externally trusted**.

Pros:

- Workflows have far more mindshare than AWS's basic buildspec.yml
- Easy to add a workflow, to enforce some organisational policy
- Managed!
- Github comes with lot of great developer experiences and tooling

Cons:

- Could dissuade teams from using trunk based development
- Third party Github effectively has a back door to your service which is a security risk

Github's access can be limited to say the Container Registry, i.e. builds
instead of deployment, nonetheless there is a supply chain issue.

# Using some CI/CD tool in a dedicated account in your AWS Organisation

Also described as a [One stack definition managed with a
pipeline](https://medium.com/@kief/https-medium-com-kief-using-pipelines-to-manage-environments-with-infrastructure-as-code-b37285a1cbf5),
however the problem is that "the pipeline" is often centralised unlike "The simplest way to do it"
above, where the pipeline is minimal, native to each AWS account and driven exclusively via `git push`.

Pros:

- **Focuses on build artefacts** which might be easier to work with than code
- Should speed up the pipelines, since we are working with artifacts
- Should allow for almost any complex workflow / pipeline with (non-code) dependencies et al
- More guard rails, e.g. ensuring that every change has been applied to each environment (i.e. less mistakes)
- Often comes with a nice dashboard and visualisation map
- It can be simplified, for example when a shared **AWS managed** [Docker Container Registry](https://aws.amazon.com/ecr/) is used in that "dedicated account", and each container image is marked with a commit hash

Cons:

- The fact that it can accommodate more complexity, means that **the CI/CD server will be far more complex**
- The CI/CD tool becomes over arching and bloated, responsible for co-ordinating the whole path with roles to deploy in their respective environment
- Your infra team probably has to support it
- CI/CD and artefact store is typically **centralised** which can become a bottle neck or security target
- Source of truth might be less obvious in complex, multi-step pipelines

# Summary

A simpler git powered alternative to the top heavy, high maintenance, complex,
centralised CI/CD pipelines in organisations is proposed, which defers to AWS
managed CI/CD aka AWS Code\* in each {dev,stg,prd} account.

Other _managed_ CI/CD management options like Github are considered, but that
requires strong external trust and integration.

Decentralised, fault tolerant, source focused, coordinated by git pushes could
be the path to production.

The AWS managed approach is decoupled, stresses reproducible builds and uses a
git repository's commit hash as the source of truth. This approach empowers the
service team since they are essentially responsible for their Continuous
Integration build rules and deployment. That said, production deployment
approval and further guard rails can implemented when required.
