---
title: "Agent Client Protocol"
date: 2026-08-16T17:37:15Z
description: "This episode is a conversational walkthrough of Kiro Crew (an AWS-hosted agent gateway and dashboard), how it uses the agent client protocol (ACP), what running and extending it looks like, and practical lessons about memory, embeddings, deployment and costs."
image: "https://dabase.com/podcast/images/041-agent-client-protocol.jpg"
thumbnail: "https://dabase.com/podcast/images/041-agent-client-protocol-wide.jpg"

podcast:
  episode: 41
  season: 1
  episodeType: "full"
  duration: 2811
  audioUrl: "https://dabase.com/podcast/audio/041-agent-client-protocol.mp3"
  audioSize: 67471532
  youtubeId: "82R2F0Vz69U"
  youtubeUrl: "https://www.youtube.com/watch?v=82R2F0Vz69U"
---

- [0:00](https://youtu.be/82R2F0Vz69U?t=0) Holiday, kids, and startup life
- [3:58](https://youtu.be/82R2F0Vz69U?t=238) The pressure to stay relevant with AI
- [5:06](https://youtu.be/82R2F0Vz69U?t=306) Solar farms vs food security
- [5:49](https://youtu.be/82R2F0Vz69U?t=349) Screen share: what is Kiro Crew?
- [8:06](https://youtu.be/82R2F0Vz69U?t=486) Agent Client Protocol is not MCP
- [10:23](https://youtu.be/82R2F0Vz69U?t=623) Where does the gateway actually run?
- [11:24](https://youtu.be/82R2F0Vz69U?t=684) Remote crew: one command to launch on EC2
- [15:53](https://youtu.be/82R2F0Vz69U?t=953) Memory systems: Hermes vs Kiro out of the box
- [18:19](https://youtu.be/82R2F0Vz69U?t=1099) What an embedding model actually does
- [20:26](https://youtu.be/82R2F0Vz69U?t=1226) Maintaining memories: markdown vs vector DB
- [21:53](https://youtu.be/82R2F0Vz69U?t=1313) The multiplayer question
- [23:46](https://youtu.be/82R2F0Vz69U?t=1426) The NAT gateway tax and fck-nat
- [27:41](https://youtu.be/82R2F0Vz69U?t=1661) Using it for real: diagrams and artifacts
- [29:19](https://youtu.be/82R2F0Vz69U?t=1759) Forking Kiro Crew onto a ChatGPT subscription
- [31:25](https://youtu.be/82R2F0Vz69U?t=1885) Elicitation and ACP capability mismatches
- [33:44](https://youtu.be/82R2F0Vz69U?t=2024) Faking usage reporting with a facade
- [35:56](https://youtu.be/82R2F0Vz69U?t=2156) Why a Claude Code ACP gets your account banned
- [38:47](https://youtu.be/82R2F0Vz69U?t=2327) Option chips beat AskUserQuestion
- [41:05](https://youtu.be/82R2F0Vz69U?t=2465) Local auto-classifier and trust prompts
- [42:40](https://youtu.be/82R2F0Vz69U?t=2560) Why AWS rewrote Kiro onto a single harness
- [43:43](https://youtu.be/82R2F0Vz69U?t=2623) The artifact reveal and publishing to S3
- [45:31](https://youtu.be/82R2F0Vz69U?t=2731) Take a break

[Watch on YouTube](https://www.youtube.com/watch?v=82R2F0Vz69U)

## `summarize "https://youtu.be/82R2F0Vz69U" --timestamps --slides`

This episode is a conversational walkthrough of Kiro Crew (an AWS-hosted agent gateway and dashboard), how it uses the agent client protocol (ACP), what running and extending it looks like, and practical lessons about memory, embeddings, deployment and costs. The hosts weave personal context into technical exploration, then demo a local Mac app that bundles a gateway, remote crew/cloud instances, artifact publishing and developer customizations. *"it uses the agent client protocol to connect everything."* 

[![Slide 1](/podcast/slides/82R2F0Vz69U/youtube-82R2F0Vz69U/slide_0001_0.87s.png)](https://youtu.be/82R2F0Vz69U?t=0)
## Holiday and balance
Hosts open with casual chatter about family time and taking a short holiday, using the break to reflect on work–life balance especially for people deeply involved in AI. Remote work during the pandemic enabled different work patterns but didn’t necessarily lead to early retirement for the speakers. The tone sets up a contrast between personal life and the pressure to stay current in AI.

[![Slide 2](/podcast/slides/82R2F0Vz69U/youtube-82R2F0Vz69U/slide_0002_460.54s.png)](https://youtu.be/82R2F0Vz69U?t=460)
## Pressure to stay relevant
Conversation shifts to the ongoing pressure to keep up with AI and investment choices that feel like lifelong work rather than a quick payoff. They touch on making work enjoyable while staying ahead of the pack. A short tangent debates infrastructure trade-offs like solar farms versus food security, illustrating how technical conversations drift into public-policy tradeoffs.

[![Slide 3](/podcast/slides/82R2F0Vz69U/youtube-82R2F0Vz69U/slide_0003_929.08s.png)](https://youtu.be/82R2F0Vz69U?t=929)
## Kiro Crew architecture
Kiro Crew is demonstrated as a local Mac OS app that bundles a Python gateway, a single‑page React UI and connects to a local CLI (Kiro/Kiro) via the agent client protocol. The gateway can run locally or be bootstrapped into the cloud as a separate remote gateway (via a crew cloud subcommand) so the dashboard shows sessions from that instance. The UI supports sessions, scheduled tasks, artifacts and a knowledge/memory layer; remote instances are reachable over SSH/SSM tunnels and can be scaled and stopped via EventBridge.

[![Slide 4](/podcast/slides/82R2F0Vz69U/youtube-82R2F0Vz69U/slide_0004_1395.79s.png)](https://youtu.be/82R2F0Vz69U?t=1395)
## Memories and embeddings
The hosts compare simple markdown-based memories with vectorized memory systems. Embedding models convert text into high-dimensional vectors that get stored in a vector database for semantic lookups. *"text becomes tokens tokens becomes a vector that gets stores into a vector database for semantic lookups."* They report practical limits with file‑based memories (size constraints, write failures) and describe running local small embedding models (e.g., Llama cpp) plus a Postgres-backed vector store for richer recall, cleanup and relevance tasks.

[![Slide 5](/podcast/slides/82R2F0Vz69U/youtube-82R2F0Vz69U/slide_0005_1866.17s.png)](https://youtu.be/82R2F0Vz69U?t=1866)
## Deployment and cost tradeoffs
Running a full cloud instance with local embedding models and memory systems is resource heavy and can be surprisingly costly because of components like NAT gateways and private subnets. Quick experiments on EC2 can cost only a few dollars per hour but a continuously running private instance with networking can approach ~$50/month depending on region. They describe mitigation strategies: scheduled scaling, choosing cheaper regions, and lightweight NAT replacements or iptables-based NAT for dev setups.

[![Slide 6](/podcast/slides/82R2F0Vz69U/youtube-82R2F0Vz69U/slide_0006_2334.71s.png)](https://youtu.be/82R2F0Vz69U?t=2334)
## Extending via forks and ACP gaps
The presenter explains they forked Kiro Crew to swap the default CLI/backend for a different model backend (Codex/CEX). That exposed protocol mismatches in ACP: some gateways don’t advertise elicitation (ask‑user) capabilities, causing structured UI interactions to fail or return 500 errors. Workarounds include presenting a facade that translates or surfaces usage and elicitation as simple option chips in the gateway, capturing usage as a side channel, and adjusting capability advertising. The fork is public so others can build a custom instance now; if accepted upstream, these changes could be merged into the main project.

*Model: openai/gpt-5-mini*
