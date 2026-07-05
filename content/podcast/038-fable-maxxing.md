---
title: "Fable maxxing"
date: 2026-07-04T12:00:00Z
description: "https://github.com/kaihendry/members.cardinhamsports.org/commits/main/ is a demonstration of using https://github.com/kaihendry/sloc-sensor"
image: "https://dabase.com/podcast/images/038-fable-maxxing.jpg"

podcast:
  episode: 38
  season: 1
  episodeType: "full"
  duration: 2635
  audioUrl: "https://dabase.com/podcast/audio/038-fable-maxxing.mp3"
  audioSize: 63246573
  youtubeId: "BBxu5L9ywqk"
  youtubeUrl: "https://www.youtube.com/watch?v=BBxu5L9ywqk"
---

https://github.com/kaihendry/members.cardinhamsports.org/commits/main/ is a demonstration of using https://github.com/kaihendry/sloc-sensor

[Watch on YouTube](https://www.youtube.com/watch?v=BBxu5L9ywqk)

## `summarize "https://youtu.be/BBxu5L9ywqk" --timestamps --slides`

A wide-ranging, technical conversation about using agentic LLMs (Fable, Sonnet, Hermes) to drive open-source infra work—especially a CDK-for-Terraform fork—plus a pragmatic debate about Terraform vs CloudFormation validation, PR review pain, and agent limits (availability, memory, noise). The hosts demonstrate a full workflow: set a long-running Goal, let Fable orchestrate smaller models to generate code, run demo plans with a Hermes agent, and collect UX notes; they hit real-world friction (enterprise data rules, session limits, flaky back-and-forth, reviewer trust). *Fable is back, so that was exciting.* *land this proposal.*

[![Slide 1](/podcast/slides/BBxu5L9ywqk/youtube-BBxu5L9ywqk/slide_0001_0.24s.png)](https://youtu.be/BBxu5L9ywqk?t=0)
## Fable relaunch and proposal
They used Fable as an orchestrator to implement a prior one‑page proposal about adding newer Terraform provider features into a TypeScript CDK interface compatible with both Terraform and OpenTofu. The host tried Cloud Code’s slash-goal feature to set “land this proposal” as an automated objective and paired Fable orchestration with Sonnet for faster, cheaper sub‑work flows.

[![Slide 2](/podcast/slides/BBxu5L9ywqk/youtube-BBxu5L9ywqk/slide_0002_434.58s.png)](https://youtu.be/BBxu5L9ywqk?t=434)
## CDK Terrain progress and Fable access
CDK Terrain (community fork of CDK for Terraform) removed deprecated dependencies, reduced binary size, fixed CVEs, and added function support (CIDR/subnet helpers, etc.). A CLI rewrite is underway to remove a React-based terminal UI. Fable access is limited (seven days per session), tracked separately, and restricted in enterprise settings because of data retention policies.

[![Slide 3](/podcast/slides/BBxu5L9ywqk/youtube-BBxu5L9ywqk/slide_0003_870.62s.png)](https://youtu.be/BBxu5L9ywqk?t=870)
## Terraform vs CloudFormation
Discussion of CloudFormation’s validation/rollback vs Terraform’s fast, forward‑only apply model: CloudFormation validates and can rollback but can also cause stubborn rollback failure modes; Terraform lacks a comparable validation runtime so failures can leave partial state and require manual recovery. Hosts agree choice depends on tolerance for rollback complexity and the target environment.

[![Slide 4](/podcast/slides/BBxu5L9ywqk/youtube-BBxu5L9ywqk/slide_0004_1307.42s.png)](https://youtu.be/BBxu5L9ywqk?t=1307)
## Plan mode and spec-driven work
They contrast Cloud Code “plan” mode (read‑only guardrail) with spec‑driven development and agent workflows. Plan mode helps avoid accidental edits, but long, collaborative specs lost some value once large context windows and agent orchestration let models explore complex tasks. Still, small, reviewable PRs remain critical for multi‑maintainer projects.

[![Slide 5](/podcast/slides/BBxu5L9ywqk/youtube-BBxu5L9ywqk/slide_0005_1749.67s.png)](https://youtu.be/BBxu5L9ywqk?t=1749)
## Agents land RFC and tests
Fable performed a schema/version sweep across Terraform/OpenTofu provider plugin protocols, suggested switching validation to runtime at apply time, and generated multiple small, conventional commits to implement the RFC. Hermes (a separate agent) created demo examples, ran terraform plan against the author’s account, collected UX integration notes (memory/timeouts, import behaviors), and prepared draft review comments for manual approval.

[![Slide 6](/podcast/slides/BBxu5L9ywqk/youtube-BBxu5L9ywqk/slide_0006_2185.79s.png)](https://youtu.be/BBxu5L9ywqk?t=2185)
## Agent limits, PRs, and tooling
Practical friction: agents consume session quotas fast, sometimes time out or run out of memory, and can post noisy or premature comments if not tightly controlled. The hosts also noted web‑scraping/search challenges for sourcing LinkedIn posts and model cards (some agent tools worked better than general LLM search). They saw agents expose real problems with PR workflows (bottlenecks, trust, noisy automated reviewers) and flagged the need for smaller commits, better sequencing, and guardrails before fully delegating reviews to agents.

*Model: openai/gpt-5-mini*
