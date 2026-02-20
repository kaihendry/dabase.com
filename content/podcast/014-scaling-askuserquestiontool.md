---
title: "Scaling AskUserQuestionTool"
date: 2026-01-03T12:00:00Z
description: "Vibe coded Chrome extension to show Amazon UK Data First Available: https://github.com/kaihendry/date-first-available

My failed thought experiment to get AI to setup my PI https://github.com/kaihendry/ai-pi

My blog about how I got my Pi setup as a VPS host: https://dabase.com/blog/2026/machinectl-trixie-pi/

Markdown to Confluence POC https://github.com/kaihendry/md-confluence

https://x.com/trq212/status/2005315275026260309 promotes the AskUserQuestionTool idea

Kiro seminar (PAID) https://www.eventbrite.com/e/hands-on-spec-driven-development-workshop-tickets-1812679024759?aff=so%E2%80%A6

https://steve-yegge.medium.com/welcome-to-gas-town-4f25ee16dd04"
image: "https://img.youtube.com/vi/V5Q8_3BuMcs/hqdefault.jpg"
draft: false

podcast:
  episode: 14
  season: 1
  episodeType: "full"
  duration: 4130
  audioUrl: "/podcast/audio/014-scaling-askuserquestiontool.mp3"
  audioSize: 99119162
  youtubeId: "V5Q8_3BuMcs"
  youtubeUrl: "https://www.youtube.com/watch?v=V5Q8_3BuMcs"
---

Vibe coded Chrome extension to show Amazon UK Data First Available: https://github.com/kaihendry/date-first-available

My failed thought experiment to get AI to setup my PI https://github.com/kaihendry/ai-pi

My blog about how I got my Pi setup as a VPS host: https://dabase.com/blog/2026/machinectl-trixie-pi/

Markdown to Confluence POC https://github.com/kaihendry/md-confluence

https://x.com/trq212/status/2005315275026260309 promotes the AskUserQuestionTool idea

Kiro seminar (PAID) https://www.eventbrite.com/e/hands-on-spec-driven-development-workshop-tickets-1812679024759?aff=so%E2%80%A6

https://steve-yegge.medium.com/welcome-to-gas-town-4f25ee16dd04

