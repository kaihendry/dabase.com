---
date: 2012-12-27 13:34:40 +0800
---

If you have your own Debian based
[VPS](http://en.wikipedia.org/wiki/Virtual_private_server) on the Internet, you
might want to install a
[VPN](http://en.wikipedia.org/wiki/Virtual_private_network) service just in
case.

I've gone for the PoPToP Point to Point Tunneling Server, since it seems
supported by IOS6. I don't have experience of L2TP or IPSec. I'm keen on the
fastest and simplest solution.

On your VPS:

	sudo apt-get install pptpd

Configure a login in `/etc/ppp/chap-secrets`. I used this as a [guide](http://www.howtogeek.com/51237/setting-up-a-vpn-pptp-server-on-debian/).

Using rsyslog and `tail -f /var/log/syslog`, when I connect from my iPhone5, I see:

	Dec 27 05:46:44 uk pptpd[14292]: CTRL: Starting call (launching pppd, opening GRE)
	Dec 27 05:46:44 uk pppd[14293]: Plugin /usr/lib/pptpd/pptpd-logwtmp.so loaded.
	Dec 27 05:46:44 uk pppd[14293]: pppd 2.4.5 started by root, uid 0
	Dec 27 05:46:44 uk pppd[14293]: Using interface ppp0
	Dec 27 05:46:44 uk pppd[14293]: Connect: ppp0 <--> /dev/pts/3
	Dec 27 05:46:44 uk pptpd[14292]: GRE: Bad checksum from pppd.
	Dec 27 05:46:48 uk pppd[14293]: peer from calling number 175.139.36.248 authorized
	Dec 27 05:46:49 uk pppd[14293]: MPPE 128-bit stateless compression enabled
	Dec 27 05:46:49 uk pppd[14293]: Cannot determine ethernet address for proxy ARP
	Dec 27 05:46:49 uk pppd[14293]: local  IP address 192.168.0.1
	Dec 27 05:46:49 uk pppd[14293]: remote IP address 192.168.1.1

I didn't change any values like `localip` or `remoteip` in `/etc/pptpd.conf`,
instead relying on a
[NAT](http://en.wikipedia.org/wiki/Network_address_translation) and (hopefully
working) defaults.

<a href="http://www.flickr.com/photos/hendry/8313643288/" title="PPTP setup in IOS6 by Kai Hendry, on Flickr"><img src="http://farm9.staticflickr.com/8496/8313643288_0eae972719.jpg" width="282" height="500" alt="PPTP setup in IOS6"></a>

Once connected from the Iphone I saw:

	$ /sbin/ifconfig  ppp0
	ppp0      Link encap:Point-to-Point Protocol  
			  inet addr:192.168.0.1  P-t-P:192.168.1.1  Mask:255.255.255.255
			  UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1496  Metric:1
			  RX packets:6688 errors:0 dropped:0 overruns:0 frame:0
			  TX packets:8514 errors:0 dropped:0 overruns:0 carrier:0
			  collisions:0 txqueuelen:3 
			  RX bytes:1172538 (1.1 MiB)  TX bytes:10880037 (10.3 MiB)

<a href="http://www.flickr.com/photos/hendry/8313643006/" title="Should be the same on ppp0 by Kai Hendry, on Flickr"><img src="http://farm9.staticflickr.com/8079/8313643006_e4d762110f.jpg" width="282" height="500" alt="Should be the same on ppp0"></a>

Setup DNS:

	$ grep ^ms-dns /etc/ppp/pptpd-options
	ms-dns 8.8.8.8
	ms-dns 8.8.4.4

Ensure forwarding is enabled:

	$ grep forward  /etc/sysctl.conf
	net.ipv4.ip_forward=1
	net.ipv6.conf.all.forwarding=1
	$ cat /proc/sys/net/ipv4/ip_forward
	1

iptables:

	# iptables -F FORWARD
	# iptables -A FORWARD -j ACCEPT
	# iptables -A POSTROUTING -t nat -o eth0 -j MASQUERADE

I found the IPv6 Toolkit app on IOS6 useful for debugging on the iPhone.
