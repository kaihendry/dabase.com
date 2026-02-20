---
title: "cfgmgmtcamp 2026 debrief"
date: 2026-02-04T12:00:00Z
description: "Previous 2025 vlog: https://youtu.be/QQB6juzzIZU?si=5mrQi_ox8ds0ENp2

I'll add more links as I find a decent internet connection!

https://www.youtube.com/watch?v=yxzghm3Fdj8&t=10718s is Adam Jacob's AI talk

CDK plan we were talking about: https://gist.github.com/kaihendry/ce6574744e161d4ba8ba283b8dada85c"
image: "https://img.youtube.com/vi/tvoTdenufAs/hqdefault.jpg"
draft: false

podcast:
  episode: 19
  season: 1
  episodeType: "full"
  duration: 2892
  audioUrl: "/podcast/audio/019-cfgmgmtcamp-2026-debrief.mp3"
  audioSize: 69418412
  youtubeId: "tvoTdenufAs"
  youtubeUrl: "https://www.youtube.com/watch?v=tvoTdenufAs"
---

Previous 2025 vlog: https://youtu.be/QQB6juzzIZU?si=5mrQi_ox8ds0ENp2

I'll add more links as I find a decent internet connection!

https://www.youtube.com/watch?v=yxzghm3Fdj8&t=10718s is Adam Jacob's AI talk

CDK plan we were talking about: https://gist.github.com/kaihendry/ce6574744e161d4ba8ba283b8dada85c

[Watch on YouTube](https://www.youtube.com/watch?v=tvoTdenufAs)

## `summarize "https://youtu.be/tvoTdenufAs" --timestamps --slides`

A conversational debrief recorded after Config Management Camp in Belgium. Two participants walk through what they saw and heard: debates about CloudFormation vs Terraform vs AWS CDK, why Pulumi’s runtime model matters, experiments with config languages like QLang, limits of current dependency and validation practices, how AI changes velocity and testing needs, and early demos of local LLMs and cloud tooling that add task/agent features.

[![Slide 1](/podcast/slides/tvoTdenufAs/youtube-tvoTdenufAs/slide_0001_0.24s.png)](https://youtu.be/tvoTdenufAs?t=0)
## Config Management Camp first impressions
Hosts open on location and say the conference was excellent; one calls it possibly “the best infrastructure conference on the planet.” They recap missed sessions and a short exchange about a Golang AWS project plan that compared CloudFormation, the AWS CLI and AWS CDK but — by plan output from Claude — did not mention Terraform. They cite an AWS usage report saying CloudFormation is the most-used deployment method on AWS, followed by Terraform and then AWS CDK. The conversation notes CDK’s advantage of shift-left, compile-time checks and better developer ergonomics versus raw CloudFormation.

[![Slide 2](/podcast/slides/tvoTdenufAs/youtube-tvoTdenufAs/slide_0002_474.08s.png)](https://youtu.be/tvoTdenufAs?t=474)
## Pulumi as a hosted runtime
Pulumi came up repeatedly: unlike purely declarative Terraform, Pulumi runs your infrastructure code inside a host/runtime that can expose dynamic capabilities to the program (TypeScript, Python, Go). That host model lets you do environment-aware lookups and tailor provider resource configuration at runtime. The Pulumi rep reportedly claimed language choice "doesn't matter" for AI use because Pulumi exposes multiple bindings (including a declarative YAML interface), which sparked debate about whether language or host features matter more for automation and reuse.

[![Slide 3](/podcast/slides/tvoTdenufAs/youtube-tvoTdenufAs/slide_0003_956.12s.png)](https://youtu.be/tvoTdenufAs?t=956)
## Terraform, HashiCorp and dependency pain
They discuss Terraform Cloud/Enterprise, HashiCorp execution issues and how teams often prefer Atlantis to avoid vendor lock-in or high costs. CDKTF deprecation and shifting HashiCorp priorities were mentioned. The group wants stronger dependency management for infrastructure (beyond current state graph limitations) but admits the hard reality: you often can't fully validate network or cross-environment behavior without deploying into the target environment. Strongly typed interfaces and shift-left testing help, but the problem is not solved.

[![Slide 4](/podcast/slides/tvoTdenufAs/youtube-tvoTdenufAs/slide_0004_1438.20s.png)](https://youtu.be/tvoTdenufAs?t=1438)
## Config languages, Kubernetes and QLang
Speakers explore higher-level config/DSL approaches: QLang (in the spirit of Google’s config languages) and other DSLs that generate plans and summarize changes. QLang demos showed a workflow where a Terraform plan result is fed back into the QLang system so the PR shows a human-friendly summary of changes and links them to config edits; the presenter found this operationally useful. They contrast the ideal of handing a declarative config directly to the cloud provider with the current reality of CRUD-heavy providers. Kubernetes-style control loops and Crossplane were discussed as attempts to give a uniform control plane for managed services. An important infra capability mentioned: virtual pod autoscaling and cgroup v2 let you resize CPU/memory for pods without recreating them, opening new options for right-sizing.

*“in an ideal world, you could just give the declarative config and that's that”*

[![Slide 5](/podcast/slides/tvoTdenufAs/youtube-tvoTdenufAs/slide_0005_1920.24s.png)](https://youtu.be/tvoTdenufAs?t=1920)
## Rollback trade-offs and ephemeral AI environments
CloudFormation’s transactional, all-or-nothing deploy model is praised for guaranteed rollbacks but criticized for slowness and complex failures (resources left behind blocking destruction). Terraform is faster and more parallel but can leave partial state on failures, pushing rollback responsibility onto engineers. As AI increases code velocity (one talk mentioned outputs on the order of 50k lines of code as an example of the multiplier effect), hosts worry infrastructure becomes the bottleneck. A proposed mitigation is ephemeral, easily provisioned environments for AI to boot from scratch and destroy when “crofty” — essentially disposable AWS accounts that can be nuked and recreated — but teams face account-vending, data replication and masking challenges that complicate ephemeral testing.

[![Slide 6](/podcast/slides/tvoTdenufAs/youtube-tvoTdenufAs/slide_0006_2402.32s.png)](https://youtu.be/tvoTdenufAs?t=2402)
## Local LLMs, hardware and Cloud Code evolution
A demo showed a modern laptop (large RAM, local GPU allocation to accelerate on-device models) running local models to triage failing Ansible-style playbooks and upgrade libraries without internet — demonstrating that local models can be practical for maintenance work. The hosts discuss model capabilities, noting Claude/Anthropic variants and comparisons to the GPT series and OSS models. Hardware cost examples included a ~4,000 (Canadian) framework laptop purchase as an alternative to paid API usage. Cloud Code announcements are highlighted: task dependencies, built-in agent/task memory, and tighter templates/spec workflows (Speckit-style templates + validation hooks) that aim to reduce ambiguous agent assumptions. They warn that bundling runtimes, agents and subscription bindings into a single provider can create stickiness or lock-in, so teams are weighing the convenience of integrated toolchains against portability and control. *“I think it's actually the best infrastructure conference on the planet, I dare say.”*

*Model: openai/gpt-5-mini*
