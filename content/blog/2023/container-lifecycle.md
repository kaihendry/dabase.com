---
title: Container Lifecycle
date: 2023-04-27T05:27:00+08:00
description: Container repository tagging for Build Once, Deploy Anywhere
---

In a Docker container delivery CI/CD pipeline with <abbr title="Build Once, Deploy Anywhere">BODA</abbr>, we need to promote the container image artifact from one environment to the next, instead of [building from source](/blog/2023/build-from-source/).

Once the artifact life is up, we need to clean it up, **expire it**. Though the image artifact **must not be expired whilst in use**, causing a common **CannotPullContainerError** outage.

What are our requirements?

1. A clear mapping to the commit SHA that was used to build the image
2. The digest of the image, which cannot change whilst being promoted
3. Whether the image whilst on its [path to production](https://youtu.be/3DV7m0_R23Q) is tested or signed off on
4. Nice to have: We need to know which image is **now running** in production
5. Nice to have: We need to know which image **was running** in production for a rollback

# Proposal 1: add and remove Docker image tags on centralised ECR

[lifecycle rule](https://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html#lp_evaluation_rules):
`expire | imageCountMoreThan (10) | untagged`


<strong>Warning: [Tags can only be removed via crane or the AWS cli on AWS](https://github.com/kaihendry/skopeo-vs-crane)</strong>

<img src="https://s.natalian.org/2023-04-27/lifecycle.svg">

Idea is that the nominated staging image is additionally tagged `crane tag foo/bar:daf46a8f prd`, and then deployed.

    + aws ecr describe-images --repository-name foo/bar
    + jq -r '.imageDetails[] | [.imageDigest,  (try .imageTags | join(","))] | @tsv'
    sha256:28d94d1ca5f7349e27bdcade26466ccd7e4c6d04ddc6358b924903c19cd84bae
    sha256:8caf9a1922de4c1173c9548bbe6e16933d11607475d82270ac89d8ba44d22d82 abde943-dirty
    sha256:834fff42bfddbba1e4bcbfe168f502b842d9bcea81b1119fbd10b527375d1d29 848e4a70
    sha256:79fbe50e1449a80d15c50e4ac2c03389a9d98387993436b582128d89721aa14b e87888e0
    sha256:327adcb41f31b44702b081d60fbe466e990e126046321182db7e909d6c34832b ae4eabeb
    sha256:38b5a742c63c3d892d090340526cb38b32004e0264ef005020669f9fb4fc1564
    sha256:d21168f92e82f278da73c32d2cb364bafc193fc2b714a85ec74cbb327f3b5263 daf46a8f,prd
    sha256:46a20b6daf239bbbb99098066f9bc649901b72760d3c7044349ffbec1cc86525 d3ac0173

Once `sha256:d21168f92e82f278da73c32d2cb364bafc193fc2b714a85ec74cbb327f3b5263` is replaced in production say by `848e4a70` tagged image, `sha256:d21168f92e82f278da73c32d2cb364bafc193fc2b714a85ec74cbb327f3b5263` tags `"daf46a8f,prd"` are removed. 

The untagged images are then expired once imageCountMoreThan is 10.

Pros:
* Adds context to the image
* Only untagged images are expired, so if an image is in use with a tag, it cannot be expired by the lifecycle policy

Cons:
* Requires [tagging mutability](https://twitter.com/nathankpeck/status/1650552853835001865)
* Assumes every tagged image gets deployed with prd tag as to later be untagged once replaced in production
* Unless we track sha256, we won't know the untagged image was the same deployed previously in production

# Proposal 2: Add another ECR per environment

[lifecycle rule](https://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html#lp_evaluation_rules):
`expire | imageCountMoreThan (10)`

Pros:
* Immutable tags
* Clearer environment separation

Cons:
* More ECRs to manage
* Assumes that the image is deployed to the environment, before being expired