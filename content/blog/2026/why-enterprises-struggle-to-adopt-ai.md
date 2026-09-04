---
title: "Why Enterprises Struggle to Adopt AI"
date: 2026-09-03T09:58:42+01:00
description: "A running list of reasons the fast feedback loop that makes agentic AI work keeps getting bottlenecked and stalled inside large organisations."
toc: true
---

<!-- Convention: every numbered section below gets a matching visual — an Excalidraw poster
     (create_scene, build with edit_scene_content/create_diagram, take_screenshot to verify,
     extract the PNG to static/blog/2026/, link "Edit this diagram on Excalidraw" underneath)
     or a real photo/frame where that fits better (e.g. a YouTube video frame for a quote).
     Add this before considering a new section done. -->

A running list of reasons enterprises are slow to get real value from agentic AI, compared to an individual or small team just letting agents rip.

## 1. Too many humans in the loop

[![DHH mid-explanation on the Omarchy livestream](/blog/2026/dhh-agents-directly.png)](https://youtu.be/NYFGCESmikA?t=1146)

[DHH](https://youtu.be/NYFGCESmikA?t=1146), on why big, established companies with huge engineering headcounts aren't shipping noticeably faster since agentic coding took off:

> As soon as you're having human teams work together on something, the bottleneck is rarely implementation. It's human bandwidth and communication. When you have a product manager and a couple of designers and a VP above them and a CTO above them, and everyone wants to be part of the shaping process because we're all justifying why we're here, that's where all the productivity goes to die. The revelation I've had working on Omarchy the last three months is that to get that magical 10X, 100X, in a few rare cases, 1000X productivity boost, you have to interact with the agents directly, and you cannot intermediate that bandwidth with another human because it's simply too slow.

His conclusion: implementation was never the real bottleneck. They're bottlenecked on ideas, vision, and taste — and agents don't fix that.

Later in the same conversation he calls this a classic [innovator's dilemma](https://youtu.be/NYFGCESmikA?t=2015):

> These companies have gotten so good, so established at the old way, and therefore their entire structure, management layers, processes are tuned for a time that no longer exists. But you can't pivot that. These are super tankers.

## 2. Crippled model/harness access

![Enterprise API: what's switched off — Sonnet on, Opus off, Fable off, /rc and dynamic subagents off, other model providers off](/blog/2026/enterprise-ai-crippled-model-access.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/9W1PEuLFZrv)*

From my own experience: enterprise API billing plans quietly turn off most of what makes Claude Code good.

- Only access to Sonnet, for cost reasons — no Opus, no Fable, nothing to cross-check against.
- No `/rc` or dynamic subagent capabilities.
- No access to models outside Anthropic, even for comparison.

Individuals paying out of pocket will happily run multiple models against each other to catch mistakes. Enterprises on a fixed budget line strip that down to the cheapest single model — a different product.

Worse: it's not just the model — it's the harness around it. Which features and models are enabled comes down to feature flags on claude.ai or the API console, and which flags are on for a given org isn't transparent. You can't tell, from outside, whether a missing capability is policy, a cost-saving default, or just an org not yet switched to a newer flag.

## 3. Max vs API is a different product, and "shadow IT" isn't allowed

![Max vs API: not the same product — Claude Max has the full model lineup, generous usage, and Code features on by default; the company API seat is Sonnet-only with capped usage and features off. An employee is pulled toward Max via shadow IT despite it being against policy, while the sanctioned but crippled API seat sits underused](/blog/2026/enterprise-ai-max-vs-api.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/4X8Ro1EuK4D)*

Claude's Max subscription and API-billed access aren't just different price points — they're different products. Max gets the full model lineup, generous usage, and Claude Code features on by default; API billing is what IT procures, and it's the stripped-down version above.

That gap creates a temptation: use a personal Max subscription for work instead of the company's crippled API seat. That's shadow IT (a more accurate name than "personal choice of tooling") and against policy at most companies — the work ends up flowing through an account IT doesn't control or audit. Never mind doing your best AI-assisted work out of hours on a personal subscription, which raises its own questions about whose time and IP that work belongs to.

So the choice ends up being: use the good product and break policy, or use the compliant product and get a fraction of the value.

## 4. Guardrails can bite

![One committee, every team's MCP request: three teams' MCP requests fan into a single org-wide security review that takes months, versus a nonexistent team-scoped risk-acceptance path that would take days](/blog/2026/enterprise-ai-mcp-bottleneck.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/7nzNz0y1Y9s)*

Locking down which MCP servers and skills are available "for safety" has a real cost: it limits experimentation and autonomy — exactly what makes agentic workflows powerful.

Usually, every MCP server needs a formal risk acceptance before anyone can use it — and that policy is set org-wide, not team by team. It's the same human bottleneck as [point 1](#1-too-many-humans-in-the-loop): a security committee reviewing every MCP for the whole company doesn't scale, and removes a team's ability to decide for itself, and be accountable for, the tools it needs. A risk-acceptance process scoped to the team that owns the consequences would move far faster than one that must satisfy every stakeholder in the building.

DHH makes a related point about AI safety guardrails in general, [around the 3h32m mark](https://youtu.be/NYFGCESmikA?t=12762):

> Is AI safety important? Yes. Do these models have capabilities that could be seriously harmful in the production of biological weapons or otherwise? Yes. Is it fair to have some ground rules on that? Yes. But then don't squander it by denying the translation of an essay. Because then you erase the whole thing and you bias everyone towards thinking every guardrail you put up is gonna be bullshit.

Overcautious IT/security policy has the same effect on staff: once a few guardrails clearly exist to cover the org rather than protect anyone, people stop trusting any of them, and stop pushing the tools to their limits.

## 5. PII, IP, and GDPR block the tools that matter most

![The iteration loop broken: running product to agent access blocked (PII/GDPR risk in logs) instead of to agent, to fix deployed, back to running product](/blog/2026/enterprise-ai-broken-loop.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/7v4faIaUQy5)*

The tool you most want to unleash an agent on is exactly the one an enterprise is most obligated to keep it away from: observability. An agent that can query Datadog directly, correlate a stack trace with a metric spike and a recent deploy, and fix it, closes the loop between "something's wrong in production" and "it's fixed" without a human relaying logs back and forth.

But Datadog logs in a large enterprise are likely to contain PII — a user's email in an error payload, a name in a support ticket synced into a log line, whatever a developer forgot to redact three years ago. Enterprises have real obligations: GDPR compliance, contractual duties to protect customer data, and their own IP not leaking into a third-party model's context. So the pragmatic, defensible policy is to not give agents access to the logs at all, rather than do the harder work of scoping and redacting what an agent can see.

So the most powerful use case — agents monitoring and fixing the running product — gets killed first, while lower-stakes, lower-value uses (autocomplete, boilerplate generation) sail through because nobody's PII is at risk.

## 6. Requirements capture is not done well

Agents removed the implementation bottleneck, which exposes the next one: nobody wrote down what they wanted. There's no `intent.md`, no clear use cases, just a vague prompt and a vibe.

[Simon Martinelli](https://martinelli.ch/code-is-no-longer-the-bottleneck-requirements-are/) makes this case reviewing Anthropic's AI-native SDLC playbook. The playbook compresses requirements into a single prompt session between one person and Claude — never true in an enterprise: "Real projects have several departments with different and often conflicting interests." Going straight from intent to spec skips analysis, structure, and non-functional requirements, so the spec ends up as prose with no use cases, no domain model, no business rules.

What matters most for accountability: "The product owner no longer writes the spec. They only review it." A product owner who never worked through the spec won't catch its gaps — reviewing is a much weaker check than authoring. In an enterprise, where the product owner is often the one person nominally accountable for what gets built, that's the role you don't want to hollow out.

Fast implementation on top of an unexamined intent doesn't remove risk — it gets you to the wrong thing faster, with a paper trail that looks like due diligence happened when it didn't.

## 7. Permission prompts break the flow

There's a second kind of guardrail, applied at the tooling level rather than by policy: not turning on [auto mode](https://code.claude.com/docs/en/auto-mode-config), or a `.claude/settings.json` that routes everyday, reversible actions through an "ask" prompt.

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

Auto mode exists to eliminate this friction: it routes tool calls through a classifier that blocks anything irreversible, destructive, or aimed outside your environment, so routine actions don't need a human to click approve every time. But an explicit `permissions.ask` rule always wins over auto mode — it's read as your stated intent to be prompted regardless. So an org can roll out auto mode and get none of the benefit, by leaving `git commit` in `ask`.

`git commit` is local, reversible, and the single most frequent action in a coding agent's loop. `curl` is a more defensible one to gate — it can exfiltrate data or pull in arbitrary content — but committing isn't in the same risk class.

Every entry in `ask` is a synchronous stop that needs a human present to click approve. That's fine for an occasional risky command, but a long-running autonomous agent session commits dozens of times. Put commit behind a prompt and you've turned an unattended multi-hour run back into supervised, one-decision-at-a-time babysitting — [the exact human-bandwidth bottleneck from point 1](#1-too-many-humans-in-the-loop), moved into the settings file instead of the org chart.

The fix isn't to remove guardrails, it's to size them to the risk: deny what's destructive or leaks secrets, turn on auto mode for everything else, and reserve `ask` for the few actions that are genuinely hard to undo.

## 8. Maturity gets mistaken for maximum autonomy

![Three dials, not a ladder: Delegation, Oversight (approve each step to review output to spot-check to none), and Concurrency (1 agent to 5+ agents), each shown as a slider with two example settings — a critical system dialed low and a weekend experiment dialed high](/blog/2026/enterprise-ai-three-dials.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/A2UBrQbos61)*

There isn't a ladder to climb, even though it gets talked about like one. What varies task to task is three dials: how much work you delegate to the agent, how much oversight you retain (approve each step, review the output before it lands, spot-check occasionally, or none at all), and how many agents you run at once. Maturity is the ability to set those three dials for what a given task is worth — not to push all three to maximum and leave them there.

[Feng et al.](https://arxiv.org/abs/2506.12469) give a decent vocabulary for the oversight dial — Operator, Collaborator, Consultant, Approver, Observer, running from "I decide every action" to "I mostly watch." That maps roughly onto the coarser approve-each-step / review-output / spot-check / none most teams use day to day.

[Steve Yegge's Eight Levels of Agentic Adoption](https://newsletter.pragmaticengineer.com/p/steve-yegge-on-ai-agents-and-the) is a good read for what dial settings feel like in practice — watching every diff, then watching the conversation instead of diffs, then abandoning the IDE for a CLI agent, then running several agents in parallel, then building your own orchestrator for a fleet of them. Useful as anecdote for what each configuration feels like to a working developer. Not useful as a scorecard: "level 8" isn't the goal, and treating it as one is the misalignment.

A weekend experiment is a fine place to run all three dials at maximum: delegate almost everything, review only the final output, run several agents in parallel. Nothing depends on it. But pointing that configuration at a critical system is a mismatch, not a promotion. Productionising often means deliberately turning the dials *down* from where you'd run them for an experiment — more oversight, fewer agents, a smaller slice of work delegated per step — even though that looks, from outside, like a regression to an "earlier level."

The enterprises that get this wrong tend to pick one fixed dial setting for everyone and everything, rather than trusting individuals or teams to set the dials per task. That's the same instinct as an org-wide MCP policy [in point 4](#4-guardrails-can-bite): a single position applied uniformly, when the judgment that matters is knowing when to turn it down.

## 9. Everything gets centralised, but improving the loop is a team-level job

![Centralize the policy, lose the team loop: a team's own feedback loop (prompt and tool logs, mine for patterns, refine CLAUDE.md/skills/prompts) contrasted with a centralized enterprise OTEL policy that either disables logging org-wide, leaving nothing to learn from, or centralizes it with security/platform instead of the team — either way the loop never closes](/blog/2026/enterprise-ai-otel-loop.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/27RhcmamKkS)*

We touched on centralisation — MCP risk acceptance in point 4, PII/GDPR in point 5 — but it's worth calling out on its own, because it blocks the thing enterprises say they want: continuously improving their own AI-assisted SDLC.

Doing that well needs a tight, local loop: collect real prompt and tool-call logs for your team, look at what the agent got wrong or right, and use that to refine your `CLAUDE.md`, skills, and prompts. Claude Code has the telemetry for it — `OTEL_LOG_USER_PROMPTS` and `OTEL_LOG_TOOL_DETAILS` log the prompt text, bash commands, and MCP/tool arguments, alongside `OTEL_METRICS_INCLUDE_VERSION` for good measure:

```json
"OTEL_LOG_USER_PROMPTS": "1",
"OTEL_LOG_TOOL_DETAILS": "1",
"OTEL_METRICS_INCLUDE_VERSION": "true"
```

Both content flags default to off, redacted otherwise, for good reason — that's the same PII/IP exposure as point 5, generated by your own developers this time instead of pulled from production logs. So the org sets one policy for everyone: usually disabled outright, so nobody has the raw material to learn from; occasionally enabled but centralised into a security or platform team's backend, so the team that generated the prompts can't query their own data.

Either way, a large org has no structure for supporting many small, team-owned feedback loops running at once — it has one policy, decided centrally, applied everywhere. The loop that would make the enterprise better at this never gets to run.

## 10. Bug to fix, not a toll to pay

![Bug to fix, not a toll to pay: paying the toll means hitting the same block and getting it approved again forever; fixing the bug means capturing the block, fixing the underlying constraint, and never hitting it again](/blog/2026/enterprise-ai-bug-not-toll.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/2OvwpaGjgXT)*

Every block in the loop — an `ask` prompt, a denied MCP, a redacted log — should get captured and fixed, not paid again next time. Capture it, then fix the constraint behind it (widen the allowlist, get the MCP risk-accepted, redact the field properly) so the next run doesn't hit the same wall. Auto mode's "Recently denied" list works this way: it exists so you fix the environment entry once instead of re-approving the same command forever.

The same discipline works as a retro exercise: pull PR lead time next to the agent's own chat and tool-call logs for that PR, and see where the wall-clock went — waiting on an `ask` prompt, the agent stuck on a false start, code review, CI. Whichever block ate the most time that cycle is the one to fix before the next. That's the same team-level loop from [point 9](#9-everything-gets-centralised-but-improving-the-loop-is-a-team-level-job): it works only if the team has both the PR timestamps and its own chat logs to look at, not just one or neither.

![Two clocks, no shared visibility: Claude Code's own logs see the ask-prompt wait inside a session (agent working, ask prompt waiting on you, agent working); GitHub separately sees the review wait after the PR is opened (waiting for review, review and merge); nothing sees both, so the two have to be joined by PR or branch after the fact](/blog/2026/enterprise-ai-two-clocks.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/72ywfD6URIq)*

That's why it's two retro data sources, not one: Claude Code's own logs see only the in-session wait, an `ask` prompt sitting there until you reply. Once a PR is opened, that clock stops — review wait lives in GitHub's timestamps, a system the harness has no visibility into. There's no single log with both; you join them by PR or branch after the fact.

An enterprise that re-approves the same block over and over, instead of closing it out, is bleeding the loop's velocity one approval at a time.

## 11. Approve = merge

![Approve = Merge: on the left, merge as the release gate — PR approved, wait for a scheduled merge window, someone clicks Merge manually, deployed; on the right, auto-merge on approve — PR approved, auto-merge fires immediately, main always reflects reviewed code, release timing controlled separately by a flag or deploy gate; a Terraform github_repository resource panel shows allow_auto_merge = true as the setting that enables it](/blog/2026/enterprise-ai-approve-equals-merge.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/6d3sARL0kos)*

Some enterprises don't just want a human to approve a PR — they want to control when it merges, so someone clicks Merge at a scheduled release window instead of the moment it's approved. That's two decisions wearing one costume: whether the code is correct is a review question, when it should go live is a release question, and holding the branch hostage to the second one reintroduces the exact toll [point 10](#10-bug-to-fix-not-a-toll-to-pay) argued against.

The fix is to decouple them: approve should mean merge, immediately, so `main` always reflects what's been reviewed. Control *release* timing separately — a feature flag, a deploy gate, a promotion step — rather than parking reviewed code on a branch until a clock strikes. GitHub has the button for this; in Terraform it's one argument on the repository resource:

```hcl
resource "github_repository" "repo" {
  name             = "my-repo"
  allow_auto_merge = true
}
```

Without `allow_auto_merge = true`, "approve" and "merge" stay two manual actions no matter how fast your agents write code — which means the last mile of the loop is gated by whoever remembers to come back and click the second button.

## 12. Too Waterfall, AI psychosis instead of Agile

![Lead Time for Changes vs. the Intent-to-Test Loop: a timeline from idea captured through first commit, deployed to prod, to feedback observed, with DORA's Lead Time for Changes bracket only covering commit to deploy, a red bracket marking the planning gap before it as invisible to DORA, and an overarching bracket showing intent to test as the loop the Agile Manifesto cares about](/blog/2026/enterprise-ai-lead-time-vs-intent.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/2OIk7zz0VEr)*

`intent.md` gets treated as the artefact to get right up front — reviewed, signed off, revised through committee — when agents make being wrong cheap to recover from. That's Waterfall wearing an AI costume: a phase-gated plan followed by a big-bang implementation, with an agent doing the typing instead of a dev team. Call it AI psychosis — the belief that a model needs a fully specified plan before it's safe to let loose, when the point of agents is that "try it and see" is now nearly free. The [Agile Manifesto](https://agilemanifesto.org/) said it before agents existed: "Responding to change over following a plan." Capturing intent should stay lightweight — a paragraph, not a document — and the loop from idea to running code to feedback is worth protecting, not the plan that preceded it.

## 13. Less is more

![Diff size is a cognitive-load knob, not just a shipping-speed knob: two parallel flows compare no commit-size limit (agent proposes 823 lines across 14 files, reviewer skims and approves in two minutes, regression ships to production) against sloc-sensor capping commits at 100 lines added (hook blocks the commit and splits it into ≤100-line pieces, reviewer actually reads each commit, regression caught in review)](/blog/2026/enterprise-ai-diff-cognitive-load.png)
*[Edit this diagram on Excalidraw](https://app.excalidraw.com/s/cQESkNUilU/1DIFaljHApM)*

Agents generate a lot of code — more files, more lines, more comments restating what a well-named function says. A reviewer can't hold a 100+ line diff in their head, so they skim and rubber-stamp it, and the one decision that mattered goes unchecked.

![Claude Code's output-style picker: "Default" — concise responses — is the active setting, with "Concise" listed as a separate, unselected option that skips preamble and narration entirely](/blog/2026/claude-output-style-concise.png)
*Claude Opus is too verbose by default — "Concise" is opt-in, not the default.*

I use [sloc-sensor](https://github.com/kaihendry/sloc-sensor): pre-commit hooks capping staged lines added, file length, and commit message length. [Martin Fowler's piece on sensors for coding agents](https://martinfowler.com/articles/sensors-for-coding-agents.html) makes the case — a mechanical limit holds where asking an agent nicely to be concise doesn't.

But a pre-commit hook only catches git commits. Claude Desktop wired into Confluence over MCP can dump a wall of text onto a wiki page with nothing watching — there's no staging area to block on. A mechanical sensor only works where a checkpoint exists; everywhere else, "less is more" has to be a value the org holds, not a hook it installed once.

## Closing

A pattern shows through the specifics: a chain of approvers, a security committee, a platform team — each holds a piece of the decision, none holds the outcome. That's not a model limitation or a tooling gap. It's a missing owner.

Every fix works the same way: give one person or team both the authority to decide and the consequences of the decision, and the loop closes. Split those two apart across a chain of approvers, and no amount of model capability fixes it. Ownership, not capability, is the ceiling on enterprise AI adoption.
