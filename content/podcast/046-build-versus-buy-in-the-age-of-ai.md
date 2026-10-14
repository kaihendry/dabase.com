---
title: "Build versus buy in the age of AI"
date: "2026-10-14T12:16:59Z"
description: "Kai Hendry and Vincent De Smet debate build versus buy in the age of AI, infrastructure testing, agent workflows and the human bottlenecks in enterprise delivery."
image: "https://dabase.com/podcast/images/046-build-versus-buy-in-the-age-of-ai.jpg"
thumbnail: "https://dabase.com/podcast/images/046-build-versus-buy-in-the-age-of-ai-wide.jpg"

podcast:
  episode: 46
  season: 1
  episodeType: "full"
  duration: 4884
  audioUrl: "https://dabase.com/podcast/audio/046-build-versus-buy-in-the-age-of-ai.mp3"
  audioSize: 117206382
  youtubeId: "E0Y66BvsbxI"
  youtubeUrl: "https://www.youtube.com/watch?v=E0Y66BvsbxI"
  transcriptSource: "auto-generated from the edited recording, with technical-name corrections"
---

Does AI change when companies should build their own software instead of buying it? Kai Hendry and Vincent De Smet discuss the question through Anthropic’s new Scion source-control system and their own work in infrastructure engineering.

Vincent argues that coding agents make building internal systems increasingly attractive. Kai asks what happens in organisations with small teams, uneven AI adoption and established approval processes. Faster code generation is only one part of the decision: maintenance, ownership and the ability to understand a release still matter.

We look at agent harnesses and the Agent Client Protocol, test audits, and a Terratest example that deploys infrastructure and checks its behaviour. We also discuss why engineers sometimes need to say no to agents, how pair programming changes when several agent sessions run at once, and whether an agent can provide an independent approval.

The second half explores Bun, Tov, TypeScript tooling, Deno joining Cloudflare, and the trade-offs between persistent agents and short-lived workers. Recorded on 14 October 2026; the coffee break has been removed.

## Chapters

