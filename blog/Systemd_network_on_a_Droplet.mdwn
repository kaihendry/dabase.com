From roughly systemd version 210, networking in my Droplet changed.

Out went netctl somehow (good riddance), and my network connectivity (uh oh).

Using Digital Ocean's buggy Console Access, I managed to setup my network access
manually.

`/etc/network.d/ethernet-static` gave me the previous network settings:

	[root@sgd ~]# cat /etc/network.d/ethernet-static
	CONNECTION='ethernet'
	INTERFACE='eth0'
	IP='static'
	ADDR='128.199.252.174'
	NETMASK='255.255.192.0'
	GATEWAY='128.199.192.1'
	DNS=('8.8.4.4' '8.8.8.8' '209.244.0.3')

## How to setup a networking interface with ip

I'm more familiar with `ifconfig` & `route`, but with some frantic Googling I
did figure out `ip`'s odd unfamilar API:

	ip addr add 128.199.252.174/255.255.192.0 dev enp0s3
	ip route add default via 128.199.192.1

`ip a` then looks like:

	[root@sgd ~]# ip a
	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default
		link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
		inet 127.0.0.1/8 scope host lo
		inet6 ::1/128 scope host
		   valid_lft forever preferred_lft forever
	2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
		link/ether 04:01:11:8d:89:01 brd ff:ff:ff:ff:ff:ff
		inet 128.199.252.174/18 brd 128.199.255.255 scope global enp0s3
		inet6 fe80::601:11ff:fe8d:8901/64 scope link
		   valid_lft forever preferred_lft forever

Sidenote: I'm not sure why my Droplet's network interface is called `enp0s3` and not
something simple like `eth0`.

Ping to test... YES... I can ssh in. 

## Now to migrate to [systemd-networkd](https://wiki.archlinux.org/index.php/Network_configuration#systemd-networkd).

I created `/etc/systemd/network/enp0s3.network`:

	[root@sgd ~]# cat /etc/systemd/network/enp0s3.network
	# Migrated from /etc/network.d/ethernet-static
	# https://coreos.com/blog/intro-to-systemd-networkd/
	[Match]
	Name=enp0s3
	[Network]
	Address=128.199.252.174/18
	Gateway=128.199.192.1

1. To test `systemctl start systemd-networkd.service`.
* Check `systemctl status systemd-networkd.service` looks good

		[root@sgd ~]# systemctl status systemd-networkd.service
		systemd-networkd.service - Network Service
		   Loaded: loaded (/usr/lib/systemd/system/systemd-networkd.service; enabled)
		   Active: active (running) since Thu 2014-03-13 04:02:24 UTC; 11min ago
			 Docs: man:systemd-networkd.service(8)
		 Main PID: 158 (systemd-network)
		   Status: "Processing requests..."
		   CGroup: /system.slice/systemd-networkd.service
				   `-158 /usr/lib/systemd/systemd-networkd
		Mar 13 04:02:24 sgd systemd-networkd[158]: enp0s3: link is up
		Mar 13 04:02:24 sgd systemd-networkd[158]: enp0s3: carrier on
		Mar 13 04:02:24 sgd systemd-networkd[158]: enp0s3: link configured
		Mar 13 04:02:24 sgd systemd[1]: Started Network Service.

To watch/tail what the systemd-networkd.service is doing, `journalctl -u systemd-networkd.service -f`

* Enable it `systemctl enable systemd-networkd.service`
* And reboot!

## Loose ends, ifplugd

I noticed in `htop` ifplugd is running. I can't see from `systemctl` or `pstree` what invoked it. Mysterious.

	[root@sgd ~]# ps aux | grep ifplugd
	root       136  0.0  0.0   2200   284 ?        Ss   04:02   0:00 /usr/bin/ifplugd -i enp0p3 -r /etc/ifplugd/netcfg.action -fIns
	root     27388  0.0  0.1   2828   584 pts/1    S+   04:16   0:00 grep ifplugd
