---
title: "Agent IDE"
date: 2026-08-26T18:55:28Z
description: "Is the terminal becoming the IDE, or is the IDE becoming an agent? Kai has spent two days living in Orca, a terminal-shaped harness that runs Claude Code, Codex and friends side by side, with worktrees, a diff pager you can comment on, and a mobile app that talks to your laptop over your own LAN."
image: "https://dabase.com/podcast/images/042-agent-ide.jpg"
thumbnail: "https://dabase.com/podcast/images/042-agent-ide-wide.jpg"

podcast:
  episode: 42
  season: 1
  episodeType: "full"
  duration: 3329
  audioUrl: "https://dabase.com/podcast/audio/042-agent-ide.mp3"
  audioSize: 79906220
  youtubeId: "yr5un6yvfPY"
  youtubeUrl: "https://www.youtube.com/watch?v=yr5un6yvfPY"
---

Is the terminal becoming the IDE, or is the IDE becoming an agent?

Kai has spent two days living in Orca, a terminal-shaped harness that runs Claude Code,
Codex and friends side by side, with worktrees, a diff pager you can comment on, and a
mobile app that talks to your laptop over your own LAN. Vincent pushes back from the other
direction: agents that hold their own authority, their own memory and their own dashboard,
running on a box at home while you sleep.

Along the way: why HTML artifacts are replacing markdown for planning, SSH over 443 to get
out of a locked-down work laptop, what OpenRouter got right that Bedrock got wrong, and
Vincent's three-week benchmark pitting raw Terraform against AWS CDK against TerraConstructs
— which produced the opposite result to the one he expected.

Chapters below.

## Chapters

