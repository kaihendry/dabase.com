---
date: 2014-03-17 14:20:12 +0800
---

<iframe width="560" height="315" src="https://www.youtube.com/embed/jCueB33PcTE" frameborder="0" allowfullscreen></iframe>

For the last year (2013) Archlinux has been recommending users to use
[netctl](https://wiki.archlinux.org/index.php/Netctl) to configure their
network interfaces.

Netctl's ethernet-dhcp worked well, but not the wireless interface management
which never made sense to me.

Upstream's Jouke Witteveen is
[sadly](https://github.com/joukewitteveen/netctl/issues/66)
[unhelpful](https://github.com/joukewitteveen/netctl/issues/81) despite my
cries for help.

So on the back of systemd's (>210) **systemd-networkd**, which I [previously blogged about when
configuring my Droplet](http://dabase.com/blog/Systemd_network_on_a_Droplet/),
I now have:

	$ cat /etc/systemd/network/eth0.network
	[Match]
	Name=eth0
	[Network]
	DHCP=yes

Via `journalctl -u systemd-networkd.service -f` this seems to be able to detect
the carrier is on or off **without** ifplugd. Nice!

## Completely optional - systemd-resolved for DNS

Tbh I prefer to hard code /etc/resolv.conf with `nameserver 8.8.8.8`.

However you can `sudo systemctl {run,status,enable} systemd-resolved`.  For
your DNS nameservers, you need to symlink /etc/resolv.conf to
`/run/systemd/network/resolv.conf`

	etc$ sudo ln -sf /var/run/systemd/resolve/resolv.conf

## Wireless

To do all the WPA authentication stuff:

	sudo systemctl enable wpa_supplicant@wlan0.service

You need to make sure `/etc/wpa_supplicant/wpa_supplicant-wlan0.conf` is in
place, as you can see in `/usr/lib/systemd/system/wpa_supplicant@.service`. I
prefer to link in `/etc/wpa_supplicant.conf` where I've also stored my wireless
passwords and things.

	/etc/wpa_supplicant$ sudo ln -s /etc/wpa_supplicant.conf wpa_supplicant-wlan0.conf

Now to get the IP address, we use **systemd-networkd**, with the configuration:

	$ cat /etc/systemd/network/wlan0.network
	[Match]
	Name=wlan0
	[Network]
	DHCP=yes

## Wrap up

systemd-analyze for
[wlan0](http://s.natalian.org/2014-03-18/wlan0-systemd-analyze.txt) is 3.203s
and [eth0](http://s.natalian.org/2014-03-18/eth0-systemd-analyze.txt) is 3.085s. I'm happy !

Currently I manually turn toggle wifi using my Thinkpad's wireless switch, for
switching between wired and wireless interfaces.

Update: [Guide for the Raspberry PI on Archlinux Arm (alarm)](http://archpi.dabase.com/#wireless)

Acknowledgements: [WonderWoofy on the the Archlinux
forums](https://bbs.archlinux.org/viewtopic.php?pid=1393759#p1393759)


What would be the solution, if there are two wireless interfaces wlan0 and wlan1? Should I use two configurations /etc/systemd/network/wlan0.network, /etc/systemd/network/wlan1.network, /etc/wpa_supplicant/etc/wpa_supplicant@wlan0.conf and /etc/wpa_supplicant@wlan1.conf and then also start two wpa_supplicant.services (wpa_supplicant@wlan0.service and wpa_supplicant@wlan0.service)? Or is it possible to handle two wireless interfaces with one configuration and one service?
