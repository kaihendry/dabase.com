---
title: "Decision Records for AI"
date: 2026-07-30T12:00:00Z
description: "https://decisions.dabase.com/
https://github.com/kaihendry/decisions

For vulnerability management https://www.invicti.com/ previously known as https://kondukto.io/ was what I was referring to!"
image: "https://dabase.com/podcast/images/039-decision-records-for-ai.jpg"
draft: false

podcast:
  episode: 39
  season: 1
  episodeType: "full"
  duration: 2193
  audioUrl: "https://dabase.com/podcast/audio/039-decision-records-for-ai.mp3"
  audioSize: 52632045
  youtubeId: "RncFBrvly3w"
  youtubeUrl: "https://www.youtube.com/watch?v=RncFBrvly3w"
---

https://decisions.dabase.com/
https://github.com/kaihendry/decisions

For vulnerability management https://www.invicti.com/ previously known as https://kondukto.io/ was what I was referring to!

[Watch on YouTube](https://www.youtube.com/watch?v=RncFBrvly3w)

## `summarize "https://youtu.be/RncFBrvly3w" --timestamps --slides`

Vincent and Kai catch up after a month apart, with Vincent now working on-site as an AI platform lead, before diving into two recurring frustrations: managing tech debt and vulnerability alerts, and the lack of a single source of truth for company decisions.

[![Slide 1](/podcast/slides/RncFBrvly3w/youtube-RncFBrvly3w/slide_0001_1.50s.png)](https://youtu.be/RncFBrvly3w?t=1)
## Catching up after a month
Vincent has returned to office work for the first time in six years, taking on a new role focused on AI adoption from a platform perspective within a large, compliance-heavy organization that already has a dedicated AI platform team.

[![Slide 2](/podcast/slides/RncFBrvly3w/youtube-RncFBrvly3w/slide_0002_356.00s.png)](https://youtu.be/RncFBrvly3w?t=356)
## AI adoption meets compliance friction
Vincent describes navigating strict platform team controls built for good reason, and argues the goal isn't removing humans from the loop but improving signal versus noise. *It's able to surface very clearly where your attention is needed.*

[![Slide 3](/podcast/slides/RncFBrvly3w/youtube-RncFBrvly3w/slide_0003_722.08s.png)](https://youtu.be/RncFBrvly3w?t=722)
## The vulnerability triage problem
Kai vents about security dashboards flagging internal, low-risk dependencies as high or critical, with no good way to formally accept the risk or document why a fix isn't happening. He recalls using Twistlock in a past Kubernetes project for the Singapore government, which enforced strict network segregation and let teams flag findings with justifications and remediation timelines.

[![Slide 4](/podcast/slides/RncFBrvly3w/youtube-RncFBrvly3w/slide_0004_1088.79s.png)](https://youtu.be/RncFBrvly3w?t=1088)
## Vibe-coding a decisions site
Kai shares a tool he built, essentially an ADR (architecture decision record) system with a defined YAML schema, a validation step, and an auto-generated LLM's text endpoint, aimed at giving companies a single URL for tracking decisions instead of scattering them across Confluence, Slack, and town halls.

[![Slide 5](/podcast/slides/RncFBrvly3w/youtube-RncFBrvly3w/slide_0005_1460.46s.png)](https://youtu.be/RncFBrvly3w?t=1460)
## Why markdown-on-disk breaks down
Vincent warns that markdown files drift out of sync because LLMs are probabilistic and generate slightly different text each time, echoing a past project where migrating Confluence docs to an agent-managed markdown database created repetitive, noisy content. He points to ontologies, graph-based data models with typed relationships, as a better foundation than flat documents.

[![Slide 6](/podcast/slides/RncFBrvly3w/youtube-RncFBrvly3w/slide_0006_1819.46s.png)](https://youtu.be/RncFBrvly3w?t=1819)
## Beads as a graph-based alternative
The conversation turns to Beads, a SQLite-backed graph of typed nodes (issues, epics, features) with relationships like "blocked by," which can generate multiple views (kanban, tree, task graph) from one dataset. Vincent argues most systems don't need a dedicated graph database and that new tools should meet people inside platforms like Jira rather than replacing them.

*Model: cli/claude/sonnet*
