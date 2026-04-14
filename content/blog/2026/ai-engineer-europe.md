---
title: "AI Engineer Europe 2026: Takeaways from London"
date: 2026-04-14T09:54:40+01:00
description: "My takeaways from volunteering at AI Engineer Europe in London — workshops, talks, and the people who made it worthwhile."
---

I volunteered (associate) at [AI Engineer Europe](https://www.ai.engineer/europe) in London last week. Three days: workshops on Wednesday, presentations on Thursday and Friday. I had my family with me, so I didn't go for any drinks / side events.

## Workshops (Wednesday)

### Anthropic

I arrived early for the Anthropic "How to Build Agents That Run for Hours (Without Losing the Plot)". I assumed we would go through https://github.com/anthropics/claude-quickstarts/tree/main/autonomous-coding and ask questions, but it was more of a presentation on the whole "Adversarial Agent" pattern.

The big idea (as I understood it) was to have a Generator (not good at critique) <-> Evaluator (possible to be critical) aka the "adversarial eval", two agents running in tandem.

It was interesting how they mentioned this is "Agile pilled" with familiar development ceremonies like: 
* Sprints
* Definition of Done
* Scope clarifications (kick offs)

Though I couldn't help think this is NOT [Agile as I know it](https://agilemanifesto.org/principles.html), nonetheless this AI usage pattern neatly fits with the way a lot of software is produced up until now in "Jira pilled" Enterprises.

[@AshPrabaker](https://x.com/AshPrabaker) had a curious recommendation of using JSON since the agent (Claude) is less likely to manipulate it over Markdown. He recommended Playwright MCP (I was a little incredulous about this) and reading traces. I noticed the nomenclature Anthropic were using, they use the word **rubric** a lot which I understand as a "prompt".

Observability and team collaboration isn't quite figured out and this approach doesn't make sense on brownfield projects. A lot of food for thought and the whole experience helped my FOMO, since I feel my own AI journey was pretty close to what they and others were doing.

### Pydantic

I drifted into [@samuelcolvin](https://x.com/samuelcolvin)'s workshop and I was glad I did. I'm a big fan of [Pydantic model validation](https://pydantic.dev/docs/validation/latest/concepts/models/), and I had no idea about Logfire and these other AI ventures. This was a proper workshop where we effectively refined a prompt to achieve better results with a model.

I learned about [GEPA - Genetic Pareto](https://pydantic.dev/articles/prompt-optimization-with-gepa) and associated Pydantic AI tooling, though tbh this use case was a bit specialised to me. Since I'm a frontier model addict,  I don't need to optimise the use of existing models. Useful nonetheless to know in case I work with a client who wants to for cost / scale reasons.

Loved how [hands-on](https://github.com/samuelcolvin) Sam was.

### Google - Building conversational agents

<img src="https://s.natalian.org/2026-04-14/thor.avif" alt="Thor Schaeff and I">

I attended this because of legend [@thorwebdev](https://x.com/thorwebdev) who I know from Singapore. It's a bit frightening how good the Gemini AI audio stuff is with its multilingual support.

Tbh I was exhausted after these sessions and the weather was awesome so I ran out to play with my kids in Clapham Common.

## Talks Thursday April 9th 2026

I recorded a Podcast **from a LONDON BUS** otw to the event:

{{< youtube Z6sGEwXMN0w >}}

I'm glad I volunteered. Shout out to the organiser Natalie for being accommodating with my dress code. Was great to meet other volunteers like [@oalbacha](https://x.com/oalbacha) & [@sergiopesch](https://x.com/sergiopesch).

### Vercel

Finally get to see [@cramforce](https://x.com/cramforce) IRL. Loved his talk (and Vercel aesthetics), and his [final slide](https://youtu.be/O_IMsEg91g8?t=2465) about:

1. Future A - the labs win
2. Future B - we win 

... left me a little conflicted tbh. May be that was the point?

### OpenAI

Listening to [Ryan Lopopolo](https://x.com/_lopopolo) felt like I was in the Anthropic workshop again the day before. Harness, get agents to do things, etc.

### OpenClaw

The legend [Peter](https://x.com/steipete) seemed a bit exasperated and I feel like there was nothing new in this presentation. Maybe AI will finally cut through the CVE noise and surface what actually matters.

### Scraping the Web

Whilst helping out with crowd control in Rafael Levi's Your Agent's Biggest Lie: "I Searched the Web", I learned about https://brightdata.com/ai/mcp-server which after testing, is able to scrape https://www.screwfix.com/ aka bypass Cloudflare's captchas IIUC! WIN!

### Reverse engineering a Viking VOIP phone protocol with Claude Code

Again I was manning the door, but this interested me greatly since I have a couple of VOIP phones I need to maintain! The https://elevenlabs.io/ demo where you needed to answer some questions with an AI with Michael Caine's voice (used with permissions) was VERY impressive. One of the questions was about a Deepmind game, I answered "Baduk", it said wrong answer, the right answer "Go", I protested and the quiz corrected the score. Amazing.

### Why Your AI UX Is Broken (and It's Not the Model's Fault)

[@christensencode](https://x.com/christensencode) showed how to keep sessions alive with [@ablyrealtime](https://x.com/ablyrealtime)'s AI Transport, which is impressive. Atm I use a messy combo of Whatsapp with Openclaw and https://cmd-ctrl.ai/ to keep in contact with my sessions, though this technology seemed awesome for building something that scales to the public over the Web.

<img src="https://s.natalian.org/2026-04-14/paddy.avif" alt="Paddy and I">

Was great meeting with my ex-boss & Ably CTO Paddy. An incredible guy.

### The Production AI Playbook: Deploying Agents at Enterprise Scale

This was long but really well structured presentation, which kept you baited to the end (like a raffle) to get the artefacts: https://drive.google.com/drive/folders/1acC5n1iE_63onW0S6960cYsAdHOMxVQE

Lots of good advice for consultants like myself to deliver successful AI deployments.

I went to join my family at 4PM since I was exhausted by then...

## Talks Friday April 10th 2026

### Gemma, DeepMind's Family of Open Models

I learned from [@osanseviero](https://x.com/osanseviero) that Google publishes capable open weight models. The only use case I could think of using it for is Automatic Number Plate Recognition (ANPR), but an attendee said that probably wouldn't work.

### The Future of MCP

[David Soria Parra](https://x.com/dsp_) came out fighting with "it fucking works" MCP and I loved it. David comes across as an "Alpha" technologist, super driven and good to see. MCP is very much alive!

### AgentCraft: Putting the Orc in Agent Orchestration

This was one of the most creative / insane talks I've ever witnessed. Who knew that those countless hours playing Warcraft (nowadays [Starcraft 2](https://www.youtube.com/watch?v=wlLiZcl31z8)) as a kid has equipped me to orchestrate Agents? Amazing [Ido Salomon](https://x.com/idosal1).

### Building pi in a World of Slop

This was my favourite talk and what I wanted to hear: "Lets slow the fuck down!"

{{< x user="badlogicgames" id="2042683257884467479" >}}

### The Friction Is Your Judgment

This felt like a follow on from Mario's talk. I was loving it.

{{< x user="kaihendry" id="2042532814327828812" >}}

### Every API Is a Tool for Agents

Finally I met [@mattzcarey](https://x.com/mattzcarey) IRL. My take away: Cloudflare are sorting out their confusing CLI. May it compete with the aws cli!

### Expo

Spent time chatting with people for a change! I was impressed by https://arize.com/ AI observability demoed to me by the 10x Engineer [Laurie Voss](https://x.com/seldo). I learned the term <abbr title="Agent Experience">AX</abbr>.

### Let’s Talk About FOMAT – Fear of Missing Agent Time

<img src="https://s.natalian.org/2026-04-14/cmdctrl.avif">

I met bit.ly founder [Michael](https://x.com/mrwoofster) earlier and I supported him by attending his talk. I am now a https://cmd-ctrl.ai/ user and I love it!

## The venue

https://qeiicentre.london/ was in a fantastic location, but it was a little weird!

{{< x user="lucasmeijer" id="2042994862555812192" >}}

The wifi held up really well, but some domains were blocked — the TLD .dev, bizarrely.

I noticed the toilets all were missing the hand driers, I presume because of COVID?

<img src="https://s.natalian.org/2026-04-14/drier.avif" alt="case of the missing hand driers">

One of the overflow rooms had a leak. I ended up using the stairs a lot of the time since they were replacing the elevators during the conference!

The navigation of the QE2 venue was quite confusing. I understood where things were on day three.

## AI Engineer conference

https://www.ai.engineer/ by [@swyx](https://x.com/swyx) & pals was a triumph. Best AI conference by far, tastefully localised and I am feeling much better for it.

## My take away

I came to this conference with a lot of FOMO and imposters syndrome. After the presentations and conversations, I feel confident about my experience with AI. 

I'm going to endeavour to get back to basics, use simpler tools like https://shittycodingagent.ai/ and remind myself to slow down and have fun with this.