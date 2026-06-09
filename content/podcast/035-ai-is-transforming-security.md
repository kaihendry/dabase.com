---
title: "AI is transforming Security"
date: 2026-06-09T12:00:00Z
description: "Supply chain attacks, AWS CodeArtifact, agentic workflows, auto mode sandboxing, and local memory systems with Hermes agent."
image: "https://img.youtube.com/vi/W7QcWP8VngI/hqdefault.jpg"
draft: false

podcast:
  episode: 35
  season: 1
  episodeType: "full"
  duration: 3719
  audioUrl: "https://dabase.com/podcast/audio/035-ai-is-transforming-security.mp3"
  audioSize: 89244909
  youtubeId: "W7QcWP8VngI"
  youtubeUrl: "https://www.youtube.com/watch?v=W7QcWP8VngI"
---

Supply chain attacks, AWS CodeArtifact, agentic workflows, auto mode sandboxing, and local memory systems with Hermes agent.

[Watch on YouTube](https://www.youtube.com/watch?v=W7QcWP8VngI)

## `summarize "https://youtu.be/W7QcWP8VngI" --timestamps --slides`

An informal conversation about how AI is reshaping security and developer operations. Topics range from supply chain attacks and private registries to agentic workflows, auto mode sandboxing, and local memory systems.

[![Slide 1](/podcast/slides/W7QcWP8VngI/youtube-W7QcWP8VngI/slide_0001_2.25s.png)](https://youtu.be/W7QcWP8VngI?t=2)
## Supply chain attacks & namesquatting
Red Hat GitHub breach, malicious packages propagating through frameworks and VS Code plugins, and PNPM becoming aggressive about disabling install-time hooks.

[![Slide 2](/podcast/slides/W7QcWP8VngI/youtube-W7QcWP8VngI/slide_0002_603.33s.png)](https://youtu.be/W7QcWP8VngI?t=603)
## AWS CodeArtifact replacing Nexus
IAM/SSO integration makes rollout simple: read-only scopes for developers, GitHub Actions OIDC for publishing, pull-through caching against public registry outages — versus the cost and complexity of JFrog/Artifactory enterprise features.

[![Slide 3](/podcast/slides/W7QcWP8VngI/youtube-W7QcWP8VngI/slide_0003_1231.50s.png)](https://youtu.be/W7QcWP8VngI?t=1231)
## AI reshaping the security profession
Security checklists become automated tests and guardrails; agents execute compliance checks across AWS configs and Git repos. The profession shifts from spreadsheet auditors to engineers who define what "good" looks like.

[![Slide 4](/podcast/slides/W7QcWP8VngI/youtube-W7QcWP8VngI/slide_0004_1859.92s.png)](https://youtu.be/W7QcWP8VngI?t=1859)
## Agentic workflows: dynamic workflows & auto mode
Auto mode delegates command approvals to a model-based classifier — 0.4% of benign commands blocked, 17% of risky actions got through. Docker sandboxes and Cowork isolation as mitigations.

[![Slide 5](/podcast/slides/W7QcWP8VngI/youtube-W7QcWP8VngI/slide_0005_2473.62s.png)](https://youtu.be/W7QcWP8VngI?t=2473)
## Hermes agent + Firecrawl
Running a local Hermes agent on Discord with Firecrawl to crawl 400 AWS doc pages in 5 minutes; migrating the agent from EC2 to a local desktop via SSH/tar orchestrated by Claude.

[![Slide 6](/podcast/slides/W7QcWP8VngI/youtube-W7QcWP8VngI/slide_0006_3088.29s.png)](https://youtu.be/W7QcWP8VngI?t=3088)
## Local memory systems: mem0, hindsight, PG0
Embedding models and re-rankers on a local GPU, PG0 (embedded Postgres à la SQLite), hindsight semantic knowledge graphs, and CQ for team-level shared agent memory.

## Timestamps

0:00 Intro & banter
2:00 Supply chain attacks: Red Hat GitHub breach, namesquatting with LLMs
7:00 VS Code plugin security model; PNPM disabling install hooks by default
10:00 AWS CodeArtifact: replacing Nexus, IAM/SSO integration
15:00 CodeArtifact RBAC — read-only devs, GitHub Actions OIDC for publishing
18:00 CodeArtifact limits vs JFrog/Artifactory enterprise features
21:00 Security vs pipeline speed tradeoffs; Datadog cost explosion
24:00 AI reshaping the security profession: checklists → automated tests & guardrails
28:00 Agentic workflows: dynamic workflows, auto mode, humans on the loop
33:00 Claude auto mode: model-based classifier for command approval
37:00 Auto mode stats — 0.4% benign blocked, 17% risky actions got through
39:00 Running agents in Docker sandboxes
42:00 Cowork for personal productivity (timesheets, contracts, HAR files)
46:00 Hermes agent on Discord + local Firecrawl stack
50:00 Crawling 400 AWS doc pages in 5 minutes
53:00 Local GPU, embedding models, PG0 embedded Postgres (SQLite-style)
56:00 Memory systems: mem0, hindsight, semantic knowledge graphs
58:00 CQ: team-level shared agent memory
60:00 Hermes PR review automation & release-please simulation
62:00 OpenClaw, risk assessment wrap-up
