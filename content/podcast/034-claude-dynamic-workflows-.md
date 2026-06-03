---
title: "Claude Dynamic Workflows 🤑"
date: 2026-06-03T12:00:00Z
description: "Otw to AI Native devcon, you can view the videos @tessl-ai"
image: "https://img.youtube.com/vi/Zc21l989-9Y/hqdefault.jpg"
draft: false

podcast:
  episode: 34
  season: 1
  episodeType: "full"
  duration: 1278
  audioUrl: "https://dabase.com/podcast/audio/034-claude-dynamic-workflows-.mp3"
  audioSize: 0
  youtubeId: "Zc21l989-9Y"
  youtubeUrl: "https://www.youtube.com/watch?v=Zc21l989-9Y"
---

Otw to AI Native devcon, you can view the videos @tessl-ai

[Watch on YouTube](https://www.youtube.com/watch?v=Zc21l989-9Y)

## `summarize "https://youtu.be/Zc21l989-9Y" --timestamps --slides`

This is a concise walkthrough of a recorded conversation about a recent platform release that adds “dynamic workflows” to an agent-based development tool. The hosts explain what the feature does, how it changes a spec-driven development workflow, how it handles orchestration and safety, what it costs in compute, and where it still falls short when reviewing specs or producing tidy code. The discussion focuses on practical examples: generating task graphs from a specification, running adversarial reviews with multiple agents, letting an “auto” mode execute and block actions, and the trade-offs between automation and control.

[![Slide 1](/podcast/slides/Zc21l989-9Y/youtube-Zc21l989-9Y/slide_0001_1.27s.png)](https://youtu.be/Zc21l989-9Y?t=1)
## Dynamic workflows: what they do
The new workflow feature runs a JavaScript-based controller that inspects the user context, builds a deterministic graph of agents and prompts, and then executes that graph; the host describes it as a way to skip manual orchestration and let the tool generate and run the tasks for you. *"dynamic workflows is lets the agent take your context then build a graph of agents and each agent's prompt and then execute it."*

[![Slide 2](/podcast/slides/Zc21l989-9Y/youtube-Zc21l989-9Y/slide_0002_204.92s.png)](https://youtu.be/Zc21l989-9Y?t=204)
## Replaces manual task breakdowns
When integrated with a spec-driven process, the workflow can take a specification, produce phases and per-phase tasks (foundational setup, module implementation, subsequent user stories), and present priorities and ordering so teams can move directly from spec to implementation without hand-writing every task list; the speaker uses a spec tool to seed the workflow and then lets the generated agents perform the steps.

[![Slide 3](/podcast/slides/Zc21l989-9Y/youtube-Zc21l989-9Y/slide_0003_427.08s.png)](https://youtu.be/Zc21l989-9Y?t=427)
## Agent orchestration, adversarial reviews, and cost
Workflows orchestrate many agents in parallel and can save, reuse, and deterministically replay full graphs; common patterns include spinning up multiple review agents and merging their outputs into one consolidated report for adversarial validation. The trade-off is cost: these runs can be expensive because the orchestrator may "spin up like 12 agents to do the work" and inherit high model/effort settings unless you explicitly set per-agent model and effort, so users must manage budget and plan model settings carefully. *"it spins up like 12 agents to do the work"*

[![Slide 4](/podcast/slides/Zc21l989-9Y/youtube-Zc21l989-9Y/slide_0004_632.29s.png)](https://youtu.be/Zc21l989-9Y?t=632)
## Auto mode: guarded automation
Auto mode lets the workflow continue between explicit approvals while enforcing guards: it blocks out-of-scope actions, refuses or requests permission before expanding to other accounts or pushing public code, and will attempt to justify actions but stop when it repeatedly tries to circumvent limits. The hosts say this behavior increases confidence by pausing for explicit permission when an agent would otherwise explore beyond the original request.

[![Slide 5](/podcast/slides/Zc21l989-9Y/youtube-Zc21l989-9Y/slide_0005_844.25s.png)](https://youtu.be/Zc21l989-9Y?t=844)
## Commits, templates, and integration
The tool can auto-commit changes during progress and generate commit messages, which some users prefer over manual commits. The speaker maintains custom prompt templates (named verify-flow and implement-workflow) that combine the specify and implement phases so the workflow will handle task breakdown, commits, and team-alignment pushes when asked, but these templates are currently applied as project prompts rather than upstreamed into the core product.

[![Slide 6](/podcast/slides/Zc21l989-9Y/youtube-Zc21l989-9Y/slide_0006_1058.17s.png)](https://youtu.be/Zc21l989-9Y?t=1058)
## Limitations: code hygiene, spec ambiguity, and review UX
Practical problems remain: agent-produced repositories can become messy (many stray files), long spec documents (500 lines of stories and acceptance criteria) expose term inconsistencies and contradictions that are hard to validate automatically, and some review UIs or single-artifact modes fail to offer the granular commenting or highlighting the hosts want. The conversation emphasizes that you still need explicit, testable definitions of what to validate against; automation accelerates work but cannot replace clear specifications and curated review processes.

*Model: openai/gpt-5-mini*
