---
title: "Agents built the AWS emulator"
date: "2026-11-17T12:15:51Z"
description: "Kai Hendry and Vincent De Smet tour Vincent's CDK Terrain workshop on AWS's agent-built emulator, look at its commit history, and discuss agent skills, prompt evals, PII in logs and background agents."
image: "https://dabase.com/podcast/images/048-agents-built-the-aws-emulator.jpg"
thumbnail: "https://dabase.com/podcast/images/048-agents-built-the-aws-emulator-wide.jpg"

podcast:
  episode: 48
  season: 1
  episodeType: "full"
  duration: 4514
  audioUrl: "https://dabase.com/podcast/audio/048-agents-built-the-aws-emulator.mp3"
  audioSize: 108329642
  youtubeId: "AHl4atOHnKo"
  youtubeUrl: "https://www.youtube.com/watch?v=AHl4atOHnKo"
  transcriptSource: "transcribed per speaker from the edited recording, with technical-name corrections"
---

AWS says its new emulator was built by agents, and it doesn't accept pull requests. Vincent De Smet is using it anyway: his CDK Terrain workshop in Singapore runs entirely against the emulator, so attendees need no AWS account. When the emulator couldn't have one Lambda invoke another or enforce IAM policies, Fable wrote the patches and rebuilt the binary.

Vincent tours the workshop: AWS's original CDK workshop ported to Terraform, a box per attendee behind Caddy, and a progress tracker and leaderboard built on Cloudflare Durable Objects. Kai Hendry opens the emulator's repository in tig, finds agents committing every couple of minutes, and admits to a feeling of dread. Vincent argues that reviewing commits is the wrong metric now, and that control has moved up to the intent layer.

The second half is about skills and prompts: Google's elephant and goldfish model, Matt Pocock's grill-me, Lauren Tan's verification skill on Kai's Singapore bus app, formal verification with TLA+ and Quint, and tending skills like a garden. Kai wants to prove that a page-long AgentCore prompt is no better than a short one, and they finish on PII in logs, break-glass access and background agents.

The episode opens with Vincent showing the view from his window in Ho Chi Minh City. Recorded on 17 November 2026.

## Chapters

