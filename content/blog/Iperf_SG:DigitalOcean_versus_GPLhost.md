Since [Digital Ocean has opened a new SG datacenter](https://digitalocean.com/blog_posts/we-re-excited-to-announce-our-singapore-datacenter-sgp1), it's time to pit my existing SG VPS at [GPLhost](https://dtc.node6503.gplhost.com/dtc/affiliation.php?affiliate=kaihendry&return=/hosting-vps.html) against it!

From my Singtel connection at home, with `iperf -s` running on either VPS.

	x220:~$ iperf -c sg.hackandtell.org # GPLhost
	------------------------------------------------------------
	Client connecting to sg.hackandtell.org, TCP port 5001
	TCP window size: 22.9 KByte (default)
	------------------------------------------------------------
	[  3] local 192.168.88.249 port 46675 connected with 117.121.241.187 port 5001
	[ ID] Interval       Transfer     Bandwidth
	[  3]  0.0-10.2 sec  18.2 MBytes  15.0 Mbits/sec
	x220:~$ iperf -c sgo.webconverger.com # Digital Ocean's new SG VPS
	------------------------------------------------------------
	Client connecting to sgo.webconverger.com, TCP port 5001
	TCP window size: 22.9 KByte (default)
	------------------------------------------------------------
	[  3] local 192.168.88.249 port 52035 connected with 128.199.252.174 port 5001
	[ ID] Interval       Transfer     Bandwidth
	[  3]  0.0-10.3 sec  6.00 MBytes  4.89 Mbits/sec

**BAD SINGTEL ROUTING**: <a
href="https://en.wikipedia.org/wiki/MTR_(software)">mtr</a> shows the routing
from Singtel (SG's largest ISP IIUC) to Digital Ocean's SGP1 is poor. It seems
to go to Hong Kong and back and hence the pings are ~80ms, when they should be
~5ms!

I know GPLhost's [network
configuration](http://www.gplhost.com/gplhost-network-singapore.html) is
limited to just **50 Mbit/sec**. It's a shame I'm not getting close to it from
my OpenNET Singtel line at home. :(

Nonetheless GPLhost beats Digital Ocean on repeated `iperf` tests on average by
at least 2x from my Singapore connection.

# From a Digital Ocean droplet in the Netherlands

	[hendry@nl ~]$ iperf -c sgo.webconverger.com # Digital Ocean
	------------------------------------------------------------
	Client connecting to sgo.webconverger.com, TCP port 5001
	TCP window size: 22.9 KByte (default)
	------------------------------------------------------------
	[  3] local 146.185.152.215 port 45486 connected with 128.199.252.174 port 5001
	[ ID] Interval       Transfer     Bandwidth
	[  3]  0.0-10.1 sec  6.38 MBytes  5.30 Mbits/sec
	[hendry@nl ~]$ iperf -c sg.hackandtell.org # GPLhost
	------------------------------------------------------------
	Client connecting to sg.hackandtell.org, TCP port 5001
	TCP window size: 22.9 KByte (default)
	------------------------------------------------------------
	[  3] local 146.185.152.215 port 60435 connected with 117.121.241.187 port 5001
	[ ID] Interval       Transfer     Bandwidth
	[  3]  0.0-11.1 sec  1.50 MBytes  1.13 Mbits/sec

Digital Ocean's international peering seems a lot better. The results above are indicative.

# From Linode in the UK

	hendry@gb ~$ iperf -c sgo.webconverger.com # To the SG Digital Ocean droplet
	------------------------------------------------------------
	Client connecting to sgo.webconverger.com, TCP port 5001
	TCP window size: 20.0 KByte (default)
	------------------------------------------------------------
	[  3] local 176.58.122.199 port 36559 connected with 128.199.252.174 port 5001
	[ ID] Interval       Transfer     Bandwidth
	[  3]  0.0-10.1 sec  46.2 MBytes  38.4 Mbits/sec
	hendry@gb ~$ iperf -c sg.hackandtell.org # To my GPLhost VPS in SG M1 datacentre
	------------------------------------------------------------
	Client connecting to sg.hackandtell.org, TCP port 5001
	TCP window size: 20.0 KByte (default)
	------------------------------------------------------------
	[  3] local 176.58.122.199 port 33729 connected with 117.121.241.187 port 5001
	[ ID] Interval       Transfer     Bandwidth
	[  3]  0.0-11.2 sec  2.12 MBytes  1.60 Mbits/sec

Digital Ocean's **international bandwidth** definitely seems a lot better!

Webconverger's VPS are documented upon <http://webconverger.org/servers/>.

# From a Microsoft Azure VPS to either SG VPS

	hendry@hackerspacesg:~$ iperf -d -c sgo.webconverger.com
	WARNING: option -d is not valid for server mode
	------------------------------------------------------------
	Client connecting to sgo.webconverger.com, TCP port 5001
	TCP window size: 22.9 KByte (default)
	------------------------------------------------------------
	[  3] local 10.146.222.93 port 53883 connected with 128.199.252.174 port 5001
	[ ID] Interval       Transfer     Bandwidth
	[  3]  0.0-10.0 sec   572 MBytes   480 Mbits/sec

480Mbit/sec from Microsoft to Digital Ocean... NICE! Still that is IIUC less
than half a Gigabit connection.

	hendry@hackerspacesg:~$ iperf -d -c sg.hackandtell.org
	WARNING: option -d is not valid for server mode
	------------------------------------------------------------
	Client connecting to sg.hackandtell.org, TCP port 5001
	TCP window size: 22.9 KByte (default)
	------------------------------------------------------------
	[  3] local 10.146.222.93 port 40515 connected with 117.121.241.187 port 5001
	[ ID] Interval       Transfer     Bandwidth
	[  3]  0.0-10.0 sec  55.2 MBytes  46.2 Mbits/sec

Ok, here GPLhost's 50Mbit/s limit is plain to see.

# Conclusion

Digital Ocean's SG droplet internal connectivity to Singapore is a little
worrying. A
[traceroute](http://s.natalian.org/2014-02-14/1392356590_1364x742.png)
indicates traffic is going upto Hong Kong!

I need someone on a 1Gbps line to do some `iperf` testing. Any [My Republic
users reading this](https://secure.myrepublic.com.sg/pricing.php)?

I'm going to continue with GPLhost till at least to the end of May and I guess
I will make a decision whether to migrate or not long before then. GPLhost are
a small outfit, though they have provided really good service over the period
I've used them. <abbr title="Digital Ocean">DO</abbr> on the hand seems a bit
unpredictable. It took them two days to sort out a networking glitch in
Archlinux images made available in Singapore. <abbr title="Digital
Ocean">DO</abbr> could easily be a victim of their own success.

Update: A network engineer from <abbr title="Digital Ocean">DO</abbr> got in
touch to say they working to improve local peering. I guess a follow up test from me will be in order...(!)

Update: Outage today <http://www.digitaloceanstatus.com/history?update=206#95> and still the routing from Singtel to SGP1 is poor <http://ix.io/aWZ> after a month. :/

Update: 4 months later, still bad: <http://r2d2.webconverger.org/2014-05-18/mtr-sgo.webconverger.com.html>
