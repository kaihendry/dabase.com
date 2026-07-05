---
title: "Adversarial Agents from London"
date: 2026-04-09T12:00:00Z
description: "from a London bus and Vincent in Vietnam!

Kai is attending https://www.ai.engineer/europe/schedule"
image: "https://dabase.com/podcast/images/028-adversarial-agents-from-london.jpg"
draft: false

podcast:
  episode: 28
  season: 1
  episodeType: "full"
  duration: 2125
  audioUrl: "https://dabase.com/podcast/audio/028-adversarial-agents-from-london.mp3"
  audioSize: 50991021
  youtubeId: "Z6sGEwXMN0w"
  youtubeUrl: "https://www.youtube.com/watch?v=Z6sGEwXMN0w"
---

from a London bus and Vincent in Vietnam!

Kai is attending https://www.ai.engineer/europe/schedule

[Watch on YouTube](https://www.youtube.com/watch?v=Z6sGEwXMN0w)

## `summarize "https://youtu.be/Z6sGEwXMN0w" --timestamps --slides`

Kai records this episode on his phone at a London bus stop while attending the AI Engineer Europe conference, catching up with his co-host remotely between sessions. The conversation covers Anthropic's latest announcements, adversarial agent patterns, prompt optimization, and AI model capabilities, all against the backdrop of navigating central London on a double-decker bus.

[![Slide 1](/podcast/slides/Z6sGEwXMN0w/youtube-Z6sGEwXMN0w/slide_0001_0.28s.png)](https://youtu.be/Z6sGEwXMN0w?t=0)
## London bus stop, AI Engineer Europe conference
Kai is attending a multi-day AI Engineer Europe event in London and calls in from a bus stop, phone in hand, to debrief on what he saw at an Anthropic workshop the previous day. The workshop walked through a blog post the two hosts had previously discussed, covering agent harnesses, evaluators, and adversarial agents. A term that kept surfacing was "rubric," used by the Anthropic presenter to mean something close to a set of instructions or criteria, a word neither host had heard used in that context before. Kai says the session gave him a clear enough picture of the pattern that he feels ready to build his own harness, describing the goal as something that could spend around $100 and produce a usable artifact like a retro game tool.

[![Slide 2](/podcast/slides/Z6sGEwXMN0w/youtube-Z6sGEwXMN0w/slide_0002_353.33s.png)](https://youtu.be/Z6sGEwXMN0w?t=353)
## Project GlassWing and the Mythos model
While Kai briefly drops off the call during his bus ride, his co-host introduces Project GlassWing, an Anthropic initiative tied to their upcoming Mythos model. GlassWing is described as identifying a large number of vulnerabilities, with the implication that the model can surface decade-old zero-days inside foundational internet infrastructure. When Kai returns, he adds a key detail from the Anthropic workshop: the presenter warned that any harness built today will need to be updated once Mythos ships, because the model will be substantially more capable and the evaluator will need to shift its focus accordingly. The message was essentially that current harness work is not wasted, but the goalposts will move and teams need to plan for that.

[![Slide 3](/podcast/slides/Z6sGEwXMN0w/youtube-Z6sGEwXMN0w/slide_0003_709.08s.png)](https://youtu.be/Z6sGEwXMN0w?t=709)
## AI-found zero-days and hosted agent teams
The conversation turns to the security implications of models capable of finding zero-days. Both hosts agree that if models like Opus can reliably detect novel vulnerabilities, those findings have serious real-world value. *"If the bug bounty is not being awarded properly, these get sold in the black market or state actors and hackers abuse these to have real significant impact."* Cloudflare comes up as a company well-positioned to benefit, given its existing DDoS and security product surface area. The second Anthropic announcement discussed is a hosted agent teams product, where Anthropic would run coordinated multi-agent systems on your behalf. The presenter mentioned that these agents coordinate through the file system. The co-host draws a parallel to Stripe's published "minions" agent system, a markdown document that any startup can use as a blueprint to build their own orchestration, and argues that if you are already paying Anthropic for the model, using Anthropic-hosted agent teams is a logical next step rather than paying a third-party orchestration startup.

[![Slide 4](/podcast/slides/Z6sGEwXMN0w/youtube-Z6sGEwXMN0w/slide_0004_1055.83s.png)](https://youtu.be/Z6sGEwXMN0w?t=1055)
## Adversarial evaluators and prompt optimization with Pydantic
Kai reflects on how he actually uses adversarial agents in his own workflow: he plans thoroughly, then instructs a separate agent to verify that what was built matches the plan. The adversarial pass reliably surfaces skipped tests and unstated shortcuts. One example he gives is an agent that refused to write a test because it would require forking a git clone, which the agent deemed unsuitable for a unit test, but never flagged this decision explicitly. A conference tip that got a laugh from the audience: write your specs and breadcrumbs in JSON rather than markdown, because agents are reportedly less likely to override JSON. Kai disagrees with this approach, preferring collaborative markdown that he and the agent co-own and diff together. The Pydantic CEO then gave a presentation on an AI observability framework that uses a scan technique to iteratively refine prompts. The system starts from a simple prompt, runs roughly 100 cycles, compares outputs against a golden test set, and converges on a version with meaningfully higher accuracy. *"Instead of 90% accurate, 99% accurate -- this is the way to do it, or this is one approach to consider."* Kai notes the obvious limitation: a new model can render the optimized prompt less relevant, but for high-stakes deterministic use cases the investment still makes sense.

[![Slide 5](/podcast/slides/Z6sGEwXMN0w/youtube-Z6sGEwXMN0w/slide_0005_1408.71s.png)](https://youtu.be/Z6sGEwXMN0w?t=1408)
## Domain vocabulary as a quality lever, and AI-native onboarding
A Google Stitch announcement surfaces as a reference point for a broader point about terminology. A Google UX designer walked through how using precise design vocabulary, terms that models have been trained on, produces dramatically better output than vague instructions. Knowing the right words triggers the model to operate at an expert level; not knowing them means accepting mediocre output without realizing it. The co-host then describes an AI-native onboarding experiment: a new team member was set up to do everything through AI, and built a Terraform dependency visualizer. Interestingly, the model referenced a feature from a low-star open-source fork that the team does not use and had never mentioned, apparently drawing it from pre-training weights rather than any web search. The hosts find this striking evidence of how much obscure technical knowledge is embedded in model weights. The Google DeepMind workshop at the conference reinforced this theme: attendees were asked only to install a skill, and regardless of whether they were using VS Code, Claude Code, or other tools, nearly everyone produced a working proof-of-concept demo without writing any code by hand.

[![Slide 6](/podcast/slides/Z6sGEwXMN0w/youtube-Z6sGEwXMN0w/slide_0006_1758.54s.png)](https://youtu.be/Z6sGEwXMN0w?t=1758)
## Software distribution through prompts and model dependency risks
Andrej Karpathy's approach of posting a gist and telling people to hand it to their coding agent comes up as a new model of software distribution. Both hosts note this is not entirely new, Stripe's minions markdown achieved the same thing, but it represents a real shift in how projects propagate. The conversation then turns to infrastructure risk: when Anthropic had service disruptions the previous day, both hosts felt the dependency acutely. The co-host mentions Gemma from Google as a locally runnable open-weight alternative on Hugging Face, and both discuss Apple silicon, particularly the M-series unified memory architecture, as the most practical hardware for running these models locally. The episode closes with Kai walking past Big Ben and the Houses of Parliament on his way into the conference venue, noting the AI Engineer Europe event is held adjacent to the Houses of Parliament, and signing off to volunteer for crowd control as his way of getting in.

*Model: cli/claude/sonnet*
