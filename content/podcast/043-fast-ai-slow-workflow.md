---
title: "Fast AI. Slow workflow."
date: 2026-09-09T10:13:27Z
description: "AI agents can write code faster. But every change can still get stuck waiting for an approval, a merge button or an hour-long CI run."
image: "https://dabase.com/podcast/images/043-fast-ai-slow-workflow.jpg"
thumbnail: "https://dabase.com/podcast/images/043-fast-ai-slow-workflow-wide.jpg"

podcast:
  episode: 43
  season: 1
  episodeType: "full"
  duration: 2107
  audioUrl: "https://dabase.com/podcast/audio/043-fast-ai-slow-workflow-i17ft8suunQ.mp3"
  audioSize: 50565932
  youtubeId: "i17ft8suunQ"
  youtubeUrl: "https://www.youtube.com/watch?v=i17ft8suunQ"
---

AI agents can write code faster. But every change can still get stuck waiting for an approval, a merge button or an hour-long CI run.

In EP43 of AI Infrastructure, Kai Hendry and Vincent De Smet discuss why faster agents need better workflows: automated guardrails, less security toil and pull requests that humans can actually review. We also debate whether an agent’s signed test results could replace rerunning tests in CI—and what a clean CI environment actually proves.

Along the way: Claude remote control surprises, workplace chat privacy, misleading benchmarks, mise, Terraform regressions and AI-generated comments that read like journals.

