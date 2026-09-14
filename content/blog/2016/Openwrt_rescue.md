---
date: 2016-03-19 15:21:56 +0800
tags: [networking]
title: "Recovering an OpenWrt router in failsafe mode"
description: "A 2016 recovery note about giving a Linux Ethernet interface a static address to reach an OpenWrt router in its old failsafe environment."
historical: "These router notes describe hardware and OpenWrt firmware used in 2016. Recovery methods and wireless results are specific to that environment."
---

When resetting an OpenWRT router into failsafe mode, it usually comes up as
192.168.1.1 with no DHCPD. So you need to manually set your machine 192.168.1.1
and telnet to it.

This is non-trivial in Linux. For example my wired network interface's name is
`enp0s20u2`:

	ip addr add 192.168.1.2/24 broadcast 192.168.1.255 dev enp0s20u2
	route add default gw 192.168.1.1 dev enp0s20u2

You need the route to make sure you direct traffic to `192.168.1.1`.
