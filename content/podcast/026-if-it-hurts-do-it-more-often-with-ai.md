---
title: "If it Hurts, do it More Often (with AI)"
date: 2026-03-25T12:00:00Z
description: "Show notes: https://docs.google.com/document/d/1zoc-0L1o1Cyxtgatb9fN_ZGBGbshZIb9BTzwEj0C4Gc/edit?tab=t.0


00:00 - Introduction
02:00 - Automating AI Agents
04:20 - Auto Research Role
07:15 - Building CLI Tools
09:50 - AI Behavior Control
13:00 - Voice & AI Transcription
15:45 - GitHub Security
18:50 - Multi-cloud Management
22:50 - Disaster Recovery Testing
28:30 - Cost Optimization
33:00 - Terraform vs CDK
38:45 - AI Evaluations
44:00 - AI in Enterprise
50:00 - Ethical Considerations
55:00 - Kubernetes Strategies
58:00 - DevOps Myths
62:00 - Cloud Security Insights
66:00 - Closing Thoughts"
image: "https://dabase.com/podcast/images/026-if-it-hurts-do-it-more-often-with-ai.jpg"
draft: false

podcast:
  episode: 26
  season: 1
  episodeType: "full"
  duration: 3663
  audioUrl: "https://dabase.com/podcast/audio/026-if-it-hurts-do-it-more-often-with-ai.mp3"
  audioSize: 87920109
  youtubeId: "nze_Id-PpYM"
  youtubeUrl: "https://www.youtube.com/watch?v=nze_Id-PpYM"
---

Show notes: https://docs.google.com/document/d/1zoc-0L1o1Cyxtgatb9fN_ZGBGbshZIb9BTzwEj0C4Gc/edit?tab=t.0


00:00 - Introduction
02:00 - Automating AI Agents
04:20 - Auto Research Role
07:15 - Building CLI Tools
09:50 - AI Behavior Control
13:00 - Voice & AI Transcription
15:45 - GitHub Security
18:50 - Multi-cloud Management
22:50 - Disaster Recovery Testing
28:30 - Cost Optimization
33:00 - Terraform vs CDK
38:45 - AI Evaluations
44:00 - AI in Enterprise
50:00 - Ethical Considerations
55:00 - Kubernetes Strategies
58:00 - DevOps Myths
62:00 - Cloud Security Insights
66:00 - Closing Thoughts

