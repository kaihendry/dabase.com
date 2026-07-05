---
title: "Distracted by AI"
date: 2026-04-07T12:00:00Z
description: "Show notes: https://docs.google.com/document/d/1zoc-0L1o1Cyxtgatb9fN_ZGBGbshZIb9BTzwEj0C4Gc/edit?usp=sharing"
image: "https://dabase.com/podcast/images/027-distracted-by-ai.jpg"
draft: false

podcast:
  episode: 27
  season: 1
  episodeType: "full"
  duration: 4243
  audioUrl: "https://dabase.com/podcast/audio/027-distracted-by-ai.mp3"
  audioSize: 101826477
  youtubeId: "oyGi8ahf4Og"
  youtubeUrl: "https://www.youtube.com/watch?v=oyGi8ahf4Og"
---

Show notes: https://docs.google.com/document/d/1zoc-0L1o1Cyxtgatb9fN_ZGBGbshZIb9BTzwEj0C4Gc/edit?usp=sharing

[Watch on YouTube](https://www.youtube.com/watch?v=oyGi8ahf4Og)

## `summarize "https://youtu.be/oyGi8ahf4Og" --timestamps --slides`

This episode (27) is a long, wide-ranging conversation between two engineers about practical pain points as AI tools get folded into docs, development workflows and platform ops. Main threads: converting Confluence to Markdown then letting AI rewrite huge doc sets (500 pages) created disagreement over the source of truth; agents vs persistent docs and the idea of ephemeral AI views; tools and patterns for agent orchestration and spec-driven development; platform-operational stories (data teams, Airflow on Kubernetes, Terraform tooling and testing); and an extended discussion of software supply-chain hardening (OIDC publishing, gating packages by age, CI security checks). The hosts trade concrete examples, versions and configs (for example a 4‑day / 5760‑minute package-age gate) and surface practical tradeoffs rather than evangelism. *we couldn't decide what the source of truth was* *this world is probably going to look pretty different in 2026*
[![Slide 1](/podcast/slides/oyGi8ahf4Og/youtube-oyGi8ahf4Og/slide_0001_1.54s.png)](https://youtu.be/oyGi8ahf4Og?t=1)
## Converting docs exposed a new governance problem
They moved 500 pages from Confluence into Markdown to make docs agent-readable, then used AI to rewrite whole swathes; the rewrite quality was good but the team couldn't sign off because the scale (hundreds of files) made review infeasible, so the project lost consensus about the canonical source. The hosts stress a core rule: keep a single source of truth and avoid many persistent derivative views; when AI generates fixes you must break changes into reviewable, small PRs and distribute review work so humans can approve incrementally.
[![Slide 2](/podcast/slides/oyGi8ahf4Og/youtube-oyGi8ahf4Og/slide_0002_700.08s.png)](https://youtu.be/oyGi8ahf4Og?t=700)
## Agents for discovery, but humans still uneasy
Making docs queryable by agents seemed like the intended flow—ask an agent for ephemeral answers rather than maintain many rewritten views—but not everyone is comfortable trusting ephemeral agent outputs because of hallucination risk and review norms. The concrete governance suggestions: keep core docs authoritative; use agents to discover and create ephemeral views; if a derivative view must persist, make it a reviewed, human‑signed artifact; and break AI edits into small, reviewable commits so the whole team can approve changes.
[![Slide 3](/podcast/slides/oyGi8ahf4Og/youtube-oyGi8ahf4Og/slide_0003_1406.25s.png)](https://youtu.be/oyGi8ahf4Og?t=1406)
## Agent tooling and spec‑driven development are exploding
They compare frameworks that keep agents running until tasks complete (spec‑driven kits) versus interactive, chat‑until‑done styles. One tool keeps an agent looping until spec completion, another uses adversarial agents (spawn reviewers that challenge outputs). Early adopters can move faster—one friend reached advanced agent orchestration in a week or two—while long‑time users risk being stuck in legacy habits. A concrete example: a junior engineer used an AI tool to find a memory leak in ~5 minutes where a seasoned engineer would have gone through traditional heat‑map workflows.
[![Slide 4](/podcast/slides/oyGi8ahf4Og/youtube-oyGi8ahf4Og/slide_0004_2113.21s.png)](https://youtu.be/oyGi8ahf4Og?t=2113)
## Platform work: data teams, Airflow and production friction
A former data‑platform engineer describes handoffs where data engineers prototype in notebooks and platform engineers productionize poorly tested work thrown over the wall, creating heavy support load and stress. Airflow is discussed as a tricky shared infra piece: earlier patterns mounted huge DAG volumes and ran monolithic runners; by 2020 native Kubernetes job runners and per‑job secrets injection made deployments far smoother. The upshot: platforms must become much easier—possibly “AI‑easy”—because expecting product teams to read docs, create repos and run workflows is a big barrier.
[![Slide 5](/podcast/slides/oyGi8ahf4Og/youtube-oyGi8ahf4Og/slide_0005_2820.50s.png)](https://youtu.be/oyGi8ahf4Og?t=2820)
## Infra tooling tradeoffs: Terraform, CDK, testing and local emulators
They debate Terraform’s limits (no automatic rollback, heavy module complexity) versus CDK’s higher‑level abstractions and shift‑left benefits. Testing stacks: use Terraform’s built‑in test command for fast in‑memory checks, and use teratest when you must provision and assert runtime contracts (AMI builds, network or NAT instance permutations). Local emulators (localstack alternatives) are useful for quick serverless work and take‑home coding tests, but licensing and CI restrictions can change the calculus. The hosts also discuss porting CDK L2 coverage to non‑native backends so you can use higher‑level patterns without the original service runtime.
[![Slide 6](/podcast/slides/oyGi8ahf4Og/youtube-oyGi8ahf4Og/slide_0006_3528.08s.png)](https://youtu.be/oyGi8ahf4Og?t=3528)
## Supply‑chain hardening: OIDC, package age, CI gates and noisy scanners
Recent supply‑chain compromises drove practical mitigations: publish with OIDC short‑lived credentials to avoid long‑lived publisher keys, and gate dependency updates by age (example: require a package to be on the registry for 4 days = 5760 minutes before accepting it) so immediately pushed malicious patches get a window for detection and takedown. Also, gate automerge with CI security scans (npm audit or equivalent) rather than relying on unit tests alone. They warn about noisy scanners and config overload but point to concrete CI rules: run an audit-level scan and only auto‑merge when security jobs pass, use minimum‑release‑age tooling in dependency bots, and prefer package managers with good audit support; one practical config discussed was setting a minimum release age flag to four days and running an audit step before auto‑merge.

*Model: openai/gpt-5-mini*