[Watch on YouTube](https://www.youtube.com/watch?v=V5Q8_3BuMcs)

## `summarize "https://youtu.be/V5Q8_3BuMcs" --timestamps --slides`

A long, informal conversation between two engineers about experiments with AI-driven development and lightweight infra. They demo a small Chrome extension and cloud coding workflows, describe a Raspberry Pi used to spin up many tiny VPSes with public IPs, and debate reproducibility, testing and how to fold AI into spec-driven development for teams. Key concrete details: the Pi hosts a subnet of about 64 public IPs (roughly 62 usable), the Pi has ~4 GB of RAM, a guest tool called Gastown can cost ~three subscriptions at about $200 each (~$600/month), and the speakers repeatedly stress the need for integration tests and docs-first validation. Two lines stand out as representative: *"Build reliable infrastructure with confidence."* and *"you don't create mock-ups or you don't come with a design specification with AI. You come with an MVP."*
[![Slide 1](/podcast/slides/V5Q8_3BuMcs/youtube-V5Q8_3BuMcs/slide_0001_2.38s.png)](https://youtu.be/V5Q8_3BuMcs?t=2)
## Chrome extension and local AI tooling
They built a tiny Chrome extension to scrape Amazon details and experimented with multiple LLM front-ends (Claude, Gemini, Conductor) and "cloud code" sessions. The extension turned into more generated files than expected — roughly dozens of supporting files for a small JS feature — and the speakers note that AI scaffolding can feel bureaucratic compared with the 100 lines of core code. The session stores screenshots and artifacts (cloud code keeps images in the home directory), and they discovered a non-programmatic shortcut: Amazon's on-page AI assistant ("Rufus") can answer product-age questions directly, which reduces the need for the extension for that single task. The speakers also show how AI assistants can hallucinate small CLI aliases (typos like "BD comment ad" vs "BD comment add") and stress that hallucinations are useful design signals when handled cautiously.

[![Slide 2](/podcast/slides/V5Q8_3BuMcs/youtube-V5Q8_3BuMcs/slide_0002_680.32s.png)](https://youtu.be/V5Q8_3BuMcs?t=680)
## Raspberry Pi as a tiny VPS host
One participant uses a Raspberry Pi to bootstrap many isolated VPS-like containers using systemd-nspawn (a systemd container primitive). He maps an entire public subnet to the Pi so each nspawn instance can "own" its public IP; he reports having 64 total IPs from his ISP (about 62 usable). The Pi is modest (about 4 GB of RAM) but considered "fast enough" for many small experiments; each container usually runs very little (an SSHD and a setup script). The setup flow pulls SSH keys from GitHub to populate authorized_keys, disables password auth, and then the container can run Docker or other services. They discuss socket-activation and service activation patterns (systemd features) so containers can be dormant until traffic arrives, and compare this lightweight approach to serverless and Firecracker-style micro-VM isolation while flagging that container isolation still has security tradeoffs.

[![Slide 3](/podcast/slides/V5Q8_3BuMcs/youtube-V5Q8_3BuMcs/slide_0003_1368.60s.png)](https://youtu.be/V5Q8_3BuMcs?t=1368)
## Agents, beats, hallucinations and Gastown costs
They discuss "beats" (an agent/task markup workflow) and its integration with cloud sessions; agents sometimes mis-invoke commands due to minor token or alias mismatches, which exposes brittle UX edges in agent tooling. The guest project Gastown is invoked as an example of a powerful but costly platform: the speaker cites running three cloud subscriptions around $200 each, implying roughly $600/month in baseline cost for his Gastown setup. They emphasize that LLMs often fail in human-like ways and that hallucinations should be treated as test cases or cues to improve the spec/UX. The conversation also touches on the idea that when an agent fails repeatedly at a decision point, that signals a design ambiguity that humans likely share.

[![Slide 4](/podcast/slides/V5Q8_3BuMcs/youtube-V5Q8_3BuMcs/slide_0004_2062.72s.png)](https://youtu.be/V5Q8_3BuMcs?t=2062)
## Docs-first, Markdown, and enterprise friction
A recurring theme: treat the Git repository as the source of truth and start with text/Markdown specs so AI can consume and iterate them. They contrast this with enterprises that still rely on multiple doc silos (Confluence, Google Docs, Word, Notion), which complicates an AI-in-the-loop workflow. The speakers argue for a flow where design artifacts (mockups, specs) are plain text that feed LLM-driven generation, then integrate back into repo docs and tests. They acknowledge cultural hurdles: many stakeholders don't use Markdown or repositories, so adoption requires bridging tools and automation that sync repo docs into enterprise doc platforms and keep stakeholders in the loop without forcing them into developer tools.

[![Slide 5](/podcast/slides/V5Q8_3BuMcs/youtube-V5Q8_3BuMcs/slide_0005_2745.20s.png)](https://youtu.be/V5Q8_3BuMcs?t=2745)
## Coordination: "ask user" tool, planning and context limits
They sketch an "ask user" or "ask group" pattern: an automated prompt flow that polls stakeholders with simple choices to speed alignment, akin to planning-poker or majority polling for decisions. Open-source tooling (OpenCode and terminal-sharing tools like Warp) are discussed as integration points; OpenCode maintainers are adding plugin hooks so interactive flows like ask-user can run across different front ends rather than being terminal-only. The speakers reference Human Layers and the "harness engineering" talk about context window management and the productivity cliff: when only ~30–40% of the context window remains free, work becomes non-productive. They emphasize lightweight voting and alignment UX (unanimous vs majority), and the practical need for a loop that surfaces AI output to stakeholders quickly.

[![Slide 6](/podcast/slides/V5Q8_3BuMcs/youtube-V5Q8_3BuMcs/slide_0006_3433.84s.png)](https://youtu.be/V5Q8_3BuMcs?t=3433)
## MVP-first development, tests and maintainability
Their recommended workflow: identify a minimal viable product (MVP) from the spec, let agents implement it, then validate via integration/end-to-end tests. Playwright (test harness) and integration tests are critical validation artifacts that must run reliably and be separated from a single ephemeral workspace; one speaker caught a design bug where server-side code read files from the same workspace rather than from a separate server workspace, so they refactored tests to ensure server and client run in isolated folders. They argue that good docs + integration tests are the guardrails that make agent-driven changes safe: if integration tests fail, you know the docs/tests disagree with the implementation. They accept that full enterprise systems remain hard to spin up for tests, so automation and environment bootstrapping are prerequisites for safe AI-driven workflows.

*Model: openai/gpt-5-mini*
