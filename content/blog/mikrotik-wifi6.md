---
title: Mikrotik Wifi6
date: 2023-11-11T07:23:59Z
description: The labour of love for Latvia
---

Problems with wifi6 with Mikrotik.

The new wifiwave aka wifi6 implementation in Mikrotik has some nasty surprises.

# wifiwave's Capsman is not compatible with the older Capsman.

So now you have to run two controllers affectively. From [Mikrotik 7.13](https://youtu.be/37aff6d14Xk?t=572) you will be able to run both. At time of writing, this is not possible on current stable.

# Capsman behaves differently

The configuration is different, so you have to come up with a new configuration

# Isn't able to provision the local radio on the same device

You have to manually do this, and spend time wondering why it didn't work like any other mikrotik before.

    /interface/wifiwave/radio provision=0,1 

# The cap isn't routing

Does it need local fowarding like the older capsman? No, this time it needs:

    /interface/wifiwave2/cap set slaves-datapath=datapath_record

And for some reason the cap wouldn't take on the new configuration, unless reset. 

# Mikrotik's wifi6 doesn't work with my Thinkpad

As explained on the [Mikrotik forum](https://forum.mikrotik.com/viewtopic.php?p=1029204#p1029204)

The thinkpad doesn't have an issue wifi6 from Ubiquiti...


