---
title: Better Hotel Wifi
date: 2021-06-28T17:26:03+08:00
description: Working around a hotel's captive portal
---

I'm quarantined in a hotel for two weeks in Singapore and I don't want the
hassle of joining the open `JWMarriot` public network and logging in with my devices.

My solution is to connect a [Singapore bought
Mikrotik](https://www.lazada.sg/shop/mikrotik/) hap ac2 (aka RouterBOARD
D52G-5HacD2HnD-TC) to the phone like so:

<img src="https://s.natalian.org/2021-06-28/hotel.jpeg">

No IP address was acquired via `ether1` (default configuration) until I
called reception and request their tech team configures the port so that
an address comes down like so:

<img src="https://s.natalian.org/2021-06-28/settings.png">

Is the Mikrotik better?

<img width="45%" src="https://s.natalian.org/2021-06-28/JWmarriot.png" alt="JWMarriot nicetrace">
<img width="45%" src="https://s.natalian.org/2021-06-28/tik.png" alt="Mikrotik nicetrace">

Yes, my <abbr title="Wireless Access Point">AP</abbr> is on the table and ping times are halved with better stability
(no packetloss).

I work around the captive portal by only jumping hoops **once with the Mikrotik's MAC address**. Since it's consistently connected, it should not require a login again.🤞

So no need to jump hoops when I connect my devices, especially my
Archlinux machine which resists DNS poisoning on `portal.reivernet.com` !!