[Watch on YouTube](https://www.youtube.com/watch?v=nze_Id-PpYM)

## `summarize "https://youtu.be/nze_Id-PpYM" --timestamps --slides`

A technical conversation between two engineers covers hands-on AI agent work, tooling decisions, multi-account cloud operations, and how AI changes tedious platform tasks. The speakers trade notes on practical agent-driven development (Spec Ledger), overnight automated experiments (auto research), token/context limits, test strategies, infrastructure bootstrapping, security practices around Git/GitHub, and comparisons of Terraform-style tools and reimplementations. The tone is pragmatic: what worked, what diverged from plan, and which manual chores are now realistic to automate.

[![Slide 1](/podcast/slides/nze_Id-PpYM/youtube-nze_Id-PpYM/slide_0001_0.28s.png)](https://youtu.be/nze_Id-PpYM?t=0)
## Quick session model and FOMO
They open by describing short, focused sessions: two-hour runs where a developer brings an idea, builds a V0 mock with static data, then the speaker adds a small working feature and shows a development approach. The speaker expresses FOMO about the common claim that agents can run experiments overnight and produce meaningful results while you’re away. The call frames the problem: many people claim agents loop until a global goal is reached, but the speaker hasn’t routinely left agents running long enough to see those returns.

[![Slide 2](/podcast/slides/nze_Id-PpYM/youtube-nze_Id-PpYM/slide_0002_604.71s.png)](https://youtu.be/nze_Id-PpYM?t=604)
## Building a CLI with an AI agent
They walk through a concrete example: the speaker needed raw API responses (curl calls hidden behind a web UI) so an agent fetched endpoints and exported many curl commands. He documented the steps in markdown, pointed Spec Ledger at that doc and asked it to write user stories, then asked the agent to scan cloud code sessions to find usage scenarios and edge cases. The agent produced a full spec and a task list (about 40 tasks) including a Go CLI and end-to-end testing using VCR-style HTTP cassette replays. The workflow succeeded at implementing the CLI; the agent “completed the task very quickly, implemented the CLI.” Token and model constraints shaped the session: the speaker used Opus 4.6 with a 1,000,000-token context window, noted the session had consumed ~15% (≈150,000 tokens), and warned that once a context buffer hits ~20% they reset sessions because behavior degrades. The run exposed two types of issues: the agent diverged from the spec (putting code under internal/ so it wasn’t a public library) and it claimed E2E was out of scope despite being requested.

[![Slide 3](/podcast/slides/nze_Id-PpYM/youtube-nze_Id-PpYM/slide_0003_1213.67s.png)](https://youtu.be/nze_Id-PpYM?t=1213)
## Guardrails, BDD and human input modes
They discuss strategies to keep agents on-spec: write BDD/Gherkin tests first so they act as acceptance gates and don’t let the agent stop until BDDs pass. Claude/Anthropic releases add remote/phone checks so you can leave long-running work and inspect status, but some API/service keys limit those features. Voice input is mixed: demos are fun but dictation often requires editing; typing helps the speaker formulate thoughts. Practical workflow notes surface (paper to-do lists still preferred for clarity).

[![Slide 4](/podcast/slides/nze_Id-PpYM/youtube-nze_Id-PpYM/slide_0004_1820.12s.png)](https://youtu.be/nze_Id-PpYM?t=1820)
## Credentials, Git hygiene, and GitHub apps
They cover credential leakage and Git history: removing secrets from commits doesn’t fully remove exposure because bots and cached history can reveal leaked hashes; the correct immediate action is credential rotation. For automation on GitHub, they recommend GitHub Apps over machine-user PATs: apps have clearer, fine-grained permissions, install-to-repo identities, and use an app identity plus installation to mint short-lived tokens. The auth model is nontrivial (app ID, private key, installation ID → short-lived token), and orgs sometimes block rollout because visibility/permissions are tricky. On local credential tooling they mention AWS-vault (uses macOS keychain or pass on Linux) and the complexity for onboarding Windows users (WSL and GPG/pass setup).

[![Slide 5](/podcast/slides/nze_Id-PpYM/youtube-nze_Id-PpYM/slide_0005_2432.42s.png)](https://youtu.be/nze_Id-PpYM?t=2432)
## Multi-account AWS, logs, and disaster recovery
For multi-account AWS setups, Control Tower (when enabled) auto-bootstraps an organizational structure—audit, security, centralized log accounts—and deploys stacks to forward logs across accounts; doing this manually is painful. Many teams end up plugging commercial observability (DataDog) via CloudFormation wrappers; that works but can blow costs because DataDog scrapes many endpoints and default CloudWatch metric granularity (≈15 minutes) can surprise people. They stress disaster-recovery checklist discipline: test restores regularly (RTO/RPO must be defined), pick a recovery strategy (pilot light, warm standby, full failover), and do threat modeling ("Is it a hack? Is it an intrusion?"). The speakers argue AI makes many tedious validation tasks plausible to automate—periodic restore validation and bootstrapping can be offloaded to agents so humans don’t avoid these boring but critical exercises.

[![Slide 6](/podcast/slides/nze_Id-PpYM/youtube-nze_Id-PpYM/slide_0006_3043.37s.png)](https://youtu.be/nze_Id-PpYM?t=3043)
## Reimplementations, licensing and infra tool choices
They review recent projects and reimplementations: a Rust project re-implemented a Terraform-like execution engine that speaks provider protocols directly and stores state in SQLite/Postgres, producing usable results quickly though not yet matching mature commercial stability. Licensing and ethics arise: enterprises avoid AGPL/MPL ambiguity and some propose AI-driven re-implementations as a way to avoid restrictive licenses, which raises legal and moral questions. They demo Taco’s Guru, a lightweight evaluation site where criteria weights are configurable to compare platforms (Terraform, CDK, CDK for Kubernetes, etc.), and note Ops Zero AI and Oxit integrations. On Kubernetes bootstrapping and app stacks they debate using CDK vs. Terraform: CDK is more intuitive inside AWS/EKS blueprints and often gets new features earlier via CloudFormation/CDK L2 constructs, while Terraform modules are widespread but can grow very complex and slow. Final operational advice: prefer GitHub Apps for automation tokens, avoid pinned action patterns that let forks inject malicious code, and use automated tests and BDD gates to prevent agents from drifting off-plan.
*It completed the task very quickly, implemented the CLI.*
*Is it a hack? Is it an intrusion?*

*Model: openai/gpt-5-mini*
