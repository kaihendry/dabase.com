---
title: "Our First Air-to-Water Heat Pump: Vaillant aroTHERM plus"
description: "Notes, photos and costs from installing a Vaillant aroTHERM plus VWL 35/8.1 A air-to-water heat pump under the UK's Boiler Upgrade Scheme, plus wiring it into Home Assistant to chase cheap Octopus rates."
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

<a href="outdoor-sensor.avif"><img src="outdoor-sensor.avif" alt="Vaillant outdoor temperature sensor mounted on a shaded stone wall next to a downpipe" style="max-width:50%"></a>

Easy to miss: the outdoor temperature sensor, a separate little box that talks to the controller
over a radio link (there's no cable — see [what happens when that link drops]({{< ref "/blog/2026/heat-pump-surprises-standing-loss-and-minus-forty" >}})).
This is what the weather compensation curve reads — the 0.6 curve I mention below is a function of
*this* number — so it wants shade, away from direct sun and from the outdoor unit's own discharge
air. Ours is tucked beside a downpipe on the stone wall. It's also what feeds the outdoor
temperature entity in Home Assistant.

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

The myVAILLANT app does have an energy tab, incidentally. It just wasn't showing when I first
looked — it appeared on its own a few days after commissioning, so if yours is missing, wait
rather than raise a ticket. It also does **realtime** energy statistics, which I love: you can
watch the compressor draw while it's running, not just yesterday's totals.

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

## Home Assistant

There is a cloud API, and there's a community Home Assistant integration for it:
[mypyllant](https://github.com/signalkraft/mypyllant-component). Installed via HACS, it logs into
the same myVAILLANT account the app uses and gives you ~50 entities — tank temperature, flow
temperature and setpoint, heating curve, outdoor temperature, energy consumed and heat generated,
and a `climate` entity for the zone.

Two configuration traps cost me an evening, both under **Settings → Devices & Services →
myVAILLANT → Configure**:

- **The daily energy sensors don't refresh by default.** The update interval is unset out of the
  box, so the coordinator fetches once at startup and then never again. Everything looks plausible
  — it just silently stops moving. I had `consumed_electrical_energy_heating` go from 100 Wh to
  200 Wh and briefly thought the heat pump had run, when in fact it was a Home Assistant restart
  re-fetching. Set it to 3600 seconds; hourly is plenty for daily-resolution data.
- **Saving options doesn't reload the integration.** No amount of clicking Submit does anything
  until you restart Home Assistant. Restart after every change to Configure.

Realtime power is a *separate* option ("fetch real-time power usage"), which adds a
`current_power` sensor. Worth turning on — it's the same live figure the app shows.

One rule that matters more here than with local hardware: **the Vaillant API has strict quotas and
will lock you out.** Never poll it on a `time_pattern`. Event-driven automations only.

### Shifting hot water onto the cheap rate

We're on [Octopus Intelligent Go](https://octopus.energy/smart/intelligent-octopus-go/), which is
cheap in two ways: the fixed 23:30–05:30 window, and the SMART dispatch slots Octopus grants
outside it when it schedules the car — during which the *whole house* import drops to the off-peak
rate, not just the car. That's another 1–3.5 hours a day, at unpredictable times.

The cylinder's own time program already runs 23:30–05:30, so scheduled hot water was on the cheap
rate from day one. The gap was the daytime: if the tank ran down by teatime, the choice was reheat
at ~30p/kWh or go without until 23:30.

So a pair of automations now watch the dispatch sensor and hit the cylinder's boost switch when a
slot has been running five minutes, the tank is under 45 °C, and it's between 06:00 and 22:00 —
cancelling the boost if the slot ends before the reheat finishes. The five-minute delay matters:
some dispatch slots are only ten minutes long, and starting a DHW cycle for that just short-cycles
the compressor.

It's not really a money-saver — it's insurance against buying evening hot water at peak rate.
Expect it to fire once or twice a day, sometimes not at all.

The first COP figure from all this was a nice surprise: **1.1 kWh of electricity in, 5.2 kWh of
heat out** for a hot water reheat — a COP of about 4.7. The seasonal heating efficiency sensor
reads 3.7. Against a resistive immersion heater at a flat 1.0, that's the whole argument for a
heat pump in one line.

### Space heating: the plan, not yet the practice

Doing the same for space heating is harder, and I've deliberately not built it yet — it's July,
and there's no heating history to tune against.

The lever is `mypyllant.set_quick_veto`, a temporary setpoint override with a duration that
expires by itself. (There's an official example that suppresses heating with `set_holiday`
instead — avoid it. Holiday mode doesn't self-expire, so if the automation meant to cancel it ever
fails, you find out in January.)

The tension is that preheating costs efficiency: raising the room setpoint pushes flow temperature
up via the weather compensation curve, and a heat pump loses roughly 2–3% COP per °C of flow temp.
Our curve is set to 0.6, which is low, and that low curve is *why* the seasonal figure is 3.7.

The tariff spread wins anyway:

| | COP | Cost per kWh of heat |
|---|---|---|
| Normal, off-peak (7p) | 3.7 | 1.9p |
| Preheating, off-peak (7p) | ~3.0 | 2.3p |
| Normal, peak (~30p) | 3.7 | 8.1p |

Even a 19% efficiency hit leaves off-peak heat about 3.5× cheaper than peak heat. But the veto
wants to stay modest — +1.5 to 2 °C, not a deep boost/setback cycle — and it should be skipped
below about 2 °C outdoors, when the heat pump is already flat out and has nothing spare to shift
with.

Dispatch slots are also much weaker for heating than for hot water. A cylinder swallows 3 kWh in
half an hour; a building's thermal mass doesn't respond meaningfully in that time. Only the long
morning slots (05:30–07:30 turns up regularly) are worth extending a preheat into.

Two things I don't know yet, and can't until winter: how long the cottage actually holds a 2 °C
overshoot, and how much of the day that lets me shift. My guess is I'll move the morning and
nothing more.

There's one gotcha I've already found: the zone's control sensor lives in the hallway, near a
window. It read 30.2 °C with 20 °C outside — a *correct* reading that is in no way representative
of the house. Anything keyed off zone temperature inherits that bias, so time and price make the
better triggers, with temperature only as a guard.
