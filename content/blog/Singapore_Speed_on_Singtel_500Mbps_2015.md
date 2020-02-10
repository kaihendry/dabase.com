I was curious to know if there was a real difference between the **Network Performance** between AWS ap-southeast-1a m3.xlarge (52.74.16.160) and a ap-southeast-1a t2.micro (52.74.13.219).

I configured both instances as 64bit Ubuntu since that has the `iperf` package readily available and on my wired X220 laptop I ran several iperf tests.

Here are some abbreviated typical results:

	wired-to-singtel_FG7003GRV$ for i in 52.74.16.160 52.74.13.219 sgo.webconverger.com sg.webconverger.com; do iperf -c $i; sleep 1; done
	[  3]  0.0-10.0 sec   648 MBytes   543 Mbits/sec
	[  3]  0.0-10.0 sec   601 MBytes   504 Mbits/sec
	[  3]  0.0-10.0 sec  64.8 MBytes  54.2 Mbits/sec
	[  3]  0.0-10.1 sec  39.2 MBytes  32.5 Mbits/sec

Full log: <http://ix.io/gLP>

sgo.webconverger.com is the cheapest Singaporean Digital Ocean droplet (sgp1)
and sg.webconverger.com is a Singapore based
[GPLHost](http://www.gplhost.com/gplhost-network-singapore.html) instance. Have
a look at <https://webconverger.org/servers> for details.

# My conclusions

There is no difference in **Network Performance** between the _high_ of
m3.xlarge and _low to medium_ of t2.micro at 500Mbps.

Singtel's 500Mbps is actually 500Mbps... in one test it even went as high as
542Mbps. &#128079;

Digital Ocean and GPLHost seem limited to 100Mbps and 50Mbps respectively.
Though it's highly variable. Suck!

Sidenote: Somewhat depressingly, since my landlord doesn't allow me to run
cables to the router, I typically get just 70 Mbits/sec using [Wireless
AC](http://en.wikipedia.org/wiki/IEEE_802.11ac) and my Rpi2 with a USB
Wireless-N can only seem to achieve 13 Mbits/sec... i.e. my own internal "final
10m" is underperforming!