- [0:00](https://youtu.be/yr5un6yvfPY?t=0) Intro
- [0:46](https://youtu.be/yr5un6yvfPY?t=46) Orca: a terminal-shaped agent IDE
- [2:01](https://youtu.be/yr5un6yvfPY?t=121) Mobile access, Tailscale and the LAN problem
- [5:04](https://youtu.be/yr5un6yvfPY?t=304) Is this the future of the IDE?
- [7:30](https://youtu.be/yr5un6yvfPY?t=450) Multiplayer HTML artifacts instead of markdown
- [10:23](https://youtu.be/yr5un6yvfPY?t=623) SSH over 443 and locked-down work laptops
- [13:37](https://youtu.be/yr5un6yvfPY?t=817) Agents that keep working while you sleep
- [14:48](https://youtu.be/yr5un6yvfPY?t=888) Codex vs Claude: switching models mid-task
- [16:53](https://youtu.be/yr5un6yvfPY?t=1013) Memory: what the agent knows outside your repo
- [19:55](https://youtu.be/yr5un6yvfPY?t=1195) What a dashboard actually looks like
- [21:04](https://youtu.be/yr5un6yvfPY?t=1264) Publishing artifacts, comments and CloudFront costs
- [26:45](https://youtu.be/yr5un6yvfPY?t=1605) OpenRouter, LiteLLM and budgeting on Bedrock
- [29:51](https://youtu.be/yr5un6yvfPY?t=1791) Orca's recipes and documentation
- [31:21](https://youtu.be/yr5un6yvfPY?t=1881) Pilot vs delegate: two levels of autonomy
- [33:08](https://youtu.be/yr5un6yvfPY?t=1988) From POC to product: taking back control
- [34:42](https://youtu.be/yr5un6yvfPY?t=2082) Benchmarking infrastructure-as-code with AWS Bench
- [39:39](https://youtu.be/yr5un6yvfPY?t=2379) Three arms: raw Terraform, AWS CDK, TerraConstructs
- [44:06](https://youtu.be/yr5un6yvfPY?t=2646) Surprise: raw Terraform wins greenfield
- [47:35](https://youtu.be/yr5un6yvfPY?t=2855) Day one vs day two: where abstractions pay off
- [49:13](https://youtu.be/yr5un6yvfPY?t=2953) Multi-step trials and the Lambda redeploy gotcha
- [52:25](https://youtu.be/yr5un6yvfPY?t=3145) Mining 225 scenarios from GitHub issues

## Mentioned

Orca · Claude Code · Codex · Kiro Crew · Hermes · OpenClaw · Ghostty · tmux ·
OpenRouter · LiteLLM · AWS Bedrock · AWS Bench · Harbor · Terraform · AWS CDK ·
TerraConstructs / CDKTF · OPA · Tailscale · WireGuard

[Watch on YouTube](https://www.youtube.com/watch?v=yr5un6yvfPY)

## `summarize "https://youtu.be/yr5un6yvfPY" --timestamps --slides`

This episode examines "agent IDEs": tools that blend terminal-style developer workflows with autonomous agents that can read, edit, run and publish code and artifacts. Kai Hendry describes two days of heavy use of Orca, comparing its terminal-like interface, agent integrations and artifact publishing to more agent-first systems; the hosts then broaden into model choice, remote always-on agents, and an AWS Bench project that benchmarks how well different IaC approaches work with AI-driven code generation.

[![Slide 1](/podcast/slides/yr5un6yvfPY/youtube-yr5un6yvfPY/slide_0001_3.03s.png)](https://youtu.be/yr5un6yvfPY?t=3)
## Agent IDEs and Orca overview
Orca is presented as a terminal-shaped harness that supports multiple agent backends, exposes sessions as tabbed terminals and makes it easy to open new work trees pre-populated with repository context and issue metadata, which speeds a developer's loop when switching tasks.

[![Slide 2](/podcast/slides/yr5un6yvfPY/youtube-yr5un6yvfPY/slide_0002_546.92s.png)](https://youtu.be/yr5un6yvfPY?t=546)
## UX strengths and early negatives
Kai praises Orca's tasteful diff pager, inline comments and simple work-tree flow but notes limits: SSH file/image pushing was flaky and multi-host mobile pairing can be awkward; *"I think this is getting damn close to it."* captures the sense that terminal-first agent tooling is nearly an IDE evolution.

[![Slide 3](/podcast/slides/yr5un6yvfPY/youtube-yr5un6yvfPY/slide_0003_1101.80s.png)](https://youtu.be/yr5un6yvfPY?t=1101)
## Always-on agents vs local harnesses
The hosts debate running agents remotely so workflows survive laptop sleep and network changes; they contrast harness-style tools (you pilot, agent assists) with agent-first systems that own their machine, memory and scheduling and can run cron-like work while you sleep, raising questions about control, identity and operational trust.

[![Slide 4](/podcast/slides/yr5un6yvfPY/youtube-yr5un6yvfPY/slide_0004_1656.68s.png)](https://youtu.be/yr5un6yvfPY?t=1656)
## Artifacts, interactive HTML and rendering trade-offs
Orca can produce artifacts and publish them (Kai demonstrated artifacts published to CloudFront, though CSS/interactive edge cases remain), and the conversation imagines interactive HTML/MDX artifacts with inline comments and voting; *You get the artifact in line right here.* Hashimoto's ghostty/terminal multiplexer is mentioned as an alternate route to richer terminal rendering.

[![Slide 5](/podcast/slides/yr5un6yvfPY/youtube-yr5un6yvfPY/slide_0005_2210.48s.png)](https://youtu.be/yr5un6yvfPY?t=2210)
## Delegation levels and production readiness
They distinguish two modes: assisted development where the human reviews and submits work under their name (Orca) versus full delegation where agents autonomously open PRs and manage tasks (Kiro/Hero Crew); moving from proof-of-concept agent workflows to production requires reintroducing spec-driven slices, guardrails and more hands-on control to keep systems maintainable.

[![Slide 6](/podcast/slides/yr5un6yvfPY/youtube-yr5un6yvfPY/slide_0006_2758.92s.png)](https://youtu.be/yr5un6yvfPY?t=2758)
## AWS Bench experiment and surprising IaC results
Kai describes an AWS Bench setup that auto-generates trials across three IaC arms (raw Terraform, AWS CDK, Terra Constructs), provisions isolated accounts, runs Claude Code and validates outputs with OPA-based oracles. Early findings surprised him: raw Terraform was more token- and turn-efficient on greenfield tasks because the model confidently emits common Terraform patterns, whereas higher-level Terra Constructs forced the model to spend many turns reading niche library code; this motivated adding multi-step, brownfield scenarios and mining GitHub issues to surface real operational "day two" pitfalls for more meaningful benchmarking.

*Model: openai/gpt-5-mini*