CHAPTERS
- [00:00](https://youtu.be/i17ft8suunQ?t=0) Welcome, transcripts and editing feedback
- [01:18](https://youtu.be/i17ft8suunQ?t=78) Claude remote control and shared-account surprises
- [03:06](https://youtu.be/i17ft8suunQ?t=186) Workplace AI chats and privacy
- [05:25](https://youtu.be/i17ft8suunQ?t=325) AI model hype and exclusive access
- [08:01](https://youtu.be/i17ft8suunQ?t=481) Benchmarks, averages and misleading statistics
- [09:40](https://youtu.be/i17ft8suunQ?t=580) Security toil, patching and immutable deployments
- [12:49](https://youtu.be/i17ft8suunQ?t=769) Why deterministic security checks still matter
- [13:48](https://youtu.be/i17ft8suunQ?t=828) AI won’t fix your broken workflow
- [18:27](https://youtu.be/i17ft8suunQ?t=1107) PR approvals, merge buttons and Slack nudges
- [22:06](https://youtu.be/i17ft8suunQ?t=1326) If agents run the tests, do we still need CI?
- [23:51](https://youtu.be/i17ft8suunQ?t=1431) What CI actually proves
- [27:49](https://youtu.be/i17ft8suunQ?t=1669) mise: tool versions and local testing
- [29:39](https://youtu.be/i17ft8suunQ?t=1779) Using agents to investigate Terraform regressions
- [31:03](https://youtu.be/i17ft8suunQ?t=1863) Cutting CI from five hours to under one
- [33:13](https://youtu.be/i17ft8suunQ?t=1993) When the commit message is bigger than the diff

EPISODE ARCHIVE & SUBSCRIBE
Browse previous episodes and subscribe via Apple Podcasts, Spotify or RSS:
https://dabase.com/podcast/

What slows your team down most: writing the code, reviewing it or getting it merged? Let us know in the comments.

This episode keeps the natural pauses and ums. Tell us if you prefer this style or a tighter edit.

[Watch on YouTube](https://www.youtube.com/watch?v=i17ft8suunQ)

## `summarize "https://youtu.be/i17ft8suunQ" --timestamps --slides`

Episode 43 of the AI Infrastructure Podcast is a free‑form conversation about how fast AI agents are changing developer workflows — and how slow human processes, approvals and legacy CI/CD practices still bottleneck progress. The hosts cover privacy and remote‑access surprises, the limits and hype around new models and benchmarks, the evolving role of deterministic security tools versus AI, concrete engineering practices (immutable deploys, canaries, test matrices), and a few practical fixes they’ve built: nudging workflows, environment tooling, and rules for agent‑generated PRs. *AI is an amplifier* and adopting it safely often means refactoring systems and automating gates before you can truly go faster; *you have to go slow before you go fast*.

[![Slide 1](/podcast/slides/i17ft8suunQ/youtube-i17ft8suunQ/slide_0001_1.52s.png)](https://youtu.be/i17ft8suunQ?t=1)

## Unexpected remote access and privacy concerns

A cloud IDE’s remote session feature unexpectedly synced across family devices, producing alerts and exposing how easily chat/code can leak between accounts. Teams are wrestling with chat log retention and access: companies want logs for process improvement but must limit viewer access and set expirations. Legal and cultural constraints (especially in Europe) complicate relying on consent and company notices as protection for storing sensitive chat content.

[![Slide 2](/podcast/slides/i17ft8suunQ/youtube-i17ft8suunQ/slide_0002_344.44s.png)](https://youtu.be/i17ft8suunQ?t=344)

## New model releases and benchmark skepticism

They discuss a new high‑profile model release that impressed via demos and benchmark claims, but they’re skeptical about exclusivity, hype videos, and what benchmark numbers really mean. Benchmarks can be misleading without context; the hosts caution against overinterpreting early results and note frustration when tools are unavailable to most practitioners.

[![Slide 3](/podcast/slides/i17ft8suunQ/youtube-i17ft8suunQ/slide_0003_701.16s.png)](https://youtu.be/i17ft8suunQ?t=701)

## Security tooling: deterministic rules plus AI assistance

Longstanding SAST/DAST pipelines still matter; deterministic checks, CVE databases, and attestation flows provide provable coverage. AI can help generate rules, prioritize alerts, and reduce toil, but it shouldn’t replace deterministic guards. They emphasize immutable deploys, tested rollouts and canaries, and worry about overtrusting probabilistic agents for risk decisions without automated gates.

[![Slide 4](/podcast/slides/i17ft8suunQ/youtube-i17ft8suunQ/slide_0004_1054.92s.png)](https://youtu.be/i17ft8suunQ?t=1054)

## Reworking the AI software lifecycle (AI SDLC)

Adopting agents successfully requires refactoring codebases, better automation and guardrails: monorepos, reproducible builds, and reliable context (ontologies/knowledge systems). Case studies (cloud teams and AWS talks) show pilot projects accelerate teams but are not generally transferrable without system‑level changes. Coordination across stakeholders still matters; spec‑driven work and human decision points must be integrated into agent workflows.

[![Slide 5](/podcast/slides/i17ft8suunQ/youtube-i17ft8suunQ/slide_0005_1403.72s.png)](https://youtu.be/i17ft8suunQ?t=1403)

## Practical engineering fixes and a nudge system

They describe building a durable "nudge" workflow to chase PR approvals using step functions and Slack interactions to avoid manual bottlenecks (two approvals, long branch validation times, approvals invalidated by commits). The host notes organizational friction around webhooks, scoped apps and permissions. They also praise tools that provision consistent dev environments (Mise) to run multi‑version test matrices and avoid "works on my machine" problems. Improvements to CI reduced a 5‑hour test suite to under an hour by early exits and reordering tests.

[![Slide 6](/podcast/slides/i17ft8suunQ/youtube-i17ft8suunQ/slide_0006_1754.56s.png)](https://youtu.be/i17ft8suunQ?t=1754)

## Agents, attestations, and code hygiene rules

Debate over agentic CI: some propose agents run tests, sign attestations, and upstream CI only verifies attestations, shifting the CI role; hosts are cautious and insist reproducible CI remains proof code runs on another machine. They’ve added pragmatic rules for agent outputs: make PRs draft by default, limit verbose commit messages, and auto‑sanitize comments so history doesn’t become journals. Practical agent governance and small engineering conventions are key to keeping agent speed from creating chaos.

*Model: openai/gpt-5-mini*
