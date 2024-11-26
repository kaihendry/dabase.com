---
title: Praze Smart Meter
date: 2024-11-26T18:00:11Z
description: Our meter is not in fact, smart
---

# The meter box (SMETS1)

<img src="https://s.natalian.org/2024-11-26/meter-check.png" alt="You have a first generation (SMETS1) electricity meter.">
<img src="https://s.natalian.org/2024-11-26/meter-box.jpeg">
<img src="https://s.natalian.org/2024-11-26/aclara.jpeg">

This meter box emits usage somehow to
https://www.smartdcc.co.uk/our-smart-network/ which vendors can access via a
[MPAN number](https://www.comparethemarket.com/energy/content/mpan-number/).

The big issue is that these are not granular.

<img src="https://s.natalian.org/2024-11-26/doubled.png">

> I have had a look at your account and can see that before yesterday, you had
> not received an up to date energy bill since March. This means that your
> balance was not accurate as per your latest charges. 
> I'm very sorry your bill was so late, this was due to some missing
> half-hourly electric readings that were preventing us from billing your
> Intelligent Octopus Go tariff. When this was manually billed up to date, your
> statement was able to be issued and your balance updated. 
> As an apology for the delayed statement, I have added a £30 credit to your
> account.

# Addressing the "half-hourly electric readings" issue

Octopus Energy have a [Home
mini](https://octopus.energy/blog/octopus-home-mini/) to help track live
energy, I registered but they say:

> it appears you are currently ineligible for the Home Mini as we haven’t
> received any smart meter readings from your account in the last 72 hours.

They later said:

> You currently have a first-generation smart meter, that isn't currently
> compatible with the Home Mini. However, the team are always working to
> improve bits behind the scenes and if your meter does become compatible,
> we'll then send you out a Home Mini and pop you an email to let you know it
> is on the way to you.

And:

> Some first-generation smart meters are eligible, unfortunately, yours and a
> few other models are not currently.

> This means while you will not be able to see your live usage at the moment,
> you can still see your Day, Week and Monthly usage via your Octopus account.
> So we would recommend this as your best current option to view your energy
> usage.

# Getting live readings

SMETS1 meters are claimed to be supported by Glowmarkt's <abbr title="Consumer
Access Device">CAD</abbr>, but they are [sold out of the devices](https://shop.glowmarkt.com/products/display-and-cad-combined-for-smart-meter-customers).

Another approach could be [Shelly Pro
EM](https://shellystore.co.uk/product/shelly-pro-em-50a/), but they require
clamps which could be tricky to install in our consumer unit.

# Different parts of the property

We have a consumer unit in the garage / cottage, and ideally we want live monitoring there too!

<img src="https://s.natalian.org/2024-11-26/cottage.jpeg">