- [00:00](https://youtu.be/E0Y66BvsbxI?t=0) AI, jobs and keeping up
- [03:04](https://youtu.be/E0Y66BvsbxI?t=184) Anthropic's Scion: rethinking source control
- [07:29](https://youtu.be/E0Y66BvsbxI?t=449) Agent Client Protocol and Kiro
- [10:29](https://youtu.be/E0Y66BvsbxI?t=629) Claude, Codex and agent harnesses
- [14:06](https://youtu.be/E0Y66BvsbxI?t=846) Engineers saying no to agents
- [17:58](https://youtu.be/E0Y66BvsbxI?t=1078) Auditing tests that only test themselves
- [19:06](https://youtu.be/E0Y66BvsbxI?t=1146) Infrastructure testing with Terraform and Terratest
- [27:46](https://youtu.be/E0Y66BvsbxI?t=1666) Side agents, Claude Code mods and cmux
- [31:19](https://youtu.be/E0Y66BvsbxI?t=1879) Rethinking merge queues and smoke tests
- [32:28](https://youtu.be/E0Y66BvsbxI?t=1948) Build versus buy: is enterprise SaaS in trouble?
- [40:02](https://youtu.be/E0Y66BvsbxI?t=2402) Pair programming when agents do the coding
- [46:49](https://youtu.be/E0Y66BvsbxI?t=2809) Bun, Tov and the changing TypeScript toolchain
- [50:21](https://youtu.be/E0Y66BvsbxI?t=3021) Security checks and enterprise release workflows
- [54:49](https://youtu.be/E0Y66BvsbxI?t=3289) Separation of duties and agent approvals
- [1:03:40](https://youtu.be/E0Y66BvsbxI?t=3820) Deno, Cloudflare and edge runtimes
- [1:09:17](https://youtu.be/E0Y66BvsbxI?t=4157) Agent sandboxes and short-lived execution
- [1:14:00](https://youtu.be/E0Y66BvsbxI?t=4440) Recap, model costs and closing tangents

## Mentioned

- [Anthropic: Redesigning source control](https://www.anthropic.com/engineering/redesigning-source-control)
- [Terratest](https://terratest.gruntwork.io/)
- [Agent Client Protocol](https://agentclientprotocol.com/)
- [Bun](https://bun.sh/) and [Tov](https://tov.sh/)
- [Deno is joining Cloudflare](https://deno.com/blog/cloudflare) and [celld](https://celld.dev/)

[Watch on YouTube](https://www.youtube.com/watch?v=E0Y66BvsbxI) · [Browse episodes and subscribe](https://dabase.com/podcast/)

## `summarize "https://youtu.be/E0Y66BvsbxI" --timestamps --slides`

Kai Hendry and Vincent De Smet explore how coding agents change the economics of building software, the work of infrastructure engineers and the processes that surround a release. Anthropic’s Scion source-control system provides a concrete example, but the hosts disagree about how quickly other enterprises can adopt similar ways of working.

[![Kai Hendry at the opening of episode 46](/podcast/slides/E0Y66BvsbxI/youtube-E0Y66BvsbxI/slide_0001_0.20s.png)](https://youtu.be/E0Y66BvsbxI?t=0)

### [00:03:04](https://youtu.be/E0Y66BvsbxI?t=184) Source control designed for agents

Vincent walks through Anthropic’s engineering article on Scion. The discussion focuses on always-online clients, the separation between client and server capabilities, and fetching only the repository data an agent needs. Kai asks how this fits with background agents moving away from developers’ laptops and into shared cloud environments.

From [00:07:29](https://youtu.be/E0Y66BvsbxI?t=449), they discuss the Agent Client Protocol, Kiro and the distinction between an agent harness and its user interface. The conversation then turns to Claude Code, Codex and OpenCode: how much of the experience comes from the model, and how much comes from the tools and interface around it?

[![Anthropic’s principles for agent-scale source control](/podcast/slides/E0Y66BvsbxI/youtube-E0Y66BvsbxI/slide_0002_818.92s.png)](https://youtu.be/E0Y66BvsbxI?t=818)

### [00:14:06](https://youtu.be/E0Y66BvsbxI?t=846) When an engineer needs to say no

Anthropic’s account of engineers steering agents prompts a discussion about rules and adversarial reviews. Strict instructions can push an agent towards workarounds, excessive validation and unnecessary complexity. Kai describes a sandbox restriction that leaked into application code; Vincent argues that engineers need to recognise when a rule has stopped helping.

The hosts also discuss trust and test audits. More generated tests do not necessarily mean stronger evidence: a test can merely repeat the implementation or validate its own assumptions. The useful question is whether it checks behaviour that matters.

### [00:19:06](https://youtu.be/E0Y66BvsbxI?t=1146) Testing real infrastructure

An infrastructure example makes the discussion concrete. Vincent shows tests that deploy an ephemeral environment, wait for services, inspect Terraform outputs and check logs, traces and metrics. Terratest supplies Go helpers for assertions against real infrastructure; the hosts discuss where shell commands and SDK calls belong.

Kai raises the patience that infrastructure tests require when DNS or services take time to become ready. Vincent distinguishes important behavioural checks from stylistic objections to working generated code. A Datadog fake-intake example shows how a test can verify that telemetry actually arrives.

[![The infrastructure test example shared during the conversation](/podcast/slides/E0Y66BvsbxI/youtube-E0Y66BvsbxI/slide_0003_1629.56s.png)](https://youtu.be/E0Y66BvsbxI?t=1629)

At [00:27:46](https://youtu.be/E0Y66BvsbxI?t=1666), the discussion returns to Claude Code side agents, mods and cmux. At [00:31:19](https://youtu.be/E0Y66BvsbxI?t=1879), they consider moving checks towards deployment gates and smoke tests instead of treating every merge as a global bottleneck.

### [00:32:28](https://youtu.be/E0Y66BvsbxI?t=1948) Build versus buy, and the human part of the workflow

Vincent argues that AI makes building internal systems more attractive for large organisations. Kai counters that many teams have limited capacity, uneven adoption and reasons to keep buying established products. They discuss maintenance, company lifecycle and whether an organisation uses AI to increase output or reduce headcount.

From [00:40:02](https://youtu.be/E0Y66BvsbxI?t=2402), Kai describes the difficulty of pair programming while juggling several agent sessions. Waiting for one task encourages a switch to another, but a colleague may lose the thread. Skills, plugins and model behaviour keep changing, making it harder to explain or standardise the workflow.

### [00:46:49](https://youtu.be/E0Y66BvsbxI?t=2809) New tools meet enterprise release processes

Bun’s releases, Theo’s TypeScript tooling and Tov lead into a discussion about language toolchains, native binaries and worker environments. The hosts are exploring these projects and openly question how they fit together.

Kai brings the conversation back to enterprise needs: secret scanning, security checks and a clear account of what changed between releases. At [00:54:49](https://youtu.be/E0Y66BvsbxI?t=3289), they ask whether an agent can act as an independent approver. Vincent raises the possibility that a human can influence its context; both return to human responsibility for understanding and defending a change.

### [01:03:40](https://youtu.be/E0Y66BvsbxI?t=3820) Edge runtimes, sandboxes and short-lived agents

Deno joining Cloudflare, celld and JavaScript worker runtimes prompt a discussion of different ways to build and deploy applications. Kai compares the idea with his use of CloudFront Functions; Vincent is interested in environments that can run agent work quickly and with a constrained scope.

[![A CloudFront Functions code example during the edge-runtime discussion](/podcast/slides/E0Y66BvsbxI/youtube-E0Y66BvsbxI/slide_0006_4073.00s.png)](https://youtu.be/E0Y66BvsbxI?t=4073)

From [01:09:17](https://youtu.be/E0Y66BvsbxI?t=4157), they distinguish persistent agents with memory and background tasks from short-lived workers that finish a task and disappear. They consider operating cost, reviewability and the security benefit of reducing how long a compromised process can remain active. The closing conversation revisits model capabilities and costs, then moves through creative websites, Formula One and Kai’s upcoming trip to Malaysia.

*Model: openai/gpt-5-mini. Reviewed for names, attribution and timing. Generated from the approved local recording and timed transcript because YouTube extraction was unavailable.*
