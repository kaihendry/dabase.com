---
date: 2010-12-05 16:56:01 +0000
---

Packaging has interested
[me](http://qa.debian.org/developer.php?login=hendry@iki.fi) for awhile and of
late I prefer the [simple arch
packaging](http://aur.archlinux.org/packages/dwm-hg/dwm-hg/PKGBUILD) where you
just clone from a [hg URL](http://hg.suckless.org/) that's importantly
browsable from the Web.

Since I work with
[widgets](http://dabase.com/blog/Widgets_are_simple_offline_packages/), I'm
often left thinking about how they compare to "the mature Debian way" of doing things.

# The kill switch

This seems to be an Operator requirement, since
[Android](http://www.theregister.co.uk/2008/10/16/android_kill_switch/) and the
Itunes App store I believe implements one.

On Debian and all other Linux distributions security is largely the
responsibility of the user. That is to rarely **manually remove** or rather
**upgrade** the package in question. It most cases an "evil" or dangerous
package is detected by its maintainer or during the unstable->testing->stable
transition by intrepid users, hence most removals happen in "unstable" and
extremely rarely in "stable". Security incidents are described in [security
advisories](http://debian.org/security/#DSAS), which in turn are usually linked
to a industry standard [CVE identifier](http://cve.mitre.org/). However if a
"stable" sysadmin fails to read and act upon a  **removal** security advisory,
there could be trouble ahead.

I personally like the upgrade approach as that's very much in line of how the
Web works. You update your way out of trouble, and that works for all parties.

Forced removal or disabling of an app (aka the kill switch) is a very
disruptive experience.  What happens if a user relies on that particular "bad"
app to get his or her job done? There is [no upgrade
path](http://wiki.debian.org/ftpmaster_Removals) for users.

# Comparing the update process

Updates are a pain point. On Debian for example, they are done rather network
inefficiently, as you need to download the entire package even though there
might be a one line of change.

On mobiles, this problem worsens as network capacity is tightly limited and
complex, where [OTA push
updates](http://en.wikipedia.org/wiki/Over-the-air_programming) are (I'm not
sure why) favoured.  Furthermore Operators typically demand to test each update
before deployment, making the process rather cumbersome and dangerously slow.

I personally think the manual upgrade path with efficient [binary
diffing](http://blog.chromium.org/2009/07/smaller-is-faster-and-safer-too.html)
is the way forward, much like the Web works.

# And who does the updates ?

If a security issue is found on Debian, the [security
team](http://debian.org/security/#contact) or package maintainer usually assume
responsibility for fixing the problem as **quickly as possible**.

In the WAC widget, Android & Apple App store world, the emphasis is squarely on
the author to fix the problem or be banned/removed/killed. I would argue this
is bad for users and the ecosystem at large, since continuity and stability is
put at risk.

Of course it is more complicated than that. Add the whacky shrinkwrap &
"freemium" business models and you generally put blame squarely on the original
author. But can you? The picture is really muddled when intermediaries like
Apple and alike who take a revenue share and conduct testing.

Do you think a intermediary has a right to change a product (violate "artistic"
integrity) on its way to the end consumer? I'll leave you to think about what
happens in the real marketplace when you next go shopping.
