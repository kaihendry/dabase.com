---
title: "Agents talking to agents"
date: "2026-11-04T13:02:04Z"
description: "Kai Hendry and Vincent De Smet try Rex, test whether Claude Code and Codex can message each other, and discuss API keys, zero trust, agent identity and a wild week of security exploits."
image: "https://dabase.com/podcast/images/047-agents-talking-to-agents.jpg"
thumbnail: "https://dabase.com/podcast/images/047-agents-talking-to-agents-wide.jpg"

podcast:
  episode: 47
  season: 1
  episodeType: "full"
  duration: 5559
  audioUrl: "https://dabase.com/podcast/audio/047-agents-talking-to-agents.mp3"
  audioSize: 133428261
  youtubeId: "HJmAy_V30Mk"
  youtubeUrl: "https://www.youtube.com/watch?v=HJmAy_V30Mk"
  transcriptSource: "transcribed per speaker from the edited recording, with technical-name corrections"
---

What happens when your coding agents can talk to each other? Kai Hendry has been living in Rex, the new terminal from Superlogical, the company Ghostty creator Mitchell Hashimoto founded after HashiCorp. Its skills let Codex open a terminal and put the same question to Claude, pick up a Claude session that ran out of usage, and pass messages between sessions. Vincent De Smet asks to see it, and they test it live.

Vincent describes a change to his own way of working: long-lived, named Claude Code sessions that report to an orchestrator agent instead of through him. Kai prefers messaging that does not depend on any one harness: "It's just text." They compare Rex with cmux, T3 Code and the Claude app, and Kai explains why portable MCP configuration is still the biggest gap in his AI workflow.

The second half turns to security. Hours spent untangling Cloudflare API tokens in GitHub Actions lead to OIDC, Tailscale and zero trust, and Vincent explains the egress proxy he is building so that sandboxed agents never hold real credentials. They discuss machine and user identities for agents, sso.tax, Chainguard's early release of a PHP fix, and a week of exploits including Brotli, eMudhra and Linux kernel bugs, before finishing with the Binance hack.

The episode opens with Kai's trip to Kuala Lumpur and Vincent's experience running cloud-native meetups in Vietnam. Recorded on 4 November 2026; a brief microphone dropout has been removed.

## Chapters

