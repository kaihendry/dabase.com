---
date: 2015-12-04 21:18:57 +0800
---

Consider:

	[hendry@sg ~]$ hostname
	sg.dabase.com
	[hendry@sg ~]$ logout
	Connection to 128.199.115.232 closed.
	X1C3:~$ hostname
	X1C3

`sg` is the name of my server. To address it from anywhere on the internet,
it's simply `sg.dabase.com`.

`X1C3` is my laptop. It's not online all the time. It's usually on a
`192.168.x.x` address inside a NAT. To address it in a LAN it's simply
`X1C3.local` since all the devices on my LAN run
[Avahi/Zeroconf/Bonjour/mDNS](https://wiki.archlinux.org/index.php/Avahi#Hostname_resolution)
hostname resolution.
You cannot connect to it from anywhere on the Internet.
However if you are in the same LAN/vicinity/network as I am, you should be able
to explore my Web apps off `http://X1C3.local/`.

# Issues

## How to test hostname if it's a remote or local machine?

In shell it could be:

	if test $(hostname) == $(hostname | cut -d. -f1); then echo local; else echo remote; fi

## How to test mDNS is running correctly in "private infrastructure environments"?

In shell it could be:

	ping -c 1 $(hostname).local &>/dev/null && echo mDNS is working
