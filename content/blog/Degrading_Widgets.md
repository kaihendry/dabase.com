---
date: 2009-02-01 20:26:14 +0000
---

I've written before about [key Web features such as degrading
gracefully](http://natalian.org/archives/2008/09/16/3-reasons-why-the-web-platform-will-not-fragment-on-mobiles/)
and how that feature is going make the Web a winner on mobiles.

I could be wrong about this, because of widgets.

Widgets are downloaded onto your phone and quite possibly have nothing to do
with the original site you retrieved it from on the first place. You could have
obtained a widget via a friend or some other arbitrary channel.

So what's the problem? Firstly updating. When you launch the widget, will it be
up to date like the Web is? This is not guaranteed as widgets are designed to
work offline.

Next problem, [features or rather
APIs](http://dev.w3.org/2006/waf/widgets/#the-feature-element). New APIs like
that defined by Opera or BONDI (and later the W3C) are **volatile**. APIs will
change dramatically and they will not necessarily remain backwards
compatible.

The [Geolocation API](http://dev.w3.org/geo/api/) changed the position object
late 2008. Since it's still not a mature standard, things like this can happen.
To access the latitude value, changed from position.latitude to
position.coords.latitude. [Gears](http://gears.google.com/) in practice now,
implements both interfaces, which can confuse.


What happens when you have a widget that depends on 3 APIs (e.g. file, geo,
user interface for soft keys)? On a runtime where 1 of the APIs has been
updated? Think of the permutation explosion.

The nature of Javascript extensions and [asynchronous
APIs](http://dev.w3.org/geo/api/), make it very hard to degrade from situations
where even a single API may not be functioning as expected. Especially for Joe
Average "Cut n' Paste" Web developer.

Javascript engines typically halt in any case of an uncaught exception. A very
undesirable user experience!

Besides APIs, the [new security
mechanisms](http://www.w3.org/TR/widgets-digsig/) for widgets will also be very
likely to be volatile and unstable.

Therefore it will be likely that widgets (at least at first) will be tested and
pinned to a particular **static** snapshot of a widget runtime. As Web
developers might simply too lazy to keep up to date.

One solution is that widget runtimes _must_ make every effort possible to keep
a widget [up to date](http://dev.w3.org/2006/waf/widgets/#the-update-element).
Likewise the widget runtime also must be up to date. This is problematic as
software updates on mobile platforms have a long history of being ineffective.

Some people might argue that widgets do not have a fixed origin. I would like
to argue that someone needs to take responsibility of maintaining a widget on a
mobile device.

Perhaps the end user can delegate the maintainership of the widgets on the
device. For example in Debian I could switch my `sources.list` from unstable to
stable since I want to use more stable software.

The bottom line is that widgets must be maintained and updated with every
advance of the Widget Run Time (WRT).
