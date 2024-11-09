---
date: 2012-07-17 16:34:44 +0200
---

My WIFI is connected to the Internet. I want share Internet with a device that doesn't have wifi via the WIRED ethernet ports.

Using [systemd-networkd](https://wiki.archlinux.org/index.php/Systemd-networkd) I configure `/etc/systemd/network/wifi.network` like so:

	[Match]
	Name=wl*
	[Network]
	DHCP=ipv4
	LinkLocalAddressing=no
	IPForward=ipv4

Notice **IPForward** which is key.

My WIRED ethernet port is configured by `/etc/systemd/network/wired.network` like so:

	[Match]
	Name=enp0s25
	[Network]
	Address=0.0.0.0/28
	LinkLocalAddressing=no
	DHCPServer=yes
	IPMasquerade=yes

Notice my **DHCPServer** so that the client to the network port can get an IP.

I use this [networking technique when wire sharking](https://www.youtube.com/watch?v=tVPiIruJ7rA).