- [00:00](https://youtu.be/AHl4atOHnKo?t=0) A view of Saigon, zoning and Belgium
- [03:49](https://youtu.be/AHl4atOHnKo?t=229) Config Management Camp and the CDK Terrain community
- [05:45](https://youtu.be/AHl4atOHnKo?t=345) A CDK Terrain workshop in Singapore
- [08:28](https://youtu.be/AHl4atOHnKo?t=508) Car-free Ghent and hearing horses
- [12:28](https://youtu.be/AHl4atOHnKo?t=748) Patching and building the AWS emulator with Fable
- [18:07](https://youtu.be/AHl4atOHnKo?t=1087) Five gigabytes per workshop attendee
- [21:57](https://youtu.be/AHl4atOHnKo?t=1317) Caddy, Traefik and Kong
- [23:28](https://youtu.be/AHl4atOHnKo?t=1408) Inside the workshop box
- [32:32](https://youtu.be/AHl4atOHnKo?t=1952) Commits every two minutes in the AWS emulator repo
- [38:59](https://youtu.be/AHl4atOHnKo?t=2339) Reviewing code in the agentic era
- [40:44](https://youtu.be/AHl4atOHnKo?t=2444) How the clouds are adapting to AI
- [42:13](https://youtu.be/AHl4atOHnKo?t=2533) Google's elephant and goldfish model
- [46:53](https://youtu.be/AHl4atOHnKo?t=2813) Lauren Tan's verification skill and Playwright
- [51:18](https://youtu.be/AHl4atOHnKo?t=3078) Formal verification, comments and TODOs
- [55:35](https://youtu.be/AHl4atOHnKo?t=3335) Stale skills, gardening and glossaries
- [59:55](https://youtu.be/AHl4atOHnKo?t=3595) Rethinking Claude Code best practices
- [1:03:21](https://youtu.be/AHl4atOHnKo?t=3801) Does a page-long prompt beat a simple one?
- [1:10:10](https://youtu.be/AHl4atOHnKo?t=4210) PII, scoped tokens and break-glass access
- [1:13:54](https://youtu.be/AHl4atOHnKo?t=4434) Background agents

## Mentioned

- The [AWS emulator](https://github.com/aws/aws-emulator) and [LocalStack](https://www.localstack.cloud/)
- [CDK Terrain](https://cdktn.io/) and [TerraConstructs](https://terraconstructs.dev/)
- [Caddy](https://caddyserver.com/), [Traefik](https://traefik.io/) and [Kong](https://konghq.com/)
- [Cloudflare Durable Objects](https://developers.cloudflare.com/durable-objects/)
- [Beads](https://github.com/steveyegge/beads), [Matt Pocock's skills](https://github.com/mattpocock/skills), [Spec Kit](https://github.com/github/spec-kit) and [Conductor](https://github.com/gemini-cli-extensions/conductor)
- [Playwright](https://playwright.dev/), [TLA+](https://lamport.azurewebsites.net/tla/tla.html) and [Quint](https://quint-lang.org/)
- [Amazon Bedrock AgentCore](https://aws.amazon.com/bedrock/agentcore/) and [Strands Agents](https://strandsagents.com/)

[Watch on YouTube](https://www.youtube.com/watch?v=AHl4atOHnKo) · [Browse episodes and subscribe](https://dabase.com/podcast/)

## `summarize "https://youtu.be/AHl4atOHnKo" --timestamps --slides`

Kai Hendry and Vincent De Smet start with city life in Vietnam, Belgium and conference news, then spend the core of the episode on Vincent's Singapore workshop, built on AWS's new agent-built emulator, and the emulator's own commit history. They finish on agent skills, prompt design and keeping production data away from agents.

### [00:00:00](https://youtu.be/AHl4atOHnKo?t=0) Saigon, Belgium and Config Management Camp

Vincent shows the view of Phu My Hung in Ho Chi Minh City, an area that used to be swamp. He says there are no zoning laws there, which he finds both freeing and sad. Kai isn't a huge fan of zoning laws, though he accepts that building control is needed. Vincent describes Belgian "lintbebouwing", houses built in a line along every road, and looks forward to visiting Belgium in January for the first time since about 2016.

From [00:03:49](https://youtu.be/AHl4atOHnKo?t=229), Kai is disappointed that his AI talk proposals for Config Management Camp were rejected without feedback, though he is still going. Vincent's CDK Terrain talk was accepted; he credits the community and the Open Constructs Foundation, started by Elad Ben-Israel and Sebastian Korfmann. Kai says his colleagues adopted CDKTN independently, and argues that recording conversations, even face-to-face ones, matters more than ever because AI can learn from the recordings later.

### [00:05:45](https://youtu.be/AHl4atOHnKo?t=345) A workshop on the AWS emulator

Vincent is running a CDKTN workshop in Singapore on Saturday the 28th, which Michael Cheng will record. Kai asks how the emulator AWS announced the week before compares with LocalStack. It is a single Rust binary, early stage and openly incomplete, and Opus told Vincent it is generated from AWS's Smithy API contracts. There is no ARM macOS build, so he runs it in Docker. Building it needed a 16-core, 128 GB instance, and a single-threaded link step was the bottleneck until Opus suggested a parallel linker. AWS doesn't accept pull requests, so Vincent keeps his own patch, which Fable wrote. Kai assumes the emulator is much faster than the cloud; Vincent says that is the point, letting agents verify changes locally.

[![Kai Hendry asking Vincent about the AWS emulator](/podcast/slides/AHl4atOHnKo/youtube-AHl4atOHnKo/slide_0002_750.20s.png)](https://youtu.be/AHl4atOHnKo?t=750)

### [00:18:07](https://youtu.be/AHl4atOHnKo?t=1087) Inside the workshop box

Vincent estimates about 5 GB of memory per attendee, much of it for the TypeScript language server. Rather than a container service per attendee, he shards attendees across Graviton EC2 instances, about seven to each, behind Caddy. He pays for it from his own account and his AWS Community Builder budget: a few dollars per instance for five hours. From [00:21:57](https://youtu.be/AHl4atOHnKo?t=1317), they trade views on Caddy, Traefik and Kong.

From [00:23:28](https://youtu.be/AHl4atOHnKo?t=1408), Vincent shows what attendees get. The emulator has no console, so steps that used the AWS console became CLI commands. He took the original markdown of AWS's CDK workshop, which Elad Ben-Israel's team wrote and AWS has since archived, and ported it to Terraform. A progress tracker built on Cloudflare Durable Objects lets attendees put themselves on a leaderboard, and validation steps check each endpoint they deploy. The names and emails it collects will feed his next talk, on stopping agents from leaking personal data. Kai calls it completely gamified and offers to try it first; Vincent says the whole thing took about two days.

[![The workshop's CloudWatch logs step, using the AWS CLI because the sandbox has no console](/podcast/slides/AHl4atOHnKo/youtube-AHl4atOHnKo/slide_0003_1501.24s.png)](https://youtu.be/AHl4atOHnKo?t=1501)

### [00:32:32](https://youtu.be/AHl4atOHnKo?t=1952) Agents built the emulator

Kai opens the emulator's repository: about 64,000 Rust files and a great deal of markdown. Vincent says he never even looked at his workshop's code: Opus stood up the emulator and ran each workshop step against it. The emulator runs Lambda functions on QuickJS, so the workshop uses a handler that works there. It also blocked one Lambda from invoking another and returned success without checking IAM permissions. Fable patched both and rebuilt the emulator image in two to three hours, which Vincent puts down to the problem being well defined. During the call, his spot instance is terminated.

Kai is struck by commits from issue-finder and issue-fixer agents landing about two minutes apart, around the clock, and says it gives him "feelings of dread". He remembers reviewing the day's trunk commits with his team. Vincent replies that reviewing code is the wrong metric in the agentic era: you control verification and the intent layer instead. From [00:40:44](https://youtu.be/AHl4atOHnKo?t=2444), they joke about Microsoft's 24-hour outage, and Vincent says Google never kept the lead Gemini's million-token context gave it.

[![tig showing commits by AWS's IssueFinderAgent and IssueFixerAgent minutes apart](/podcast/slides/AHl4atOHnKo/youtube-AHl4atOHnKo/slide_0004_2257.24s.png)](https://youtu.be/AHl4atOHnKo?t=2257)

### [00:42:13](https://youtu.be/AHl4atOHnKo?t=2533) Skills, methodologies and gardening

Vincent describes Google's elephant and goldfish model as a good summary rather than anything new: it echoes Steve Yegge's Beads and Matt Pocock's grill-me skill with domain-driven design. A shared language is built up first, and short-lived agents then pick up work in it. He contrasts spec-driven tools such as Conductor and Spec Kit with "get shit done" styles. From [00:46:53](https://youtu.be/AHl4atOHnKo?t=2813), Kai shows Lauren Tan's verification skill, which Opus 5.5 used to discover the features of his Singapore bus app. Vincent approves of plain Playwright specs over a Playwright MCP. In his opinion Pocock explains things beautifully, while Tan brings experience of large projects.

From [00:51:18](https://youtu.be/AHl4atOHnKo?t=3078), Vincent says he uses Tan's state-machine ideas with Quint and TLA+ to check a race-condition fix. He agrees with much of her no-comments skill but wants a sanctioned way for agents to mark placeholders. From [00:55:35](https://youtu.be/AHl4atOHnKo?t=3335), Kai says his client's shared skills repository has gone stale. Vincent calls looking after skills "gardening", and they agree on shared glossaries, though Vincent warns they take several iterations and Kai says meanings blur across an enterprise's markets. From [00:59:55](https://youtu.be/AHl4atOHnKo?t=3595), Vincent shares Anthropic's "Rethinking Claude Code best practices" talk: emphatic instructions that older models needed now distract newer ones, and a Fable orchestrator handing work to Opus agents matches how he works.

[![A slide from Anthropic's Rethinking Claude Code talk: Opus 5.5 does the work](/podcast/slides/AHl4atOHnKo/youtube-AHl4atOHnKo/slide_0006_3761.40s.png)](https://youtu.be/AHl4atOHnKo?t=3761)

### [01:03:21](https://youtu.be/AHl4atOHnKo?t=3801) Prompt evals, PII and background agents

A colleague of Kai's wrote a page-long prompt for an AgentCore agent that decides whether a security finding is a false positive. Kai believes a short prompt would do with Opus 5.5 and wants to prove it. Vincent suggests evals and deleting paragraphs at random to see whether the agent still works, a technique he calls prompt "obliteration". Kai didn't expect Strands to keep memory and wants it lean. He also finds AgentCore slow to start.

From [01:10:10](https://youtu.be/AHl4atOHnKo?t=4210), Vincent previews a demo that blocks agents from reading personal data, and proposes short-lived tokens scoped to each task. Kai says the problem is human: engineers who break the glass can still paste production logs into Claude. Vincent replies that device management can flag it. Kai calls that a detective control and doesn't want to go into it, because it is current at his workplace. From [01:13:54](https://youtu.be/AHl4atOHnKo?t=4434), Vincent argues that background agents, which don't run on the engineer's laptop, remove the copy-and-paste route; Kai doesn't see it as a technical problem. Vincent's Red Hat talk in Singapore on the 27th covers these enterprise adoption patterns.

*Model: cli/claude/sonnet. Reviewed for names, attribution and timing. Generated from the approved recording's timed transcript because YouTube captions were not yet available; slides from the uploaded video.*
