---
title: "AI Engineer Europe 2026: Takeaways from London"
date: 2026-04-14T09:54:40+01:00
description: "My takeaways from volunteering at AI Engineer Europe in London — workshops, talks, and the people who made it worthwhile."
---

I volunteered (associate) at [AI Engineer Europe](https://www.ai.engineer/europe) in London last week. Three days: workshops on Wednesday, presentations on Thursday and Friday.

## Workshops (Wednesday)

### Anthropic

I arrived early for the Anthropic "How to Build Agents That Run for Hours (Without Losing the Plot)". I assumed we would go through https://github.com/anthropics/claude-quickstarts/tree/main/autonomous-coding and ask questions, but it was more of a presentation on the whole "Adverserial Agent" pattern.

The big idea (as I understood it) was to have a Generator (not good at critique) <-> Evaluator (possible to be critical) aka the "adverserial eval", two agents runnings in tandem.

It was interesting how they mentioned this is "Agile pilled" with:
* Sprints
* Definition of Done
* Scope clarifications (scope kick off)

Though I couldn't help think this is not [Agile as I know it](https://agilemanifesto.org/principles.html), nonetheless this AI usage pattern neatly fits with the way a lot of software is produced currently.

[@AshPrabaker](https://x.com/AshPrabaker) had a curious recommendation of using JSON since the model is less likely to manipulate it over Markdown. He recommended Playwright MCP and reading the traces. My other take away was the nomenclature they were using, they use the word **rubric** a lot which I understand as a "prompt".

Observability and team collaboration isn't quite figured out and this approach doesn't make sense on Brown field projects. A lot of food for thought and the whole experience helped my FOMO, since I feel my own AI journey was pretty close to what they and others were doing.

### Pydantic

I drifted into [@samuelcolvin](https://x.com/samuelcolvin)'s workshop and I was glad I did. Tbh I'm big fan of [Pydantic model validation](https://pydantic.dev/docs/validation/latest/concepts/models/), and I had no idea about Logfire and these other AI ventures. This was a proper workshop where we effectively refined a prompt to get achieve better results with a model.

I learned about [GEPA - Genetic Pareto](https://pydantic.dev/articles/prompt-optimization-with-gepa) and associated Pydantic AI tooling, though tbh this use case was a bit specialised to me. Since I'm a frontier model junkee so I don't need to optimise the use of existing models.

Loved how [hands on](https://github.com/samuelcolvin) Sam was.

### Google - Building conversational agents

<img src="https://s.natalian.org/2026-04-14/thor.avif" alt="Thor Schaeff and I">

I attended this because of the legend of [@thorwebdev](https://x.com/thorwebdev) who I know from Singapore. It's a bit frightening how good the Gemini AI audio stuff is with its multilingual support.

Tbh I was exhausted after these sessions and the weather was awesome so I ran out to play with my kids in Clapham Common.

## Talks Thursday April 9th 2026

I recorded a Podcast **from a LONDON BUS** otw to the event:

{{< youtube Z6sGEwXMN0w >}}

I'm glad I volunteered. Shout out to the organiser Natalie for being accomodating with my dress code. Was great to meet other volunteers like [@oalbacha](https://x.com/oalbacha) & [@sergiopesch](https://x.com/sergiopesch).

### Vercel

Finally get to see [@cramforce](https://x.com/cramforce) IRL. Love his talk, and his [final slide](https://youtu.be/O_IMsEg91g8?t=2465) about:

1. Future A - the labs win
2. Future B - we win 

... left me a little conflicted tbh. May be that was the point?

### OpenAI

Listening to [Ryan Lopopolo](https://x.com/_lopopolo) felt like I was in the Anthropic workshop again the day before. Harness, get agents to do things et al.

### OpenClaw

The legend [Peter](https://x.com/steipete) seemed a bit exasperated and I feel like there was nothing new in this presentation. Still moaning about crazy CVEs. I didn't see a path forward except for Peter to take a well earned holiday!

### Scraping the Web

Whilst helping out with crowd control in Rafael Levi's Your Agent's Biggest Lie: "I Searched the Web", I learned about https://brightdata.com/ai/mcp-server which after testing, is able to scrape https://www.screwfix.com/ aka bypass Cloudflare's captchas IIUC! WIN!

## Key Themes

## What I'm Taking Away


## The venue

{{< x user="lucasmeijer" id="2042994862555812192" >}}


The wifi held up really well, but some domains were blocked like the TLD .dev bizaarely.