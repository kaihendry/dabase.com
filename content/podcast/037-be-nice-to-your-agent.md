---
title: "Be nice to your agent"
date: 2026-06-26T12:00:00Z
description: "AI agents for developer workflows: automated PR review, end-to-end testing, Discord orchestration, security trade-offs, and why being nice to your agent matters."
image: "https://dabase.com/podcast/images/037-be-nice-to-your-agent.jpg"

podcast:
  episode: 37
  season: 1
  episodeType: "full"
  duration: 3227
  audioUrl: "https://dabase.com/podcast/audio/037-be-nice-to-your-agent.mp3"
  audioSize: 77443821
  youtubeId: "zgmdFmC-mFo"
  youtubeUrl: "https://www.youtube.com/watch?v=zgmdFmC-mFo"
---

AI agents for developer workflows: automated PR review, end-to-end testing, Discord orchestration, security trade-offs, and why being nice to your agent matters.

[Watch on YouTube](https://www.youtube.com/watch?v=zgmdFmC-mFo)

## `summarize "https://youtu.be/zgmdFmC-mFo" --timestamps --slides`

This conversation is a wide-ranging, practical look at using personal AI agents for developer workflows: setup hiccups, security and privacy trade-offs, automated PR review and end-to-end testing, orchestration inside chat platforms, and lessons from building a teachable course about agent runtimes. The hosts show real examples (ingested session logs, an agent-run PR migration and E2E tests, a Discord gateway hook) and repeatedly weigh convenience against risk and fragility. *"Tool results may include data from external sources."*

[![Slide 1](/podcast/slides/zgmdFmC-mFo/youtube-zgmdFmC-mFo/slide_0001_0.28s.png)](https://youtu.be/zgmdFmC-mFo?t=0)
## Quick setup and context
The hosts start with mic and studio setup, then pivot to the central theme: switching between personal and organization AI accounts is painful and costly because API/token budgets and enterprise controls make agent use brittle for engineers who bring their own tools.

[![Slide 2](/podcast/slides/zgmdFmC-mFo/youtube-zgmdFmC-mFo/slide_0002_531.12s.png)](https://youtu.be/zgmdFmC-mFo?t=531)
## Privacy, logs and classifier checks
They discuss ingesting session data into a central store (ClickHouse) and running classifiers to flag sensitivity; classifiers can be over-eager (flagging file paths) but help surface issues like private key exposure; agent memories can be triggered by positive feedback and that behavior matters for privacy and correctness.

[![Slide 3](/podcast/slides/zgmdFmC-mFo/youtube-zgmdFmC-mFo/slide_0003_1067.58s.png)](https://youtu.be/zgmdFmC-mFo?t=1067)
## Agent review of a big PR
An agent (Hermes) was told to review a large migration PR and actually found substantive problems: incorrect use of an "is-default" filter, region passing issues and bad unit test assumptions; the agent also created and adapted review skills (Ponytail) to match reviewer preferences.

[![Slide 4](/podcast/slides/zgmdFmC-mFo/youtube-zgmdFmC-mFo/slide_0004_1605.38s.png)](https://youtu.be/zgmdFmC-mFo?t=1605)
## Running real end-to-end tests
They describe delegating E2E work to agents that synthesize config, run TerraTest-style provisioning against an AWS account, validate behavior (deploy, hit endpoints, check logs) and tear down resources; TerraTest is preferred for complex, procedural validation that declarative test DSLs can't easily express.

[![Slide 5](/podcast/slides/zgmdFmC-mFo/youtube-zgmdFmC-mFo/slide_0005_2149.83s.png)](https://youtu.be/zgmdFmC-mFo?t=2149)
## Orchestration, threading and security quirks
To keep agent output readable in Discord they built gateway hooks and cron-driven workflows that create threads, track PR state and post updates; this required custom code because naive agent postings spread noise, and it exposed attack vectors when agents pull and execute arbitrary repos or auto-apply tiny fixes.

[![Slide 6](/podcast/slides/zgmdFmC-mFo/youtube-zgmdFmC-mFo/slide_0006_2680.96s.png)](https://youtu.be/zgmdFmC-mFo?t=2680)
## Practical trade-offs and final takeaways
Agents often automate heavy tasks well but can be slower or more error-prone than manual edits for tiny jobs; productionising agents needs observability, governance and careful permissioning; the author is building a validated course and tooling around agent runtimes and closes with the human reminder: be nice to your agent.

*Model: openai/gpt-5-mini*
