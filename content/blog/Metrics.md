---
date: 2013-01-19 22:20:55 +0800
---

# Background

I'm too embarrassed to write this "statistics architecture" up on the
[Webconverger blog](http://r2d2.webconverger.org/2013-01-19/gnuplot-zoom.html)
and this is too technical for [Natalian](http://natalian.org/).

After messing around with [Anselm's monitor rc
scripts](https://github.com/kaihendry/monitor), [fiddling with
GNUplot](https://github.com/kaihendry/laptemp), looking into
[statsd](https://github.com/etsy/statsd) and
[graphite](https://launchpad.net/graphite) (v. scary) and watching [metrics
everywhere](http://pivotallabs.com/139-metrics-metrics-everywhere/)... I have a LOT to think about.

* https://www.icinga.org sucks
* munin sucks
* nagios sucks

Of course I want to apply the [suckless
philosophy](http://suckless.org/philosophy) and cut through the crap.

# Measure what?

I started with this faux problem of measuring my machine temperature, since
this is related to Webconverger deployments, that require monitoring.
Monitoring translates to business value, since this is what clients are
prepared to pay for.

My "suckless" approach is to generate time series CSV rooted on epoch time.

	*/5 * * * * echo $(date +%s) $(cat /proc/temp) | ssh server 'cat - >> /data/${id:-$SSH_CLIENT}/temp/$(date +%j).csv'

Over a ssh socket. Then on the server we either run GNUplot over the CSV or
[churn it in JSON](https://github.com/Webconverger/dl/blob/master/toJSON.sh)
and write put the data into a [time series
graph](http://dl.webconverger.com/stats/).

The problem with quirky GNUplot is that the Web output of a PNG or SVG can be
[difficult to
explore](http://r2d2.webconverger.org/2013-01-19/gnuplot-zoom.html) or interact
with. However it's powerful, fast and plays well with shell.

Then again the JSON frontend is easier to write and interact with, but it can
become pretty darn cumbersome.

This approach makes a number of assumptions about ssh and the frequency and
such and so forth. And it lacks monitoring **alerts**. I'm not quite sure how
to do that yet. Perhaps extra logic on the server, that filters new data and if
something goes wrong, it sends an alert. My preference would probably be an
email.

Please see <https://github.com/kaihendry/sg> for an implementation!
