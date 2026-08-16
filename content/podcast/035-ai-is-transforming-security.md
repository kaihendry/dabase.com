---
title: "AI is transforming Security"
date: 2026-06-09T12:06:28Z
description: "This episode is a wide-ranging conversation about how AI and agents are reshaping security, supply-chain risk, developer workflows and tool choices."
image: "https://dabase.com/podcast/images/035-ai-is-transforming-security.jpg"
thumbnail: "https://dabase.com/podcast/images/035-ai-is-transforming-security-wide.jpg"

podcast:
  episode: 35
  season: 1
  episodeType: "full"
  duration: 3719
  audioUrl: "https://dabase.com/podcast/audio/035-ai-is-transforming-security.mp3"
  audioSize: 89244908
  youtubeId: "W7QcWP8VngI"
  youtubeUrl: "https://www.youtube.com/watch?v=W7QcWP8VngI"
---

- [0:00](https://youtu.be/W7QcWP8VngI?t=0) Intro & banter
- [2:00](https://youtu.be/W7QcWP8VngI?t=120) Supply chain attacks: Red Hat GitHub breach, namesquatting with LLMs
- [7:00](https://youtu.be/W7QcWP8VngI?t=420) VS Code plugin security model; PNPM disabling install hooks by default
- [10:00](https://youtu.be/W7QcWP8VngI?t=600) AWS CodeArtifact: replacing Nexus, IAM/SSO integration
- [15:00](https://youtu.be/W7QcWP8VngI?t=900) CodeArtifact RBAC — read-only devs, GitHub Actions OIDC for publishing
- [18:00](https://youtu.be/W7QcWP8VngI?t=1080) CodeArtifact limits vs JFrog/Artifactory enterprise features
- [21:00](https://youtu.be/W7QcWP8VngI?t=1260) Security vs pipeline speed tradeoffs; Datadog cost explosion
- [24:00](https://youtu.be/W7QcWP8VngI?t=1440) AI reshaping the security profession: checklists → automated tests & guardrails
- [28:00](https://youtu.be/W7QcWP8VngI?t=1680) Agentic workflows: dynamic workflows, auto mode, humans on the loop
- [33:00](https://youtu.be/W7QcWP8VngI?t=1980) Claude auto mode: model-based classifier for command approval
- [37:00](https://youtu.be/W7QcWP8VngI?t=2220) Auto mode stats — 0.4% benign blocked, 17% risky actions got through
- [39:00](https://youtu.be/W7QcWP8VngI?t=2340) Running agents in Docker sandboxes
- [42:00](https://youtu.be/W7QcWP8VngI?t=2520) Cowork for personal productivity (timesheets, contracts, HAR files)
- [46:00](https://youtu.be/W7QcWP8VngI?t=2760) Hermes agent on Discord + local Firecrawl stack
- [50:00](https://youtu.be/W7QcWP8VngI?t=3000) Crawling 400 AWS doc pages in 5 minutes
- [53:00](https://youtu.be/W7QcWP8VngI?t=3180) Local GPU, embedding models, PG0 embedded Postgres (SQLite-style)
- [56:00](https://youtu.be/W7QcWP8VngI?t=3360) Memory systems: mem0, hindsight, semantic knowledge graphs
- [58:00](https://youtu.be/W7QcWP8VngI?t=3480) CQ: team-level shared agent memory
- [60:00](https://youtu.be/W7QcWP8VngI?t=3600) Hermes PR review automation & release-please simulation
- [62:00](https://youtu.be/W7QcWP8VngI?t=3720) OpenClaw, risk assessment wrap-up

[Watch on YouTube](https://www.youtube.com/watch?v=W7QcWP8VngI)

## `summarize "https://youtu.be/W7QcWP8VngI" --timestamps --slides`

This episode is a wide-ranging conversation about how AI and agents are reshaping security, supply-chain risk, developer workflows and tool choices. The hosts cover a live supply-chain incident, how language models change package-install risk, why teams adopt private registries, the cost/productivity trade-offs of added security, and the rapid rise of agentic workflows plus practical sandboxing and governance patterns.

[![Slide 1](/podcast/slides/W7QcWP8VngI/youtube-W7QcWP8VngI/slide_0001_2.25s.png)](https://youtu.be/W7QcWP8VngI?t=2)
## Supply-chain alert and package risks
They open with a recent active supply-chain incident (a compromised GitHub login published malicious packages) and unpack what makes these attacks effective: dependency propagation through popular frameworks and editor plugins, weak marketplace controls, and name-squatting risks that can trick LLMs into suggesting malicious package names. They flag VS Code plugins’ broad permissions and explain that modern LLM assistants can sometimes refuse or block suspicious packages. *name squatting is scary, right?*

[![Slide 2](/podcast/slides/W7QcWP8VngI/youtube-W7QcWP8VngI/slide_0002_603.33s.png)](https://youtu.be/W7QcWP8VngI?t=603)
## Why private registries (CodeArtifact) matter
A deep dive into AWS CodeArtifact: teams use it as a centrally managed, SSO/IAM‑backed registry that enforces read-only access for devs, centralizes CI publish permissions, provides pull-through caching (mitigates public registry outages) and scopes private packages. It’s presented as a low‑friction replacement for ad‑hoc Nexus installs, though it lacks some enterprise features (vulnerability scanning, advanced policy) that pricier registries provide.

[![Slide 3](/podcast/slides/W7QcWP8VngI/youtube-W7QcWP8VngI/slide_0003_1231.50s.png)](https://youtu.be/W7QcWP8VngI?t=1231)
## Security tooling vs developer speed and cost
Security teams must balance control, auditability and developer velocity. The speakers note hiring challenges (need engineer-minded security folks), predictable resistance when scanning/controls slow pipelines, and ballooning costs from full-platform security suites. They argue AI can automate many checklist tasks and make compliance evidenceable, but organizations still struggle with tradeoffs and the human work that security processes demand.

[![Slide 4](/podcast/slides/W7QcWP8VngI/youtube-W7QcWP8VngI/slide_0004_1859.92s.png)](https://youtu.be/W7QcWP8VngI?t=1859)
## Agents, auto mode and dynamic workflows
Recent advances (auto mode, dynamic workflows, model classifiers) let many sub-agents run autonomously, validate results and reduce manual prompting; vendors report low benign-block rates but nonzero risky actions slipping through. Speakers stress running agents inside sandboxes (Docker, Firecracker, dedicated runtime or guarded app shells), treating guardrails as tests, and designing deterministic verification suites so agentic outputs are auditable and safe. *I can't I can't find enough jobs to give to the agent.*

[![Slide 5](/podcast/slides/W7QcWP8VngI/youtube-W7QcWP8VngI/slide_0005_2473.62s.png)](https://youtu.be/W7QcWP8VngI?t=2473)
## Practical agent tooling and local stacks
They compare Hermes, OpenClaw and other agent frameworks: Hermes was used to orchestrate PR simulations, run tests, create forks/PRs with limited GitHub perms and simulate release tooling; Firecrawl was used for fast web scraping to populate local semantic memories. They highlight memory layers (hindsight, mem‑zero), PG0 as an embedded Postgres/vector option, and the appeal of running embeddings/LLMs locally to avoid lock‑in and query costs.

[![Slide 6](/podcast/slides/W7QcWP8VngI/youtube-W7QcWP8VngI/slide_0006_3088.29s.png)](https://youtu.be/W7QcWP8VngI?t=3088)
## Governance, sandboxing and rules of engagement
Advice: limit agent permissions, whitelist channels for agent interaction (dedicated Slack/issue streams), keep agents read-only where possible, and treat policy/checklist items as unit tests that agents must satisfy. For production use, enforce sandboxes, require deterministic pre- and post-checks, keep sensitive memories under team control, and maintain human oversight for edge cases—AI accelerates many tasks, but risk assessments and clear guardrails remain essential.

*Model: openai/gpt-5-mini*
