---
title: "Why Enterprises Struggle to Adopt AI"
date: 2026-09-03T09:58:42+01:00
description: "A running list of reasons large organisations get so little out of agentic AI compared to individuals: too many humans in the loop, restricted model access, and guardrails that kill experimentation."
---

<!-- Convention: every numbered section below gets a matching visual — an Excalidraw poster
     (create_scene, build with edit_scene_content/create_diagram, take_screenshot to verify,
     extract the PNG to static/blog/2026/, link "Edit this diagram on Excalidraw" underneath)
     or a real photo/frame where that fits better (e.g. a YouTube video frame for a quote).
     Add this before considering a new section done. -->

A running list of points and references on why enterprises are so slow to get real value out of agentic AI, compared to an individual or small team just letting agents rip.

## 1. Too many humans in the loop

[![DHH mid-explanation on the Omarchy livestream](/blog/2026/dhh-agents-directly.png)](https://youtu.be/NYFGCESmikA?t=1146)

[DHH](https://youtu.be/NYFGCESmikA?t=1146), on why big, well-established companies with huge engineering headcounts aren't shipping noticeably faster since agentic coding took off:

> As soon as you're having human teams work together on something, the bottleneck is rarely implementation. It's human bandwidth and communication. When you have a product manager and a couple of designers and a VP above them and a CTO above them, and everyone wants to be part of the shaping process because we're all justifying why we're here, that's where all the productivity goes to die. The revelation I've had working on Omarchy the last three months is that to get that magical 10X, 100X, in a few rare cases, 1000X productivity boost, you have to interact with the agents directly, and you cannot intermediate that bandwidth with another human because it's simply too slow.

His conclusion: the implementation part was never the real bottleneck for these organisations. They're bottlenecked on ideas, vision, and taste — and agents don't fix that.

A little later in the same conversation he calls this out as a classic [innovator's dilemma](https://youtu.be/NYFGCESmikA?t=2015):

> These companies have gotten so good, so established at the old way, and therefore their entire structure, management layers, processes are tuned for a time that no longer exists. But you can't pivot that. These are super tankers.

## 2. Crippled model/harness access

![Enterprise API: what's switched off — Sonnet on, Opus off, Fable off, /rc and dynamic subagents off, other model providers off](/blog/2026/enterprise-ai-crippled-model-access.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/9W1PEuLFZrv)*

From my own experience: enterprise API billing plans quietly turn off most of what makes Claude Code good.

- Only access to Sonnet, for cost reasons — no Opus, no Fable, nothing to cross-check against.
- No `/rc` or dynamic subagent capabilities.
- No access to models outside Anthropic, even for comparison.

Individuals paying out of pocket will happily run multiple models against each other to catch mistakes. Enterprises on a fixed budget line strip that down to the cheapest single model, which is a very different product.

What makes this worse is that it's not just the model — it's the harness around it. Which features and models are actually enabled comes down to feature flags on claude.ai/the API console, and which flags are on for a given org isn't transparent. You can't tell, from the outside, whether a missing capability is a deliberate policy decision, a cost-saving default, or just an org that hasn't been switched over to a newer flag yet.

## 3. Max vs API is a different product, and "shadow IT" isn't allowed

![Max vs API: not the same product — Claude Max has the full model lineup, generous usage, and Code features on by default; the company API seat is Sonnet-only with capped usage and features off. An employee is pulled toward Max via shadow IT despite it being against policy, while the sanctioned but crippled API seat sits underused](/blog/2026/enterprise-ai-max-vs-api.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/4X8Ro1EuK4D)*

Claude's Max subscription and API-billed access aren't just different price points — they're different products. Max gets you the full model lineup, generous usage, and Claude Code features on by default; API billing is what IT actually procures, and it's the stripped-down version above.

That gap creates a temptation: use a personal Max subscription for work instead of the company's crippled API seat. Strictly speaking that's shadow IT (a more accurate name than "personal choice of tooling") and against policy at most companies — the work product ends up flowing through an account IT doesn't control or audit. Nevermind doing your best AI-assisted work out of hours on a personal subscription, which raises its own questions about whose time and whose IP that work belongs to.

So the choice ends up being: use the good product and break policy, or use the compliant product and get a fraction of the value.

## 4. Guardrails can bite

![One committee, every team's MCP request: three teams' MCP requests fan into a single org-wide security review that takes months, versus a nonexistent team-scoped risk-acceptance path that would take days](/blog/2026/enterprise-ai-mcp-bottleneck.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/7nzNz0y1Y9s)*

Locking down which MCP servers and skills are available "for safety" has a real cost: it limits experimentation and autonomy, which is exactly what makes agentic workflows powerful in the first place.

The usual mechanism is that every MCP server needs to go through a formal risk acceptance before anyone can use it — and that policy is set org-wide rather than team by team. It's the same human bottleneck as [point 1](#1-too-many-humans-in-the-loop): a security committee reviewing every MCP for the whole company doesn't scale, and it removes the option of a team deciding for itself, and being accountable for, the tools it needs. A risk-acceptance process scoped to the team that owns the consequences would move at a completely different speed than one that has to satisfy every stakeholder in the building.

DHH makes a related point about AI safety guardrails in general, [around the 3h32m mark](https://youtu.be/NYFGCESmikA?t=12762):

> Is AI safety important? Yes. Do these models have capabilities that could be seriously harmful in the production of biological weapons or otherwise? Yes. Is it fair to have some ground rules on that? Yes. But then don't squander it by denying the translation of an essay. Because then you erase the whole thing and you bias everyone towards thinking every guardrail you put up is gonna be bullshit.

Overcautious IT/security policy inside enterprises has the same effect on staff: once a few guardrails obviously exist to cover the org rather than to protect anyone, people stop trusting any of them, and stop bothering to push the tools to their limits.

## 5. PII, IP, and GDPR block the tools that matter most

![The iteration loop broken: running product to blocked (PII/GDPR risk) instead of to agent, to fix deployed, back to running product](/blog/2026/enterprise-ai-broken-loop.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/7v4faIaUQy5)*

The tool you most want to unleash an agent on is exactly the one an enterprise is most obligated to keep it away from: observability. An agent that can query Datadog directly, correlate a stack trace with a metric spike and a recent deploy, and go fix it, closes the iteration loop between "something's wrong in production" and "it's fixed" without a human relaying logs back and forth.

But Datadog logs in a large enterprise are quite likely to contain PII — a user's email in an error payload, a name in a support ticket synced into a log line, whatever a developer forgot to redact three years ago. Enterprises have real obligations here: GDPR compliance, contractual duties to protect customer data, and their own IP not leaking into a third-party model's context. So the pragmatic, defensible policy is to just not give agents access to the logs at all, rather than do the harder work of scoping and redacting what an agent can see.

The result is that the most powerful use case — agents monitoring and fixing the actual running product — gets killed first, while lower-stakes, lower-value uses (autocomplete, boilerplate generation) sail through because nobody's PII is at risk there.

## 6. Requirements capture is not done well

Agents removed the implementation bottleneck, which just exposes the next one: nobody wrote down what they actually wanted. There's no `intent.md`, no clear use cases, just a vague prompt and a vibe.

[Simon Martinelli](https://martinelli.ch/code-is-no-longer-the-bottleneck-requirements-are/) makes this case well, reviewing Anthropic's AI-native SDLC playbook. The playbook compresses requirements into a single prompt session between one person and Claude, when in reality — especially in an enterprise — that's never true: "Real projects have several departments with different and often conflicting interests." Going straight from intent to spec skips analysis, structure, and non-functional requirements, so the spec ends up as prose with no use cases, no domain model, no business rules.

The part that matters most for accountability: "The product owner no longer writes the spec. They only review it." A product owner who never had to work through the spec themselves won't catch the gaps in it — reviewing is a much weaker check than authoring. In an enterprise, where the product owner is often the one person nominally accountable for what gets built, that's exactly the role you don't want to hollow out.

Fast implementation on top of an unexamined intent doesn't remove risk, it just gets you to the wrong thing faster, with a paper trail that looks like due diligence happened when it didn't.

## 7. Permission prompts break the flow

There's a second kind of guardrail, applied at the tooling level rather than by policy: not turning on [auto mode](https://code.claude.com/docs/en/auto-mode-config), and/or a `.claude/settings.json` that routes everyday, reversible actions through an "ask" prompt.

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "deny": [
      "Bash(rm *)",
      "Read(./.env)",
      "Read(./secrets/**)"
    ],
    "ask": [
      "Bash(curl *)",
      "Bash(git commit *)"
    ]
  }
}
```

Auto mode exists precisely to eliminate this friction: it routes tool calls through a classifier that blocks anything irreversible, destructive, or aimed outside your environment, so routine actions don't need a human to click approve every time. But an explicit `permissions.ask` rule always wins over auto mode — it's read as your stated intent to be prompted regardless. So an org can roll out auto mode and still get none of the benefit, just by leaving `git commit` in `ask`.

`git commit` is local, reversible, and also the single most frequent action in a coding agent's loop. `curl` is a more defensible one to gate — it can exfiltrate data or pull in arbitrary content — but committing isn't in the same risk class.

Every entry in `ask` is a synchronous stop that needs a human physically present to click approve. That's fine for an occasional risky command, but a long-running autonomous agent session commits dozens of times. Put commit behind a prompt and you've turned an unattended multi-hour run back into supervised, one-decision-at-a-time babysitting — [the exact human-bandwidth bottleneck from point 1](#1-too-many-humans-in-the-loop), just moved into the settings file instead of the org chart.

The fix isn't to remove guardrails, it's to size them to the actual risk: deny what's destructive or leaks secrets, turn on auto mode for everything else, and reserve `ask` for the small set of actions that are genuinely hard to undo.

## 8. Maturity gets mistaken for maximum autonomy

![Three dials, not a ladder: Delegation, Oversight (approve each step to review output to spot-check to none), and Concurrency (1 agent to 5+ agents), each shown as a slider with two example settings — a critical system dialed low and a weekend experiment dialed high](/blog/2026/enterprise-ai-three-dials.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/A2UBrQbos61)*

There isn't a ladder to climb here, even though it gets talked about like one. What actually varies task to task is three dials: how much of the work you delegate to the agent, how much oversight you retain (approve each step, review the output before it lands, spot-check occasionally, or none at all), and how many agents you run at once. Maturity is the ability to set those three dials correctly for what a given task is worth — not the ability to push all three to maximum and leave them there.

[Feng et al.](https://arxiv.org/abs/2506.12469) give a decent vocabulary for the oversight dial specifically — Operator, Collaborator, Consultant, Approver, Observer, running from "I decide every action" to "I mostly watch." That maps roughly onto the coarser approve-each-step / review-output / spot-check / none most teams actually use day to day.

[Steve Yegge's Eight Levels of Agentic Adoption](https://newsletter.pragmaticengineer.com/p/steve-yegge-on-ai-agents-and-the) is a good read for what specific dial settings feel like in practice — watching every diff, then watching the conversation instead of diffs, then abandoning the IDE for a CLI agent entirely, then running several agents in parallel, then building your own orchestrator for a fleet of them. Useful as anecdote about what each configuration feels like for a working developer. Not useful as a scorecard: "level 8" isn't the goal, and treating it as one is exactly the misalignment.

A weekend experiment is a fine place to run all three dials at maximum: delegate almost everything, review only the final output, run several agents in parallel. Nothing depends on it. But pointing that same configuration at a critical system is a mismatch, not a promotion. Productionising often means deliberately turning the dials *down* from where you'd run them for an experiment — more oversight, fewer agents, a smaller slice of work delegated per step — even though that looks, from the outside, like a regression to an "earlier level."

The enterprises that get this wrong tend to pick one fixed dial setting for everyone and everything, rather than trusting individuals or teams to set the dials per task. That's the same instinct as an org-wide MCP policy [in point 4](#4-guardrails-can-bite): a single position applied uniformly, when the judgment that actually matters is knowing when to turn it down.

## 9. Everything gets centralised, but improving the loop is a team-level job

![Centralize the policy, lose the team loop: a team's own feedback loop (prompt and tool logs, mine for patterns, refine CLAUDE.md/skills/prompts) contrasted with a centralized enterprise OTEL policy that either disables logging org-wide, leaving nothing to learn from, or centralizes it with security/platform instead of the team — either way the loop never closes](/blog/2026/enterprise-ai-otel-loop.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/27RhcmamKkS)*

We touched on centralisation already — MCP risk acceptance in point 4, PII/GDPR in point 5 — but it's worth calling out on its own, because it also blocks the thing enterprises say they want: continuously improving their own AI-assisted SDLC.

Doing that well needs a tight, local loop: collect real prompt and tool-call logs for your team, look at what the agent actually got wrong or right, and use that to refine your `CLAUDE.md`, skills, and prompts. Claude Code has exactly the telemetry for it — `OTEL_LOG_USER_PROMPTS` and `OTEL_LOG_TOOL_DETAILS` will log the actual prompt text, bash commands, and MCP/tool arguments, alongside `OTEL_METRICS_INCLUDE_VERSION` for good measure:

```json
"OTEL_LOG_USER_PROMPTS": "1",
"OTEL_LOG_TOOL_DETAILS": "1",
"OTEL_METRICS_INCLUDE_VERSION": "true"
```

Both content flags default to off, redacted otherwise, for good reason — that's the same PII/IP exposure as point 5, just generated by your own developers this time instead of pulled from production logs. So the org sets one policy for everyone: usually disabled outright, which means nobody has the raw material to learn from; occasionally enabled but centralised into a security or platform team's backend, which means the team that actually generated the prompts still can't query their own data.

Either way, a large org has no structure for supporting many small, team-owned feedback loops running at once — it has one policy, decided centrally, applied everywhere. The loop that would actually make the enterprise better at this never gets to run.

## 10. Bug to fix, not a toll to pay

![Bug to fix, not a toll to pay: paying the toll means hitting the same block and getting it approved again forever; fixing the bug means capturing the block, fixing the underlying constraint, and never hitting it again](/blog/2026/enterprise-ai-bug-not-toll.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/2OvwpaGjgXT)*

Every block in the loop — an `ask` prompt, a denied MCP, a redacted log — should get captured and fixed, not paid again next time. Capture it, then fix the actual constraint behind it (widen the allowlist, get the MCP risk-accepted, redact the field properly) so the next run doesn't hit the same wall. Auto mode's own "Recently denied" list already works this way: it exists so you fix the environment entry once instead of re-approving the same command forever.

The same discipline works as a retro exercise: pull PR lead time next to the agent's own chat and tool-call logs for that PR, and look at where the wall-clock actually went — waiting on an `ask` prompt, the agent stuck on a false start, code review, CI. Whichever block ate the most time that cycle is the one to fix before the next one. That's the same team-level loop from [point 9](#9-everything-gets-centralised-but-improving-the-loop-is-a-team-level-job): it only works if the team actually has both the PR timestamps and its own chat logs to look at, not just one or neither.

![Two clocks, no shared visibility: Claude Code's own logs see the ask-prompt wait inside a session (agent working, ask prompt waiting on you, agent working); GitHub separately sees the review wait after the PR is opened (waiting for review, review and merge); nothing sees both, so the two have to be joined by PR or branch after the fact](/blog/2026/enterprise-ai-two-clocks.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/72ywfD6URIq)*

That's also why it's two retro data sources, not one: Claude Code's own logs only see the in-session wait, an `ask` prompt sitting there until you reply. Once a PR is opened, that clock stops — review wait lives entirely in GitHub's timestamps, a system the harness has no visibility into at all. There's no single log with both; you join them by PR or branch after the fact.

An enterprise that just re-approves the same block over and over, instead of closing it out, is bleeding the loop's velocity one approval at a time.

## Closing

Look back at 1, 4, 5, and 9: a diffuse chain of approvers, a security committee that owns the risk but not the team's velocity, a platform team that owns the logs but not the insight. In each case someone can decide, and someone else gets blamed for the outcome — split apart instead of held by one accountable person. That split, not the model or the tooling, is the real ceiling on adoption.
