---
title: Mikrotik Wifi6
date: 2023-11-11T07:23:59Z
description: The labour of love for Latvia
---

Problems with wifi6 with Mikrotik.

The new wifiwave aka wifi6 implementation in Mikrotik has some nasty suprises.

# wifiwave's Capsman is not compatible with the older Capsman.

So now you have to run two controllers affectively.

# Capsman behaves differently

The configuration is different, so you have to come up with a new configuration

# Isn't able to provision the local radio on the same device

You have to manually do this, and spend time wondering why it didn't work like any other mikrotik before

# Doesn't work with my Thinkpad

As explained on the [Mikrotik forum](https://forum.mikrotik.com/viewtopic.php?p=1029204#p1029204)
