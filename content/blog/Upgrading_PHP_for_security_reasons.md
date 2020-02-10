---
date: 2015-09-02 10:52:39 +0800
---

I like to talk at [local Singaporean tech meetups](http://www.webuild.sg/) to
challenge myself. When I talk vehemently about certain topics, don't think I
actually believe in what I say. I'm overstating on purpose in order to attract
debate. I am trying to convince myself as much as you.

Case in point with a [talk I gave at the SG PHP meetup
group](https://www.youtube.com/watch?v=IaLGFfudx5k), based on my troubled
[[Evergreen_PHP]] post with the [slides by Go
Present](http://talks.webconverger.com/2015-08-27/) that I never figured out
how to fullscreen.

An audience member said, __I'm running PHP 5.4 and why should I update?__

I retorted with "security reasons" and I made a bad anology with browser
updates. Truth is, browsers actually get better over time and I'm not sure PHP
does. As for "security reasons"... well .. we all should know by now, "security reasons" is a **bullshit answer**.

AFAIK there aren't remote PHP vulnerabilites in reality. In my mind there are two types of PHP security problems:

1. Problems in your script, which no PHP security updates will address. You need to fix your script!
2. Problems where running a script can compromise the host. Moot point if people run PHP in a single user (just you!) environment.

When I look through [PHP
CVEs](https://www.cvedetails.com/vulnerability-list/vendor_id-74/product_id-128/PHP-PHP.html)
I see type 2 bugs. These bugs are a problem when an attacker runs a script on
your machine to **compromise** it. What's the chance of that when people do not
use shared hosting anymore? It should be ZERO.

Furthermore you should run PHP in a container, like [I do with
greptweet](https://github.com/kaihendry/greptweet/blob/master/Dockerfile).
There really should be zero chance a compromised container can disrupt the
host.

Together the security risks of an non-updated PHP should be very low! So
"security reasons" for an PHP update is a stupid thing to say because the risks
are so low.

Expanding on the surface area... since PHP is typically deployed with Linux,
Mysql & Apache... when was the last remote vulnerability affecting these
stacks?  It basically does not happen.

# Lets move forward

So now I'm thinking a minimal, hardened, frozen environment with PHP 5.4 is actually what
I want to deploy my production apps upon. Which distro or Docker image does
this?  [Debian at the time of writing ships 5.6.7 as
stable](https://packages.qa.debian.org/p/php5.html)!
