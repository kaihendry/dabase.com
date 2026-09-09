---
title: "Fast AI. Slow workflow."
date: 2026-09-09T10:13:27Z
description: "AI agents can write code faster. But what happens when every change still waits for an approval, a merge button or an hour-long CI run?"
image: "https://dabase.com/podcast/images/043-fast-ai-slow-workflow.jpg"
thumbnail: "https://dabase.com/podcast/images/043-fast-ai-slow-workflow-wide.jpg"

podcast:
  episode: 43
  season: 1
  episodeType: "full"
  duration: 2223
  audioUrl: "https://dabase.com/podcast/audio/043-fast-ai-slow-workflow.mp3"
  audioSize: 53346860
  youtubeId: "4AxNs6MyxHU"
  youtubeUrl: "https://www.youtube.com/watch?v=4AxNs6MyxHU"
---

AI agents can write code faster. But what happens when every change still waits for an approval, a merge button or an hour-long CI run?

In EP43 of the AI Infrastructure podcast, Kai Hendry and Vincent De Smet discuss why faster AI needs better workflows: automated guardrails, less security toil and pull requests that humans can actually review. We also debate what CI really proves—and whether an agent's signed test results could replace rerunning the tests.

CHAPTERS
- [00:00](https://youtu.be/4AxNs6MyxHU?t=0) Welcome, transcripts and editing feedback
- [01:18](https://youtu.be/4AxNs6MyxHU?t=78) Claude remote control and shared-account surprises
- [03:06](https://youtu.be/4AxNs6MyxHU?t=186) Who can read your workplace AI chats?
- [05:25](https://youtu.be/4AxNs6MyxHU?t=325) AI model hype and exclusive access
- [08:02](https://youtu.be/4AxNs6MyxHU?t=482) Why infrastructure benchmarks can mislead
- [11:04](https://youtu.be/4AxNs6MyxHU?t=664) Security toil, patching and immutable deployments
- [14:13](https://youtu.be/4AxNs6MyxHU?t=853) Why deterministic security checks still matter
- [15:14](https://youtu.be/4AxNs6MyxHU?t=914) AI won't fix your broken workflow
- [19:51](https://youtu.be/4AxNs6MyxHU?t=1191) PR approvals, merge buttons and Slack nudges
- [23:30](https://youtu.be/4AxNs6MyxHU?t=1410) If agents run the tests, do we still need CI?
- [25:14](https://youtu.be/4AxNs6MyxHU?t=1514) What CI actually proves
- [29:14](https://youtu.be/4AxNs6MyxHU?t=1754) mise: managing tools and testing across versions
- [31:03](https://youtu.be/4AxNs6MyxHU?t=1863) Using agents to investigate Terraform regressions
- [32:27](https://youtu.be/4AxNs6MyxHU?t=1947) Cutting CI from five hours to under one
- [34:36](https://youtu.be/4AxNs6MyxHU?t=2076) When the commit message is bigger than the diff

EPISODE ARCHIVE & SUBSCRIBE
Find episode summaries, transcripts and links to Apple Podcasts, Spotify and RSS:
https://dabase.com/podcast/

What slows your team down most: writing the code, reviewing it or getting it merged? Let us know in the comments.

This episode keeps the natural pauses and ums. Tell us if you prefer this style or a tighter edit.

[Watch on YouTube](https://www.youtube.com/watch?v=4AxNs6MyxHU)

## `summarize "https://youtu.be/4AxNs6MyxHU" --timestamps --slides`

A focused recap of a podcast about the friction between fast AI-assisted code changes and slow organizational workflows: privacy and unexpected remote connections, benchmark hype, security and AISDLC lessons, pragmatic agent uses (nudges, attestations), and tooling to make CI/CD and developer environments reproducible and less wasteful.

[![Slide 1](/podcast/slides/4AxNs6MyxHU/youtube-4AxNs6MyxHU/slide_0001_1.52s.png)](https://youtu.be/4AxNs6MyxHU?t=1)
## Intro and unexpected remote access
Host frames episode and points to a transcript site, asks for editing feedback, then tells a cautionary tale: a cloud IDE/agent feature automatically opened a reverse remote-control tunnel and synchronized sessions across devices without explicit consent, producing surprise notifications and raising privacy concerns in shared-account scenarios.

[![Slide 2](/podcast/slides/4AxNs6MyxHU/youtube-4AxNs6MyxHU/slide_0002_370.48s.png)](https://youtu.be/4AxNs6MyxHU?t=370)
## Chat logs, sensitive signals and model exclusivity
Discussion with a CISO about chat logs as highly sensitive company data: access should be tightly restricted, time-limited and audited because employees still put private information into corporate AI tools. The hosts also note frustration with limited release models (Astra) and social-media hype around exclusive model benchmarks.

[![Slide 3](/podcast/slides/4AxNs6MyxHU/youtube-4AxNs6MyxHU/slide_0003_741.12s.png)](https://youtu.be/4AxNs6MyxHU?t=741)
## Benchmark skepticism and embedded model behavior
Speakers push back on benchmark-driven claims and niche framework hype, arguing large models often reproduce patterns embedded in their weights and can appear to "solve" infra tasks without genuine understanding. Benchmarks are manipulable and should be run and interpreted carefully rather than used as marketing.

[![Slide 4](/podcast/slides/4AxNs6MyxHU/youtube-4AxNs6MyxHU/slide_0004_1111.80s.png)](https://youtu.be/4AxNs6MyxHU?t=1111)
## AISDLC: go slow to go fast with guard rails
Adopting agent workflows requires preparatory work: automated gates, refactoring (monorepos, executable guardrails), better context sources (ontologies, knowledge graphs), and cross-stakeholder coordination; *you have to go slow before you go fast.* AI amplifies existing practices rather than magically replacing them.

[![Slide 5](/podcast/slides/4AxNs6MyxHU/youtube-4AxNs6MyxHU/slide_0005_1482.52s.png)](https://youtu.be/4AxNs6MyxHU?t=1482)
## Nudging systems for approvals and durable workflows
Because approvals, branch validations and lack of automerge are common bottlenecks, one guest built a durable "nudge" system (Step Functions + Slack cards) that reminds reviewers, enforces timers and configurable retries. Organizational constraints (webhook permissions, Bitbucket vs GitHub policies) make such integrations harder than building prototypes.

[![Slide 6](/podcast/slides/4AxNs6MyxHU/youtube-4AxNs6MyxHU/slide_0006_1853.92s.png)](https://youtu.be/4AxNs6MyxHU?t=1853)
## Rethinking CI/CD: attestations, local reproducibility and test matrices
They explore agentic CI where agents run tests and submit signed attestations so CI checks verify the attestation rather than rerun long suites, but worry about how to prevent agents from spoofing results. Social norms still matter (developers running tests locally to avoid wasting CI minutes). Tooling like mise to manage developer environments and large test matrices helps reproduce CI locally and enabled one project to shrink a five-hour suite to under an hour via early exits and reordering; as one host puts it, *it's not a works on my machine problem anymore.*

*Model: openai/gpt-5-mini*
