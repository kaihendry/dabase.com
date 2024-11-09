---
title: Zola SSG review
date: 2021-07-24T09:35:15+08:00
description: Zola is indeed an opinionated static site generator
---

Since I find [Hugo](https://gohugo.io/) poorly designed with their [template lookup order / page bundles
endlessly
confusing](https://discourse.gohugo.io/t/section-photos-layout-structure/33712?u=hendry),
I have been looking out for new <abbr title="static site generators">SSGs</abbr>.

# Enter Zola

<img src="https://s.natalian.org/2021-07-24/zola-yay.png" alt="Zola in Archlinux">

Since [Zola](https://www.getzola.org/) is packaged in community on Archlinux, I thought, it must be good.

It's written in rust and the standout feature from kicking the wheels upon the <abbr
title="Command Line Interface">CLI</abbr>, was `zola check`. What a great idea! No need for a [separate link rot workflow](https://github.com/lycheeverse/lychee-action)!

I tried it upon https://github.com/kaihendry/enemies-of-carlotta-zola and it found it has two annoying short comings for me.

# Temporal data is the most important (for me)

Zola's author Vincent makes some [good points why he won't implement dates in URLs](https://github.com/getzola/zola/issues/635#issuecomment-524564469)

> Dates in URL don't take into account updates so I see eg a React guide with 2015 in the URL I'm not going to look at it even though it might have been updated yesterday

I agree for **living documents** like <https://whatwg.org/html> putting a YYYY in the URL doesn't make sense! Though for me, most of the content I create like this blog, will **not be updated into the new year** (it will be static!). So I want to be **crystal clear which year** that content was created. E.g. <https://dabase.com/blog/2021/Fixing-Hotel-TV/>. Hotel TVs/monitors will be a very different landscape in 2000 as well as 2030, I'm sure! I don't see the need for the date any more granular for my content. No need for Months, Days, hours etc.

# Requires front matter

[Zola's author won't make front matter optional](https://github.com/getzola/zola/issues/374#issuecomment-881631006) because:
* You might post something accidentally
* It's common place

For me, I just want to write a blog post without archetypes, tags, description.
I just want to `vim 2020_Blog-topic.md`, and I'm away. I'm bored of every <abbr
title="static site generator">SSG</abbr>, requiring a slightly different format.
YAML, TOML. I am so tired of this, I just feel that we can do away with it.

Description can maybe come from a tl;dr style message. Tags can be generated.

# Conclusion

The features I like from full fledged <abbr title="static site
generators">SSGs</abbr> like https://www.getzola.org/ are probably not worth
the pain of me forcing my requirements into them. Tbh writing a [Web site
generation tool with Go lang is quite
easy](https://github.com/kaihendry/natalian/blob/mk/Makefile), and I should
probably focus on that more and stop being a consumer. However my <abbr
title="Fear of missing out">FOMO</abbr> over pagination / breadcrumb navigation
/ [backlinks](https://github.com/kaihendry/backlinks) (which I've never been
able to implement myself!) / new ideas keeps me looking out for interesting
<abbr title="static site generators">SSGs</abbr> that are in fashion.
