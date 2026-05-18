---
title: "Comparing SDD Frameworks: spec-kit vs OpenSpec vs get-shit-done"
description: "Notes on the differences between three Spec Driven Development frameworks — GitHub's spec-kit, Fission-AI's OpenSpec, and gsd-build's get-shit-done."
date: 2026-05-18T15:22:11+01:00
---

I did try https://kiro.dev/ and https://antigravity.google/ but they were so slow as to be unusable.

Notes on three Spec Driven Development (SDD) frameworks I've been comparing:

- [github/spec-kit](https://github.com/github/spec-kit)
- [Fission-AI/OpenSpec](https://github.com/Fission-AI/OpenSpec)
- [gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done)

It retrospect I wish I generated unique keys for these experiments to get a better understanding of the costs.

## spec-kit

Using https://github.com/kaihendry/ai-check-guardrails

Not a perfect experience with Claude code, nonetheless I thought it did well:

* It does a branch when you do a /speckit-specify which makes me think this is the most "multi-player" ready
* It kindof [auto commits](https://github.com/github/spec-kit/discussions/2616)
* There does seem to be some [community](https://github.com/github/spec-kit/discussions/2529)
* default [constitution](https://github.com/kaihendry/ai-check-guardrails/blob/main/.specify/memory/constitution.md) read my mind

## OpenSpec

https://github.com/kaihendry/asaguard

* https://github.com/kaihendry/asaguard/blob/main/openspec/config.yaml doesn't actually seem to work, UPDATE: my schema was wrong https://github.com/Fission-AI/OpenSpec/blob/main/docs/customization.md (+1 helpful discord community)
* not sure why you have to /opsx:archive manually

## get-shit-done

https://github.com/kaihendry/ai-siem-endpoint

* it's use of multiple agents makes me think this is pretty token heavy
* seems the most bureaucratic, but that's maybe because my expectations were that it shouldn't be!
* discord feels dead
* i am confused by the numbering, e.g. `/gsd-plan-phase 1` and `/gsd-execute-phase 1`

## Takeaways

My "own way" of using [beads](https://github.com/gastownhall/beads) and
_vibing_ doesn't seem eclipsed in my mind by <abbr title="Spec driven
development">SDD</abbr>. The frameworks may help clarify some large features,
but normally I've already broken them down already in my mind.
