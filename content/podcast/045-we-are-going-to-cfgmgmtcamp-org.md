---
title: "We are going to cfgmgmtcamp.org"
date: "2026-10-01T15:47:29Z"
description: "Conference plans, agent harnesses, AI-assisted Terraform reviews, and the engineering practices that make delivery faster."
image: "https://dabase.com/podcast/images/045-we-are-going-to-cfgmgmtcamp-org.jpg"
thumbnail: "https://dabase.com/podcast/images/045-we-are-going-to-cfgmgmtcamp-org-wide.jpg"

podcast:
  episode: 45
  season: 1
  episodeType: "full"
  duration: 4382
  audioUrl: "https://dabase.com/podcast/audio/045-we-are-going-to-cfgmgmtcamp-org.mp3"
  audioSize: 105179500
  youtubeId: "aymTKw5540A"
  youtubeUrl: "https://www.youtube.com/watch?v=aymTKw5540A"
---

We’re going to cfgmgmtcamp.org! Kai Hendry and Vincent De Smet discuss their conference plans, what makes an agent harness useful, and whether AI can reliably review infrastructure changes.

Recorded in two conversations, eight days apart: 23 September and 1 October 2026. The second recording starts at 19:20.

We compare Mecatl, Pi and the Agent Client Protocol; debate fast System One models and accountability; and explore AI-assisted retrospectives and Terraform plan reviews in Atlantis. Can an AI reviewer measure its own impact—or is it just telling us what we want to hear?

We also look at Claude Code agents and dynamic workflows, Stategraph and access to infrastructure context, and the trade-offs between Terraform automation tools. We finish with monorepos, security gates, and why better delivery depends on engineering practices as well as tools—then share our cfgmgmtcamp plans and Vincent’s Ignite news.

## Chapters

