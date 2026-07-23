---
title: "Our First Air-to-Water Heat Pump: Vaillant aroTHERM plus"
description: "Notes and photos from installing a Vaillant aroTHERM plus VWL 35/8.1 A air-to-water heat pump under the UK's Boiler Upgrade Scheme."
date: 2026-07-22T17:34:29+01:00
---

We've just had our first air-to-water heat pump installed, taking advantage of the UK's
[Boiler Upgrade Scheme](https://www.gov.uk/apply-boiler-upgrade-scheme) grant. It's a Vaillant
aroTHERM plus, model **VWL 35/8.1 A 230V**, rated Pmax 3.4 kW, IP X4. That "8.1" in the model
code is effectively the generation marker.

The install took **8 working days** (Mon–Fri, then Mon–Weds), with a crew of four: one electrician, one plumber, and two
apprentices. It was a lot of work — we also had every radiator in the house replaced, since heat
pumps run at lower flow temperatures and need more surface area to shift the same amount of heat.

<a href="outdoor-unit.avif"><img src="outdoor-unit.avif" alt="Vaillant aroTHERM plus outdoor unit mounted against a stone wall" style="max-width:50%"></a>

The outdoor unit sits on a raised bracket against the old stone wall of the house. Single fan,
monobloc design — all the refrigerant circuit is sealed inside this box, so only water pipes run
into the house rather than refrigerant lines.

<a href="outdoor-unit-isolator-r290-label.avif"><img src="outdoor-unit-isolator-r290-label.avif" alt="Rear of the outdoor unit showing the R290 refrigerant label and red isolator switch" style="max-width:50%"></a>

Round the back: the R290 (propane) refrigerant label and the red electrical isolator. R290 is a
natural refrigerant with a very low global warming potential compared to the older F-gas
refrigerants, which is part of why it's mildly flammable and gets its own hazard sticker.

<a href="wall-pipe-penetration.avif"><img src="wall-pipe-penetration.avif" alt="Insulated pipes passing through the wall into the plant room, protected by a small metal cage" style="max-width:50%"></a>

The flow and return pipes penetrate the wall here, insulated and boxed in with a little metal
cage to stop them getting knocked.

<a href="plant-room-cylinder.avif"><img src="plant-room-cylinder.avif" alt="Indoor plant room with hot water cylinder, expansion vessels, and pipework" style="max-width:50%"></a>

Inside, the plant room: a Vaillant hot water cylinder, a couple of expansion vessels, and the
manifold where the heat pump's low-temperature circuit ties into the existing pipework.

<a href="pipe-runs-ceiling.avif"><img src="pipe-runs-ceiling.avif" alt="Insulated pipe runs across the ceiling and down the wall to the manifold" style="max-width:50%"></a>

Pipe runs across the ceiling, insulated, feeding down to the manifold below.

<a href="sensocomfort-controller.avif"><img src="sensocomfort-controller.avif" alt="Vaillant sensoCOMFORT controller showing flow temperature, room temperature, and system pressure" style="max-width:50%"></a>

The sensoCOMFORT controller — flow temperature, room temperature, and system pressure at a
glance, with the myVAILLANT connect boxes for remote monitoring mounted alongside.

<a href="energy-display.avif"><img src="energy-display.avif" alt="Vaillant display showing energy consumption in Wh for today, yesterday, last month, and last year" style="max-width:50%"></a>

And the energy display, already logging consumption in Wh. Numbers are tiny so far since it's
only just gone live — worth revisiting once we've got a full heating season of data.

## Cost

A few people have asked about the price, so here's the breakdown. The full contract with
[Reco Energy](https://www.recoenergy.co.uk/) — heat pump, hot water cylinder, and every radiator
in the house — came to **£15,818.31**, zero-rated for VAT (ASHP installs currently qualify for
0% VAT in the UK as an energy-saving measure).

Our install landed right on the boundary of the government's
[Boiler Upgrade Scheme](https://www.gov.uk/apply-boiler-upgrade-scheme) uplift on 21 July, when
the grant rose from £7,500 to £9,000. Reco invoiced the deposit and interim payments against the
old £7,500 figure, with the extra £1,500 due back as a credit once the uplifted voucher is
confirmed — so either way, the full £9,000 applies.

| | |
|---|---|
| Contract total | £15,818.31 |
| Boiler Upgrade Scheme grant (uplifted) | −£9,000.00 |
| **Net cost** | **£6,818.31** |

Paid in three instalments — 25% deposit, 35% interim, 40% final — with the grant applied against
the interim and final invoices.

## First impressions

A few surprises:

- I didn't expect it to come with an **immersion heater** as backup for the hot water cylinder.
- It's **so quiet** — standing next to the outdoor unit, I can barely hear it running.
- We replaced every radiator, and I'm not sure it was worth it — the new ones are only slightly
  larger than what we had before.

## Next steps

I've yet to figure out how to see energy usage from the myVAILLANT app itself. I'm also wondering
whether there's a cloud API I can use to tie this in with our
[Octopus Intelligent Go](https://octopus.energy/smart/intelligent-octopus-go/) tariff — worth digging
into once we've lived with the system for a while.
