---
title: "Checking for AI guard rails"
date: 2026-05-06T12:00:00Z
description: "https://dabase.com/podcast/

https://link.excalidraw.com/l/cQESkNUilU/9R9YETcpHcG"
image: "https://dabase.com/podcast/images/031-checking-for-ai-guard-rails.jpg"
draft: false

podcast:
  episode: 31
  season: 1
  episodeType: "full"
  duration: 3002
  audioUrl: "https://dabase.com/podcast/audio/031-checking-for-ai-guard-rails.mp3"
  audioSize: 72047853
  youtubeId: "7lHwUBKV9tI"
  youtubeUrl: "https://www.youtube.com/watch?v=7lHwUBKV9tI"
---

https://dabase.com/podcast/

https://link.excalidraw.com/l/cQESkNUilU/9R9YETcpHcG

[Watch on YouTube](https://www.youtube.com/watch?v=7lHwUBKV9tI)

## `summarize "https://youtu.be/7lHwUBKV9tI" --timestamps --slides`

This is a recorded conversation about rebuilding Spec Ledger and how teams should integrate AI agents safely into developer workflows: architecture choices (Golang CLI, Vercel/NextJS frontend → monorepo + open backend), skills registries, agent-triggered commits that capture session transcripts, CI/CD and linting guard rails, sandboxes/routers, testing trade-offs, and a proposal for an “AI show guard rails” scoring tool.

[![Slide 1](/podcast/slides/7lHwUBKV9tI/youtube-7lHwUBKV9tI/slide_0001_0.40s.png)](https://youtu.be/7lHwUBKV9tI?t=0)
## aborted mapping project and spec-driven attempts
The speaker tried to use spec-driven development for a mapping project but hit Docker and native map dependency issues, so progress stalled; multiple abortive attempts left them wanting to re-run the spec-driven workflow with a simpler project, and the conversation opens by comparing these practical blockers to the intended planning/value of spec-driven development.

[![Slide 2](/podcast/slides/7lHwUBKV9tI/youtube-7lHwUBKV9tI/slide_0002_492.33s.png)](https://youtu.be/7lHwUBKV9tI?t=492)
## Spec Ledger rewrite and skills registry
They’re rewriting Spec Ledger to make the backend open-source inside a Golang CLI (currently the public repo is a Golang CLI with a Vercel NextJS web app), moving toward a monorepo and first-class organization/multi-tenant support so teams can share workflows, choose or customize templates, and pull workflows per org; the NPX/skills registry from Vercel was ported into the Golang CLI so agents can discover and install skills (skills are referenced by Git repos and the registry ranks skills by install metadata), and private/team skills plus usage metadata and GitHub API quirks were discussed as implementation details.

[![Slide 3](/podcast/slides/7lHwUBKV9tI/youtube-7lHwUBKV9tI/slide_0003_992.67s.png)](https://youtu.be/7lHwUBKV9tI?t=992)
## agent-driven installs and session capture pipeline
Agents in plan mode can detect tech stacks, search the CLI skills registry, propose matches and trigger installs; the system hooks Git commits so the CLI captures session context (it uses regex to tag which spec/branch a commit belongs to and captures conversation since last capture), stores that session data in Supabase and JSONL webhooks, and the web backend visualizes results (Kanban and tree views) while search across repos and executable-spec validation remain important missing pieces; *Spec ledger visualizes that process.*

[![Slide 4](/podcast/slides/7lHwUBKV9tI/youtube-7lHwUBKV9tI/slide_0004_1492.96s.png)](https://youtu.be/7lHwUBKV9tI?t=1492)
## integration paths, Backstage plugin debate, and config controls
They debated making Spec Ledger a set of Backstage plugins versus a standalone “virtual Backstage” to avoid requiring Backstage for adopters, noted the value of a remote MCP/central registry to keep skills and agents aligned across teams, and described agent config options: settings.json with secrets vs commit-able settings, agent profiles to choose endpoints, and the ability to disable AI attribution on commits/PRs; guard rails discussed include routers that mediate all AI requests, sandboxes for agents, and Claude-like features (auto-eval for dangerous actions, hooks and allowlists).

[![Slide 5](/podcast/slides/7lHwUBKV9tI/youtube-7lHwUBKV9tI/slide_0005_1993.29s.png)](https://youtu.be/7lHwUBKV9tI?t=1993)
## reviews, tests, deterministic checks and CI trust
They argued that large AI-generated PRs make manual review impractical so organizations must rely on CI, linters and deterministic tools (go vet/gofmt/golint, gosec, complexity checks) and adversarial agent reviewers for security checks; they debated test coverage (100% coverage can bloat code and encourage testing implementation details), recommended executable specs and end-to-end validation gates, and warned that brittle commit hooks (if they exit nonzero) can break agent shells and flood failures.

[![Slide 6](/podcast/slides/7lHwUBKV9tI/youtube-7lHwUBKV9tI/slide_0006_2493.62s.png)](https://youtu.be/7lHwUBKV9tI?t=2493)
## proposed “AI show guard rails” and infra bootstrapping notes
A proposed project would score a session’s safety by inspecting settings, pre-commit rules, router/sandbox presence, token usage and model endpoints (a gamified audit to highlight risky setups), and they agreed this could be built with a spec-driven development spike; operational notes: use CloudFormation StackSets to bootstrap accounts and trust roles for Terraform automation, Atlantis is used but has limitations, and they plan to prototype the guard-rail linter as a Spec Ledger spec-driven task while recording the process for follow-up; *The human's involvement is the review of the user stories and the validation that the end-to-end thing work.*

*Model: openai/gpt-5-mini*