- [00:00](https://youtu.be/HJmAy_V30Mk?t=0) Kuala Lumpur, EVs and Vietnam's tech scene
- [02:54](https://youtu.be/HJmAy_V30Mk?t=174) Running tech meetups in Vietnam and beyond
- [15:09](https://youtu.be/HJmAy_V30Mk?t=909) GLM 5.3 and other models in Claude Code
- [18:53](https://youtu.be/HJmAy_V30Mk?t=1133) Harness lock-in: OpenClaw, ACP and T3 Code
- [21:32](https://youtu.be/HJmAy_V30Mk?t=1292) Rex, Superlogical and Ghostty
- [25:35](https://youtu.be/HJmAy_V30Mk?t=1535) suckless, st and reinventing the terminal
- [30:26](https://youtu.be/HJmAy_V30Mk?t=1826) Rex skills: agents launching agents
- [37:40](https://youtu.be/HJmAy_V30Mk?t=2260) Agents messaging an orchestrator in Claude Code
- [42:14](https://youtu.be/HJmAy_V30Mk?t=2534) Live demo: Claude and Codex talk through Rex
- [46:40](https://youtu.be/HJmAy_V30Mk?t=2800) Agent interfaces, Rex on iOS and portable MCPs
- [51:34](https://youtu.be/HJmAy_V30Mk?t=3094) Cloudflare, API tokens and missing OIDC
- [54:21](https://youtu.be/HJmAy_V30Mk?t=3261) CI startups chase agent sandboxes
- [56:42](https://youtu.be/HJmAy_V30Mk?t=3402) Is Cloudflare ready for the enterprise?
- [59:46](https://youtu.be/HJmAy_V30Mk?t=3586) Egress proxies, Tailscale and zero trust
- [1:10:03](https://youtu.be/HJmAy_V30Mk?t=4203) sso.tax and Chainguard's PHP embargo break
- [1:16:17](https://youtu.be/HJmAy_V30Mk?t=4577) A wild week of exploits: Brotli, eMudhra and Go
- [1:23:48](https://youtu.be/HJmAy_V30Mk?t=5028) Leaky fixes and leaning on managed services
- [1:29:34](https://youtu.be/HJmAy_V30Mk?t=5374) The Binance hack

## Mentioned

- [Rex by Superlogical](https://www.superlogical.com/), [Ghostty](https://ghostty.org/) and [cmux](https://cmux.com/)
- [st](https://st.suckless.org/) from [suckless](https://suckless.org/)
- [T3 Code](https://t3.codes/), [OpenClaw](https://openclaw.ai/), [Orca](https://www.onorca.dev/) and the [Agent Client Protocol](https://agentclientprotocol.com/)
- [Claude Code: orchestrate teams of Claude Code sessions](https://code.claude.com/docs/en/agent-teams)
- [SpecLedger](https://specledger.io/) and [Z.ai](https://z.ai/)
- [Dagger](https://dagger.io/) and [Depot](https://depot.dev/)
- [Tailscale](https://tailscale.com/), [Teleport](https://goteleport.com/) and [Amazon Bedrock AgentCore](https://aws.amazon.com/bedrock/agentcore/)
- [The SSO Wall of Shame](https://sso.tax/) and Chainguard's [Octo STS](https://github.com/octo-sts/app)
- [Brotli](https://github.com/google/brotli), [PrivateBin](https://privatebin.info/) and [xkcd: Random Number](https://xkcd.com/221/)

[Watch on YouTube](https://www.youtube.com/watch?v=HJmAy_V30Mk) · [Browse episodes and subscribe](https://dabase.com/podcast/)

## `summarize "https://youtu.be/HJmAy_V30Mk" --timestamps --slides`

Kai Hendry and Vincent De Smet catch up after Kai's trip to Kuala Lumpur, then spend much of the episode on terminal tooling for coding agents: Rex from Superlogical, a live test of Claude Code and Codex messaging each other, and Vincent's orchestrator of long-lived Claude Code sessions. The second half turns to API keys, agent identity and zero trust, and a week of security news.

[![Kai Hendry at the opening of episode 47](/podcast/slides/HJmAy_V30Mk/youtube-HJmAy_V30Mk/slide_0001_0.20s.png)](https://youtu.be/HJmAy_V30Mk?t=0)

### [00:00:00](https://youtu.be/HJmAy_V30Mk?t=0) Kuala Lumpur, EVs and meetups

Kai noticed many electric cars in Kuala Lumpur from brands he had never heard of, such as Zeekr, Leapmotor and Great Wall. Vincent says Vietnam has plenty of BYD and VinFast, and repeats online chatter that Vingroup looks more successful on paper than it is.

From [00:02:54](https://youtu.be/HJmAy_V30Mk?t=174), Vincent recalls starting a cloud-native meetup in Ho Chi Minh City, where about 80 people came to the first one. He found the OpenInfra Foundation community, backed by FPT and local data centres, hostile; Kai compares it with the protectionism he saw when working in Korea. Kai has heard that most community meetups are dead since COVID, apart from an active Rust meetup in Kuala Lumpur, and Vincent hopes to revive meetups in Ho Chi Minh City.

### [00:15:09](https://youtu.be/HJmAy_V30Mk?t=909) Open-weight models and harness lock-in

Kai's friend in Malaysia uses Claude Code with GLM 5.3. Vincent tops up Z.ai and DeepSeek wallets rather than paying for subscriptions; at work, he says, Anthropic models are expensive and budgets have been cut, so open-weight models such as GLM and DeepSeek are being evaluated behind a LiteLLM proxy. He also mentions a Revolut blog post about cutting token costs, saying Revolut is heavily using GLM.

From [00:18:53](https://youtu.be/HJmAy_V30Mk?t=1133), Vincent describes Anthropic initially locking down accounts that used OpenClaw before loosening up, while OpenAI, he says, hired OpenClaw's creator and allowed subscriptions to be used with it. Kai admits a "schadenfreude relationship" with Theo: he wants him to be wrong, but he is right a lot of the time. Kai was impressed by T3 Code but found it overwhelming, and couldn't get his Fastmail MCP working across all his agents.

### [00:21:32](https://youtu.be/HJmAy_V30Mk?t=1292) Rex, Superlogical and agent skills

Kai demos Rex, which he describes as tmux combined with Ghostty. Vincent explains that Superlogical was founded by Mitchell Hashimoto, the creator of Terraform and Ghostty, with several former HashiCorp colleagues, and that Rex replaces tmux's SSH-based approach with a dedicated client–server multiplexer protocol. From [00:25:35](https://youtu.be/HJmAy_V30Mk?t=1535), Kai compares Rex with the suckless st terminal and says it shows what Silicon Valley can do compared with Europe.

From [00:30:26](https://youtu.be/HJmAy_V30Mk?t=1826), Kai explains what excites him most: Rex's skills. From a Codex session, he asked Codex to open a terminal and have Claude independently investigate the same visitor spike, and he later had Codex resume a Claude task after his Claude usage ran out. Rex needs Tailscale for remote hosts, which his employer doesn't allow. Vincent thinks it looks just like cmux and wants to see it working across remote hosts.

[![Kai's Codex session in Rex investigating a visitor spike](/podcast/slides/HJmAy_V30Mk/youtube-HJmAy_V30Mk/slide_0003_1861.56s.png)](https://youtu.be/HJmAy_V30Mk?t=1861)

### [00:37:40](https://youtu.be/HJmAy_V30Mk?t=2260) Agents messaging each other

Vincent describes a change to his workflow: instead of acting as the messenger between long-lived Claude Code sessions, he had each introduce itself to a named orchestrator session, and they now report to it directly. Kai argues that Rex does this independently of the harness because its messaging is plain text: "It's just text. It's like as universal as Unix pipes or something."

From [00:42:14](https://youtu.be/HJmAy_V30Mk?t=2534), they test it live. After Kai removes some Orca hooks that are interfering, a Codex session and a Claude Code session introduce themselves to each other through Rex. Vincent accepts that it works, noting that the Claude-to-Claude exchange was quicker because Claude Code has its own channel.

From [00:46:40](https://youtu.be/HJmAy_V30Mk?t=2800), Kai praises Rex's iOS client as the best terminal emulator he has used on iOS. Vincent finds the Claude app clunky compared with his terminal but is open to better ways of working with agents; for now he stays in cmux. Kai's biggest remaining gap is keeping his MCP configuration consistent across computers.

[![Kai's sketch of Rex connecting a Codex session and three Claude sessions](/podcast/slides/HJmAy_V30Mk/youtube-HJmAy_V30Mk/slide_0004_2775.04s.png)](https://youtu.be/HJmAy_V30Mk?t=2775)

### [00:50:33](https://youtu.be/HJmAy_V30Mk?t=3033) Permissions, API keys and Cloudflare

Kai runs his agents without permission prompts on personal projects. Vincent uses the permission classifier at work, where endpoint-security rules flag AWS account IDs in command output.

From [00:51:34](https://youtu.be/HJmAy_V30Mk?t=3094), Kai describes spending hours on Cloudflare API tokens in GitHub Actions. He wants the OIDC trust relationships AWS supports and says "API keys is totally caveman". From [00:54:21](https://youtu.be/HJmAy_V30Mk?t=3261), Vincent notes that CI providers such as Depot are repositioning as isolated environments for agents, but doubts enterprises will be quick to adopt them. From [00:56:42](https://youtu.be/HJmAy_V30Mk?t=3402), he criticises Cloudflare's dashboards, its Terraform provider upgrades and, on a regulated client project, the lack of private connectivity to AWS load balancers. Kai sees Cloudflare as nimble and wants it to win, although it is not as mature as AWS.

From [00:59:46](https://youtu.be/HJmAy_V30Mk?t=3586), Vincent explains the egress proxy he is building so that sandboxed agents never hold real credentials; doing it properly with AWS Private CA would cost close to $500 a month. Kai suggests Tailscale, Vincent asks how that would solve Bitbucket authentication, and Kai promises to come back to him. Kai thinks public APIs may eventually sit behind identity-aware networks, while Vincent stresses the difference between machine and user identities.

[![Cloudflare's Durable Objects documentation on screen during the egress-proxy discussion](/podcast/slides/HJmAy_V30Mk/youtube-HJmAy_V30Mk/slide_0005_3706.32s.png)](https://youtu.be/HJmAy_V30Mk?t=3706)

### [01:10:03](https://youtu.be/HJmAy_V30Mk?t=4203) sso.tax, Chainguard and a wild week in security

Kai wants a site that names and shames integrations that rely on API keys; Vincent points him to sso.tax, which does this for products that put SSO behind a paywall. From [01:11:17](https://youtu.be/HJmAy_V30Mk?t=4277), Vincent turns to Chainguard, which campaigns against long-lived secrets, and a PHP remote-code-execution fix. He says Chainguard released it about six hours before the agreed embargo, citing active exploitation, which upset the PHP Foundation and led commenters to ask for proof. Kai had thought embargoes allowed fixes to ship before announcements.

From [01:16:17](https://youtu.be/HJmAy_V30Mk?t=4577), Vincent lists the week's other problems: Brotli decompression bugs affecting Node.js and other web servers, a weak eMudhra intermediate certificate key that he says an LLM was able to crack, and an urgent Go update. Kai suggests that not using PHP sets you up for success and that Go's linker keeps unused code out of binaries; Vincent replies that Go still needed patching and that JavaScript bundlers work the same way.

From [01:23:48](https://youtu.be/HJmAy_V30Mk?t=5028), they discuss fixes that reveal vulnerabilities before disclosure, including the DirtyFrag Linux kernel flaw, and Vincent explains why he is "all in" on managed services for sensitive material such as certificate authorities. Kai notes how slowly enterprises move. From [01:29:34](https://youtu.be/HJmAy_V30Mk?t=5374), they finish with the Binance hack: citing Coffeezilla, Vincent says a DevOps engineer was compromised through a fake job-interview assignment, and that about 2.5 billion of the 5.6 billion taken was frozen. Kai, a crypto sceptic, then leaves to take his children to school.

*Model: cli/claude/sonnet. Reviewed for names, attribution and timing. Generated from the approved recording's timed transcript because YouTube captions were not yet available; slides from the uploaded video.*