- [00:00](https://youtu.be/aymTKw5540A?t=0) 23 September: FOSDEM plans and conference culture
- [05:21](https://youtu.be/aymTKw5540A?t=321) Opus and prompting frustrations
- [08:28](https://youtu.be/aymTKw5540A?t=508) Agent harnesses: Mecatl, Pi and ACP
- [19:20](https://youtu.be/aymTKw5540A?t=1160) 1 October: Google Gemini and model rollouts
- [21:10](https://youtu.be/aymTKw5540A?t=1270) Jev, System One models and accountability
- [27:28](https://youtu.be/aymTKw5540A?t=1648) Using AI to make retrospectives useful
- [29:35](https://youtu.be/aymTKw5540A?t=1775) Atlantis and AI reviews of Terraform plans
- [33:24](https://youtu.be/aymTKw5540A?t=2004) Can we trust AI to measure its own impact?
- [38:53](https://youtu.be/aymTKw5540A?t=2333) Security benchmarks and operational tooling
- [42:56](https://youtu.be/aymTKw5540A?t=2576) Claude Code agents and dynamic workflows
- [52:03](https://youtu.be/aymTKw5540A?t=3123) Giving infrastructure reviewers enough context
- [54:39](https://youtu.be/aymTKw5540A?t=3279) Stategraph, secrets and agent permissions
- [58:48](https://youtu.be/aymTKw5540A?t=3528) Comparing Terraform automation tools
- [1:04:38](https://youtu.be/aymTKw5540A?t=3878) Platform engineering, culture and delivery speed
- [1:06:47](https://youtu.be/aymTKw5540A?t=4007) Monorepos, security gates and continuous integration
- [1:11:21](https://youtu.be/aymTKw5540A?t=4281) We are going to cfgmgmtcamp.org

## Mentioned

- [cfgmgmtcamp](https://cfgmgmtcamp.org/) and [FOSDEM](https://fosdem.org/)
- [Mecatl](https://mecatl.dev/) and [Pi](https://pi.dev/)
- [Jev / TypeSafe AI](https://typesafe.ai/)
- [Vincent’s Terraform automation comparison](https://tacos.guru/)
- [James Shore: Continuous Integration on a Dollar a Day](https://www.jamesshore.com/v2/blog/2006/continuous-integration-on-a-dollar-a-day)

[Watch on YouTube](https://www.youtube.com/watch?v=aymTKw5540A) · [Browse episodes and subscribe](https://dabase.com/podcast/)

Will we see you at cfgmgmtcamp? What would make you trust an AI infrastructure reviewer?

## `summarize "https://youtu.be/aymTKw5540A" --timestamps --slides`

This episode is a conversation about conference plans, agent tooling, model behaviour and practical uses of AI in infrastructure workflows. Kai Hendry and Vincent De Smet compare agent harnesses, explore automation for Terraform reviews and CI/CD, and question how much to trust an AI system’s assessment of its own usefulness. The conversations were recorded on 23 September and 1 October 2026, eight days apart.

[![Slide 1](/podcast/slides/aymTKw5540A/youtube-aymTKw5540A/slide_0001_0.20s.png)](https://youtu.be/aymTKw5540A?t=0)
### [00:00](https://youtu.be/aymTKw5540A?t=0) Conference plans and model behaviour

They open with FOSDEM and cfgmgmtcamp plans, discussing conference culture and disagreements about AI. Vincent is preparing a CDK Terrain release and looking ahead to an AWS CDK bridge. The conversation then turns to prompting Opus: one frustrating session repeatedly produced verbose “privately” explanations before its summaries, while a fresh session on 5.5 behaved better.

[![Slide 2](/podcast/slides/aymTKw5540A/youtube-aymTKw5540A/slide_0002_730.44s.png)](https://youtu.be/aymTKw5540A?t=730)
### [08:28](https://youtu.be/aymTKw5540A?t=508) Harnesses, agents and ACP

The hosts compare Mecatl, Pi and the AWS Strands Agents SDK. They distinguish a harness—the environment that supplies tools and runs an agent loop—from the agent operating inside it. Vincent describes extending Atlantis with a Pi-based agent to review Terraform plans against pull-request intent. The Agent Client Protocol provides another part of the picture: a way to connect interfaces to agents, rather than a substitute for the harness itself. Kiro and Zed provide examples of that separation.

[![Slide 3](/podcast/slides/aymTKw5540A/youtube-aymTKw5540A/slide_0003_1460.72s.png)](https://youtu.be/aymTKw5540A?t=1460)
### [19:20](https://youtu.be/aymTKw5540A?t=1160) Eight days later: fast models and accountability

The October recording begins with Google Gemini news before moving into System One models such as Jev. These return fast, typed decisions rather than general text, which can suit well-defined classification tasks. The hosts debate where that helps and where probabilities alone are insufficient: infrastructure approvals and security decisions may also need an explanation and an audit trail. An example of AI-assisted Jira ticket classification shows a more immediate benefit—making a retrospective about where the team actually spends its time.

[![Slide 4](/podcast/slides/aymTKw5540A/youtube-aymTKw5540A/slide_0004_2193.88s.png)](https://youtu.be/aymTKw5540A?t=2193)
### [29:35](https://youtu.be/aymTKw5540A?t=1775) Atlantis reviews and the problem of measuring impact

Atlantis can produce long Terraform plans across many parts of an infrastructure estate. An agent can inspect those plans, compare their effects with a pull request’s stated intent and post review comments. Vincent describes trying to measure whether those comments changed developers’ behaviour, only to receive inconsistent assessments from the model. Kai raises a related problem: an AI review may confidently recommend a cosmetic change as its top priority even when the change has little impact. Both examples make human judgement and a clear definition of useful work essential.

[![Slide 5](/podcast/slides/aymTKw5540A/youtube-aymTKw5540A/slide_0005_2921.64s.png)](https://youtu.be/aymTKw5540A?t=2921)
### [42:56](https://youtu.be/aymTKw5540A?t=2576) Dynamic workflows and agent orchestration

The hosts examine Claude Code agents and dynamic workflows, alongside Kiro’s workflow announcement. A main agent can break a goal into tasks, delegate parallel work and run repeated verification and repair steps. A screen-shared example starts with contracts between systems, then moves through implementation and integration. The structure can help a human understand the work as well as organise the agents, but large workflows consume many tokens and can be fragile: Vincent recounts accidentally suspending a session and losing a running workflow.

[![Slide 6](/podcast/slides/aymTKw5540A/youtube-aymTKw5540A/slide_0006_3654.76s.png)](https://youtu.be/aymTKw5540A?t=3654)
### [54:39](https://youtu.be/aymTKw5540A?t=3279) Infrastructure context, permissions and delivery practices

Stategraph’s queryable infrastructure data prompts a discussion about giving reviewers context across Terraform states. The hosts consider short-lived read tokens, separate Linux users and the boundary between an agent’s permissions and a developer’s access to secrets. Vincent then demonstrates his Terraform automation comparison site, including different collaboration platforms, access-control requirements and pricing assumptions.

From [1:04:38](https://youtu.be/aymTKw5540A?t=3878), the discussion turns to platform engineering and delivery speed. Installing a tool is only part of adopting it: teams also need the practices that make it useful. A monorepo security gate blocking an unrelated change leads to a debate about ownership, dependency boundaries and continuous integration. James Shore’s “Continuous Integration on a Dollar a Day” supplies an older perspective on keeping the build working.

At [1:11:21](https://youtu.be/aymTKw5540A?t=4281), they return to cfgmgmtcamp. Vincent’s Ignite talk has been accepted, Kai is still waiting, and they discuss meeting listeners in Ghent.

*Model: openai/gpt-5-mini. Reviewed for names and timing.*
