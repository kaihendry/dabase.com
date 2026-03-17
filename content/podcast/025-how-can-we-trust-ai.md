---
title: "How can we trust AI?"
date: 2026-03-17T12:00:00Z
description: "https://news.ycombinator.com/item?id=47408205

Show notes: https://docs.google.com/document/d/1zoc-0L1o1Cyxtgatb9fN_ZGBGbshZIb9BTzwEj0C4Gc/edit?tab=t.0#heading=h.ulxx2eqh7qsr"
image: "https://img.youtube.com/vi/Mpj-ic1WWE8/hqdefault.jpg"
draft: false

podcast:
  episode: 25
  season: 1
  episodeType: "full"
  duration: 3231
  audioUrl: "/podcast/audio/025-how-can-we-trust-ai.mp3"
  audioSize: 0
  youtubeId: "Mpj-ic1WWE8"
  youtubeUrl: "https://www.youtube.com/watch?v=Mpj-ic1WWE8"
---

https://news.ycombinator.com/item?id=47408205

Show notes: https://docs.google.com/document/d/1zoc-0L1o1Cyxtgatb9fN_ZGBGbshZIb9BTzwEj0C4Gc/edit?tab=t.0#heading=h.ulxx2eqh7qsr

[Watch on YouTube](https://www.youtube.com/watch?v=Mpj-ic1WWE8)

## `summarize "https://youtu.be/Mpj-ic1WWE8" --timestamps --slides`

A conversation between two infrastructure engineers about the practical limits of using AI to implement and scale spec-driven development. They trade concrete war stories: a host’s tool (specledger) broke down when moved from solo work to a team; missing validation and documentation caused divergence between spec, plan and implementation; and the big themes are where to place deterministic checks, how to keep a single source of truth for docs, and how to restore human trust in AI-produced artifacts. The episode contains specific pointers: episode 25, a quick multi-day trial of the host’s tool, a weekend spent copying over a robust test suite, and examples like a 10-item user-story backlog split into three work streams that still lost details.

[![Slide 1](/podcast/slides/Mpj-ic1WWE8/youtube-Mpj-ic1WWE8/slide_0001_1.54s.png)](https://youtu.be/Mpj-ic1WWE8?t=1)
## Setup and immediate problem
Hosts introduce the episode and a new recording service and say they will discuss AI + infra. One host describes shipping a tool called specledger and then discovering quality problems once the workflow ran across a team rather than solo: features implemented by others didn’t match the spec and validation was absent, which created doubt about AI-driven outputs.

[![Slide 2](/podcast/slides/Mpj-ic1WWE8/youtube-Mpj-ic1WWE8/slide_0002_530.54s.png)](https://youtu.be/Mpj-ic1WWE8?t=530)
## Missing validation and empty "constitution"
They found the repository’s validation scaffolding never got initialized, so many required checks and checklists were absent; the host says he “exfiltrated” his own project’s principles and strong test suite (including browser end-to-end workflows) over the weekend to restore confidence. He emphasizes that the final phase — validation, testing and polishing — must be a defined task in the plan, and that missing rules allow the agent to produce outputs that aren’t automatically testable. *"no the problem is the instructions were missing"*

[![Slide 3](/podcast/slides/Mpj-ic1WWE8/youtube-Mpj-ic1WWE8/slide_0003_1069.04s.png)](https://youtu.be/Mpj-ic1WWE8?t=1069)
## Divergence: plan, task and agent behavior
Multiple failure modes appeared: (1) task descriptions drifted from the spec because ad-hoc midstream changes weren’t back-ported to the spec; (2) agents chose different implementation patterns after reading a library’s docs and then simplified or deviated when things failed; (3) juniors driving implementation didn’t stop the agent when it diverged. They propose a cross-artifact validator and a flag to require at least one validation run; the core difficulty is defining when an agent should stop and surface an error versus continue making pragmatic changes.

[![Slide 4](/podcast/slides/Mpj-ic1WWE8/youtube-Mpj-ic1WWE8/slide_0004_1607.58s.png)](https://youtu.be/Mpj-ic1WWE8?t=1607)
## Documentation, duplication and source-of-truth friction
They describe a common enterprise symptom: auto-generated summaries, tutorials and references proliferate from a canonical corpus and then drift out of sync, leaving multiple inconsistent mirrors. The host recommends storing an explicit doc/design index in the repository and keeping documentation close to code, but notes that spec-driven tools often accumulate many successive spec folders (v1, v2…) and lack a canonical merged root, which breaks the “single source of truth” promise.

[![Slide 5](/podcast/slides/Mpj-ic1WWE8/youtube-Mpj-ic1WWE8/slide_0005_2150.50s.png)](https://youtu.be/Mpj-ic1WWE8?t=2150)
## Deterministic API refs + an AI query layer
A practical pattern surfaced: generate deterministic API references and examples directly from code (types, docstrings and generated API docs), keep that as the canonical dataset, then layer a queryable AI index on top so people can request tutorials or examples derived from the authoritative source. They discuss indexing published docs into a vector store and serving a doc-query interface so non-developers can ask natural-language questions while the underlying API reference remains programmatically generated and versioned.

[![Slide 6](/podcast/slides/Mpj-ic1WWE8/youtube-Mpj-ic1WWE8/slide_0006_2683.87s.png)](https://youtu.be/Mpj-ic1WWE8?t=2683)
## Trust, CI/CD artifacts and how to restore confidence
Trust is the central theme: once consultants or teams use AI and quality slips, client trust breaks. The hosts map familiar concepts onto AI workflows: immutable artifacts moving rightward through a pipeline build trust as they pass deterministic promotion gates. The tension is obvious — AI accelerates output but reviews and quality gates are slow — so the way forward is more automation: formal parsers, deterministic validators and tooling that convert constrained user-story formats into machine-checkable tests (BDD/Gherkin-like). Humans still belong at the start and the final sign-off, but the guests argue for stronger automated verification during the lifecycle because volume of AI output overwhelms human reviewers. *"trust and alignment or whatever you want to call it is so key with all this innovation that's happening."*

*Model: openai/gpt-5-mini*
