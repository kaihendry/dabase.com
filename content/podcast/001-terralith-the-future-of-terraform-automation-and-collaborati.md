---
title: "Terralith: the Future of Terraform Automation and Collaboration? (Re-Upload)"
date: 2025-10-04T12:00:00Z
description: "Vincent De Smet is working on https://terraconstructs.dev/

Opentaco trailer from https://www.linkedin.com/posts/izalutski_today-i-am-excited-to-announce-diggers-biggest-activity-7376635476264374272-O2Cp/ (without the copyrighted aggressive music)

https://github.com/diggerhq/digger/blob/develop/taco/agents_context/opentaco-case.md#how-will-this-thing-make-money"
image: "https://img.youtube.com/vi/UXIJe2moZ-I/hqdefault.jpg"
draft: false

podcast:
  episode: 1
  season: 1
  episodeType: "full"
  duration: 2853
  audioUrl: "/podcast/audio/001-terralith-the-future-of-terraform-automation-and-collaborati.mp3"
  audioSize: 68481836
  youtubeId: "UXIJe2moZ-I"
  youtubeUrl: "https://www.youtube.com/watch?v=UXIJe2moZ-I"
---

Vincent De Smet is working on https://terraconstructs.dev/

Opentaco trailer from https://www.linkedin.com/posts/izalutski_today-i-am-excited-to-announce-diggers-biggest-activity-7376635476264374272-O2Cp/ (without the copyrighted aggressive music)

https://github.com/diggerhq/digger/blob/develop/taco/agents_context/opentaco-case.md#how-will-this-thing-make-money

[Watch on YouTube](https://www.youtube.com/watch?v=UXIJe2moZ-I)

## `summarize "https://youtu.be/UXIJe2moZ-I" --timestamps --slides`

This video is a conversational deep-dive into recent turbulence in the Terraform ecosystem: licensing shifts, forks, new orchestration products, and a very public community spat over an “open standard” play. The hosts map how teams currently run Terraform (single repos, many states, or cloud stacks), explain why multi-state orchestration is hard, and trace multiple vendor responses: Atlantis (open source), runner-based alternatives like Digger, managed vendors (Spacelift, M0), the Terraform Cloud “stacks” feature, and new projects pitching state-centric tooling (stategraph.dev and Digger’s “OpenTaco”). The conversation includes concrete operational trade-offs: why teams split states (ownership, lifecycle, blast radius), the risk of race conditions between resources (API Gateway example), how Atlantis’ PR lock + approved-plan workflow works, and why many orgs are wary of resource-under-management pricing versus self-hosted tooling. The hosts quote numbers and anecdotes from real clients: small self‑hosted ops can run on a ~$15 EC2 instance, many teams pay ~$20/month for simple setups, and some cloud quotes for managed “resource under management” tooling can balloon to ~$10,000/month for very large estates. The conversation highlights two recurring themes: *Context is king.* and the backlash topic that motivated the heated Reddit/Hacker News threads: *resource under management pricing is criminal.* The summary below follows the video’s slide timeline and gives a compact headline plus one-line summary per slide so you can judge whether to watch the clip.

[![Slide 1](/podcast/slides/UXIJe2moZ-I/youtube-UXIJe2moZ-I/slide_0001_1.53s.png)](https://youtu.be/UXIJe2moZ-I?t=1)
## Ecosystem context
Hosts set the stage: Terraform’s commercial relicensing led to forks (OpenTofu) and many vendors building “tacos” (Terraform Automation/Collaboration Software) such as Spacelift, M0, Atlantis, and Digger; Digger’s pitch is using existing CI runners instead of running a dedicated server.

[![Slide 2](/podcast/slides/UXIJe2moZ-I/youtube-UXIJe2moZ-I/slide_0002_467.57s.png)](https://youtu.be/UXIJe2moZ-I?t=467)
## Orchestration problem and stacks GA
Terraform Cloud’s “stacks” (now GA) add cross‑state orchestration—helping sequence dependent states like network → cluster → GitOps controller—but this is cloud‑only and only partially surfaced to the CLI, so many orchestration gaps remain.

[![Slide 3](/podcast/slides/UXIJe2moZ-I/youtube-UXIJe2moZ-I/slide_0003_943.13s.png)](https://youtu.be/UXIJe2moZ-I?t=943)
## Dependency complexity and race conditions
Within a single state Terraform handles resource graphs well, but implicit dependencies across states create races (example: API Gateway deployment failing because an integration/lambda isn’t attached), and cross‑state outputs can change shapes, breaking dependents.

[![Slide 4](/podcast/slides/UXIJe2moZ-I/youtube-UXIJe2moZ-I/slide_0004_1418.67s.png)](https://youtu.be/UXIJe2moZ-I?t=1418)
## Atlantis vs runners vs pricing
Atlantis provides PR locking, plan-on-PR and apply-from-approved-plan workflows and can run cheaply on a small EC2 ($15) or ~$20/month setups; managed vendors charge per‑resource which can scale from trivial to staggering ($10,000/month quoted for very large fleets).

[![Slide 5](/podcast/slides/UXIJe2moZ-I/youtube-UXIJe2moZ-I/slide_0005_1894.23s.png)](https://youtu.be/UXIJe2moZ-I?t=1894)
## Monolith vs many states debate
Two camps: tools that advocate splitting state for lifecycle/ownership reasons (TerraGrunt/Gruntwork approach) versus proposals to treat a large single state (“teralith”) with better tooling (state graph / monolith tooling); hosts favor state‑graph ideas for richer tooling.

[![Slide 6](/podcast/slides/UXIJe2moZ-I/youtube-UXIJe2moZ-I/slide_0006_2367.20s.png)](https://youtu.be/UXIJe2moZ-I?t=2367)
## OpenTaco launch and backlash
Digger released “OpenTaco” (state manager, module registry, RBAC, dependency graph, insights) and a provocative video; the community pushed back on claims of an “open standard,” after the repo included copied Terraform Cloud backend code without attribution, triggering removal, heated Reddit/HN threads, and an apology post.

*Model: openai/gpt-5-mini*
