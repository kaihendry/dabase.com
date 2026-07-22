---
title: "Our First Air-to-Water Heat Pump: Vaillant aroTHERM plus"
description: "Notes and photos from installing a Vaillant aroTHERM plus VWL 35/8.1 A air-to-water heat pump under the UK's Boiler Upgrade Scheme."
date: 2026-07-22T17:34:29+01:00
---

We've just had our first air-to-water heat pump installed, taking advantage of the UK's
[Boiler Upgrade Scheme](https://www.gov.uk/apply-boiler-upgrade-scheme) grant. It's a Vaillant
aroTHERM plus, model **VWL 35/8.1 A 230V**, rated Pmax 3.4 kW, IP X4. That "8.1" in the model
code is effectively the generation marker.

The install took **7 working days**, with a crew of four: one electrician, one plumber, and two
apprentices. It was a lot of work — we also had every radiator in the house replaced, since heat
pumps run at lower flow temperatures and need more surface area to shift the same amount of heat.

<a href="outdoor-unit.jpeg"><img src="outdoor-unit.jpeg" alt="Vaillant aroTHERM plus outdoor unit mounted against a stone wall" style="max-width:50%"></a>

The outdoor unit sits on a raised bracket against the old stone wall of the house. Single fan,
monobloc design — all the refrigerant circuit is sealed inside this box, so only water pipes run
into the house rather than refrigerant lines.

<a href="outdoor-unit-isolator-r290-label.jpeg"><img src="outdoor-unit-isolator-r290-label.jpeg" alt="Rear of the outdoor unit showing the R290 refrigerant label and red isolator switch" style="max-width:50%"></a>

Round the back: the R290 (propane) refrigerant label and the red electrical isolator. R290 is a
natural refrigerant with a very low global warming potential compared to the older F-gas
refrigerants, which is part of why it's mildly flammable and gets its own hazard sticker.

<a href="wall-pipe-penetration.jpeg"><img src="wall-pipe-penetration.jpeg" alt="Insulated pipes passing through the wall into the plant room, protected by a small metal cage" style="max-width:50%"></a>

The flow and return pipes penetrate the wall here, insulated and boxed in with a little metal
cage to stop them getting knocked.

<a href="plant-room-cylinder.jpeg"><img src="plant-room-cylinder.jpeg" alt="Indoor plant room with hot water cylinder, expansion vessels, and pipework" style="max-width:50%"></a>

Inside, the plant room: a Vaillant hot water cylinder, a couple of expansion vessels, and the
manifold where the heat pump's low-temperature circuit ties into the existing pipework.

<a href="pipe-runs-ceiling.jpeg"><img src="pipe-runs-ceiling.jpeg" alt="Insulated pipe runs across the ceiling and down the wall to the manifold" style="max-width:50%"></a>

Pipe runs across the ceiling, insulated, feeding down to the manifold below.

<a href="sensocomfort-controller.jpeg"><img src="sensocomfort-controller.jpeg" alt="Vaillant sensoCOMFORT controller showing flow temperature, room temperature, and system pressure" style="max-width:50%"></a>

The sensoCOMFORT controller — flow temperature, room temperature, and system pressure at a
glance, with the myVAILLANT connect boxes for remote monitoring mounted alongside.

<a href="energy-display.jpeg"><img src="energy-display.jpeg" alt="Vaillant display showing energy consumption in Wh for today, yesterday, last month, and last year" style="max-width:50%"></a>

And the energy display, already logging consumption in Wh. Numbers are tiny so far since it's
only just gone live — worth revisiting once we've got a full heating season of data.

## First impressions

A few surprises:

- I didn't expect it to come with an **immersion heater** as backup for the hot water cylinder.
- It's **so quiet** — standing next to the outdoor unit, I can barely hear it running.
- We replaced every radiator, and I'm not sure it was worth it — the new ones are only slightly
  larger than what we had before.

## Next steps

I've yet to figure out how to see energy usage from the myVAILLANT app itself. I'm also wondering
whether there's a cloud API I can use to tie this in with our
[Octopus Intelligent Go](https://octopus.energy/smart/intelligent-go/) tariff — worth digging
into once we've lived with the system for a while.
