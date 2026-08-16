---
title: "Be nice to your agent"
date: 2026-06-26T12:20:50Z
description: "Join us as we dive into the world of AI agents and their impact on productivity! In this video, we discuss the challenges and innovations surrounding AI tools like Claude and Hermes, and how they can revolutionize your workflow."
image: "https://dabase.com/podcast/images/037-be-nice-to-your-agent.jpg"
thumbnail: "https://dabase.com/podcast/images/037-be-nice-to-your-agent-wide.jpg"

podcast:
  episode: 37
  season: 1
  episodeType: "full"
  duration: 3227
  audioUrl: "https://dabase.com/podcast/audio/037-be-nice-to-your-agent.mp3"
  audioSize: 77443820
  youtubeId: "zgmdFmC-mFo"
  youtubeUrl: "https://www.youtube.com/watch?v=zgmdFmC-mFo"
---

Join us as we dive into the world of AI agents and their impact on productivity! In this video, we discuss the challenges and innovations surrounding AI tools like Claude and Hermes, and how they can revolutionize your workflow.

Key takeaways:

* Understanding the role of AI agents in modern work environments.
* The importance of user feedback in AI development.
* How to effectively integrate AI tools into your daily tasks.
* The balance between automation and manual processes.

Timestamps:
- [00:00](https://youtu.be/zgmdFmC-mFo?t=0) Introduction
- [00:30](https://youtu.be/zgmdFmC-mFo?t=30) The evolution of AI agents
- [02:15](https://youtu.be/zgmdFmC-mFo?t=135) User feedback and AI improvements
- [05:00](https://youtu.be/zgmdFmC-mFo?t=300) Integrating AI into workflows
- [08:45](https://youtu.be/zgmdFmC-mFo?t=525) Challenges with automation
- [12:00](https://youtu.be/zgmdFmC-mFo?t=720) Conclusion

What's your biggest challenge with AI tools? Drop it in the comments!

Subscribe for more insights on AI and productivity!

#AI #Productivity #Automation

[Watch on YouTube](https://www.youtube.com/watch?v=zgmdFmC-mFo)

## `summarize "https://youtu.be/zgmdFmC-mFo" --timestamps --slides`

A frank, practical conversation about using AI agents in real engineering workflows: two hosts start with casual mic banter and quickly dive into the headaches and wins of running conversational agents (Claude, Hermes, OpenClaw) for code review, testing, PR automation and team workflows. They describe ingesting session logs into ClickHouse and running an LLM classifier to label “remarkable” or “sensitive” sessions, and they stress the risk of accidental information leakage such as exposed file paths or private-key references; the guest reads a system prompt that warns operators to *Tool results may include data from external sources.* They show how an agent can run end‑to‑end tests on AWS (synthesizing and applying Terraform, validating Lambda behavior with Teratest, then tearing resources down), and how agents can both find real bugs and also do unsafe things — like cloning and executing external repos — which creates security and governance challenges. Operational friction is a recurring theme: org token budgets and API billing make “bring your own” models attractive but risky, agents sometimes take longer than manual edits for trivial tasks, and productionizing agents needs gateways, threading, determinism and strict approval controls. They explain building custom gateway hooks so agent outputs stay threaded in Discord, the difficulty of keeping agents from self-modifying dangerous parts of infrastructure, and the value of validating every lesson command in a repo when using a “teach” skill to build courses; the episode closes with the tongue‑in‑cheek moral: *Be nice to your agent.*

[![Slide 1](/podcast/slides/zgmdFmC-mFo/youtube-zgmdFmC-mFo/slide_0001_0.28s.png)](https://youtu.be/zgmdFmC-mFo?t=0)
## Mic check & setup
Hosts troubleshoot hardware and pivot to the week’s theme: enterprise constraints on agent usage, token budgets, and the practical pressure to “bring your own” AI tools into work.

[![Slide 2](/podcast/slides/zgmdFmC-mFo/youtube-zgmdFmC-mFo/slide_0002_531.12s.png)](https://youtu.be/zgmdFmC-mFo?t=531)
## Logging, ClickHouse and classifiers
They describe ingesting agent session data into ClickHouse and running a classifier in auto mode to tag sensitive or remarkable sessions, noting the system prompt that instructs models to warn users about suspected prompt injection.

[![Slide 3](/podcast/slides/zgmdFmC-mFo/youtube-zgmdFmC-mFo/slide_0003_1067.58s.png)](https://youtu.be/zgmdFmC-mFo?t=1067)
## PR reviews with Hermes
A Hermes agent integrated into Discord performs deep PR reviews (including VPC lookup logic), creates skills tailored to the repo, spots proven issues in unit tests and region handling, and can run end‑to‑end validations.

[![Slide 4](/podcast/slides/zgmdFmC-mFo/youtube-zgmdFmC-mFo/slide_0004_1605.38s.png)](https://youtu.be/zgmdFmC-mFo?t=1605)
## Reproducing bugs and CI gotchas
Agents successfully reproduce bugs by pulling repos and proposing one‑line fixes, but draft/CI interactions, noisy channels and agent behavior in public groups raise safety and UX concerns.

[![Slide 5](/podcast/slides/zgmdFmC-mFo/youtube-zgmdFmC-mFo/slide_0005_2149.83s.png)](https://youtu.be/zgmdFmC-mFo?t=2149)
## Testing and provider work
They compare Terraform test vs Teratest for complex end‑to‑end checks, explain CFN signal mechanics for orchestration, and recall writing Terraform providers and the tooling tradeoffs involved.

[![Slide 6](/podcast/slides/zgmdFmC-mFo/youtube-zgmdFmC-mFo/slide_0006_2680.96s.png)](https://youtu.be/zgmdFmC-mFo?t=2680)
## Gateways, production and sandboxes
A custom Discord gateway hook solved threading and interactive card issues, Claude helped detect a mistaken branch via version hashes, and they discuss productionizing agents with Agent Core and sandbox microVMs while stressing governance and observability.

*Model: openai/gpt-5-mini*
