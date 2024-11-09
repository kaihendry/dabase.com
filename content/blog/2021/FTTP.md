---
title: FTTP in Cornwall
date: 2021-01-05T20:32:47+08:00
description: Finally we have Fibre to the Premises aka FTTH
---

<iframe width="560" height="315" src="https://www.youtube.com/embed/gMPTtB3LUJ0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

We have the GEA-FTTP 80/20 product as [defined by BT
Openreach](https://www.openreach.co.uk/orpg/home/helpandsupport/sins/sins/downloads/SIN506v1p7.pdf):

* Downstream peak 80
* Downsteam Prioritised 30
* Upstream Prioritised 20

# iperf3 test to Linode

	pi@praze:~ $ iperf3 -R -c gb.webconverger.com
	Connecting to host gb.webconverger.com, port 5201
	Reverse mode, remote host gb.webconverger.com is sending
	[  5] local 81.187.180.146 port 56164 connected to 176.58.122.199 port 5201
	[ ID] Interval           Transfer     Bitrate
	[  5]   0.00-1.00   sec  5.92 MBytes  49.7 Mbits/sec
	[  5]   1.00-2.00   sec  8.46 MBytes  70.9 Mbits/sec
	[  5]   2.00-3.00   sec  8.78 MBytes  73.7 Mbits/sec
	[  5]   3.00-4.00   sec  8.73 MBytes  73.2 Mbits/sec
	[  5]   4.00-5.00   sec  8.79 MBytes  73.7 Mbits/sec
	[  5]   5.00-6.00   sec  8.79 MBytes  73.8 Mbits/sec
	[  5]   6.00-7.00   sec  8.72 MBytes  73.1 Mbits/sec
	[  5]   7.00-8.00   sec  8.80 MBytes  73.8 Mbits/sec
	[  5]   8.00-9.00   sec  8.79 MBytes  73.7 Mbits/sec
	[  5]   9.00-10.00  sec  8.51 MBytes  71.4 Mbits/sec
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bitrate         Retr
	[  5]   0.00-10.00  sec  85.4 MBytes  71.7 Mbits/sec  221             sender
	[  5]   0.00-10.00  sec  84.3 MBytes  70.7 Mbits/sec                  receiver

	iperf Done.
	pi@praze:~ $ iperf3 -c gb.webconverger.com
	Connecting to host gb.webconverger.com, port 5201
	[  5] local 81.187.180.146 port 56168 connected to 176.58.122.199 port 5201
	[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
	[  5]   0.00-1.00   sec  2.75 MBytes  23.1 Mbits/sec    0    168 KBytes
	[  5]   1.00-2.00   sec  2.59 MBytes  21.7 Mbits/sec    0    296 KBytes
	[  5]   2.00-3.00   sec  2.77 MBytes  23.2 Mbits/sec    0    423 KBytes
	[  5]   3.00-4.00   sec  2.97 MBytes  24.9 Mbits/sec    0    550 KBytes
	[  5]   4.00-5.00   sec  2.71 MBytes  22.7 Mbits/sec    0    676 KBytes
	[  5]   5.00-6.00   sec  2.60 MBytes  21.8 Mbits/sec    0    803 KBytes
	[  5]   6.00-7.00   sec  2.53 MBytes  21.3 Mbits/sec   33    403 KBytes
	[  5]   7.00-8.00   sec  2.14 MBytes  18.0 Mbits/sec    0    440 KBytes
	[  5]   8.00-9.00   sec  2.84 MBytes  23.9 Mbits/sec    0    465 KBytes
	[  5]   9.00-10.00  sec  2.13 MBytes  17.9 Mbits/sec    0    479 KBytes
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bitrate         Retr
	[  5]   0.00-10.00  sec  26.0 MBytes  21.8 Mbits/sec   33             sender
	[  5]   0.00-10.00  sec  25.2 MBytes  21.1 Mbits/sec                  receiver

	iperf Done.

# Ping times

You can see from a brief smokeping, it goes from an **unstable** ~35ms (FTTC) to a **stable** 12ms (FTTP) ping time for Google DNS:

<img src="https://s.natalian.org/2021-01-05/google-dns.png" alt="Google DNS Smoke ping FTTC vs FTTP">

To Singapore from the UK, the picture is the same, but with a higher latency due to the long distance:

<img src="https://s.natalian.org/2021-01-05/singapore.png" alt="UK to Singapore Smoke ping FTTC vs FTTP">

I have a long running [Smoke ping from Singapore to Praze Farm](https://smokeping.dabase.com/?target=Europe.UK.Praze) and it's looking **FANTASTIC** now that they are on Fibre:

<img src="https://s.natalian.org/2021-01-06/fttp-no-smoke.png" alt="FTTC to FTTP">

# Firebrick

<abbr title="Fibre to the Cabinet">FTTC</abbr>:

<img src="https://s.natalian.org/2021-01-05/old.png" alt="Unstable FTTC line">

With <abbr title="Fibre to the Premises">FTTP</abbr>, notice the scale goes to 100M:

<img src="https://s.natalian.org/2021-01-06/firebrick-fttp.png" alt="Stable FTTP line">

# Sync rate

https://speed.prazefarm.co.uk/

For some reason A&A's https://chaos2.aa.net.uk/broadband/info API is reporting the sync rate of FTTC:

	download(tx)=11361000 upload(rx)=752000

Our new FTTP line rate is:

	download(tx)=79575200 upload(rx)=20000000

Which is 7x better for download and about 26 times better for upload!

# Monthy cost

<abbr title="Fibre to the Cabinet">FTTC</abbr>:

* Line rental 12GBP
* Home:1 35GBP
* Home:1 Addon for VDSL 10GBP

So 57GBP for 2TB bandwidth with a very unstable line.

<abbr title="Fibre to the Premises">FTTP</abbr>:

* Home::1 Broadband, 2TB usage allowance 35GBP
* Home::1 Add-On: Fibre to the premises Non Transition Line 15GBP

Rural fibre is costing us 50GBP for monthly, a saving of 7GBP per month if you
ignore the [4600GBP](https://natalian.org/2019/10/19/Community_Fibre/) spent on
the upgrade!
