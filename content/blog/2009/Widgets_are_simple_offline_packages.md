---
date: 2009-02-12 09:59:40 +0000
---

# What are widgets?

Time and time again, I hear people ask: "What are widgets?"

I think there is a lot of confusion in the industry from what I heard last
Tuesday at [Mobile Monday
London](http://mobilemonday.org.uk/2009/01/february-2nd-event-changing-landscape.html).

So let's start from the beginning. Remember File->**Save Page as**?

Notice how Firefox saves a "webpage.html" with the webpage_files/ directory and
perhaps a style sheet? Notice how Opera saves a Web page as a single [mime
html](http://en.wikipedia.org/wiki/MHTML)?  Notice how Internet Explorer does
this again differently?

So you've written a Web page or perhaps really it's an "office document"
written with open proven Web standards instead of that ghastly [proprietary
Word
XML](http://natalian.org/archives/2006/06/30/office-document-compatibility/).
How do you store that file and share that document interoperably from a USB
stick with all your work colleagues? Everyone in your organisation has a Web
browser, but how do you package it all up? You need a standard dude!

# Zippity-do-dah

Ok, you could 'get by' with a zip file. "Send me that zip file with document,
style sheet and the images!" Fine. Zips are great, though can browsers handle
them consistently?

Guys, widgets actually are simply **zip files**. You just need that
[config.xml](http://dev.w3.org/2006/waf/widgets/#configuration-document).
Widgets first and foremost are a [packaging
format](http://dev.w3.org/2006/waf/widgets/). You've probably created hundreds
of widgets already, except they are called _Zip files_.

Now with [widgets under the W3C family of
standards](http://www.w3.org/TR/widgets/), this will drive browsers to support
zip files, oh sorry... I mean widgets natively. Super convenient!

# HEY! HTML5 has offline support so we don't need no stinkin' widgets

HTML5 defines how [offline Web
applications](http://www.whatwg.org/specs/web-apps/current-work/multipage/offline.html#offline)
work! [Gears had a stab at implementing
this](http://code.google.com/apis/gears/sample.html) and the lastest Iphone
firmware does [client-side database
storage](http://webkit.org/blog/126/webkit-does-html5-client-side-database-storage/).
I don't need a widget!

So why aren't we using HTML5? HTML5 offline technology features the
[Application
cache](http://www.whatwg.org/specs/web-apps/current-work/multipage/offline.html#appcache),
defines a 'logical package' with a **manifest**. It's actually a great feature
to give Web developers extra control of how browsers cache resources.

However one could argue this new feature:

* might be tricky for some browers to implement (whilst it's easy to slap on Zip support to PocketIE)
* difficult to implement for Web developers since it's new

Compare this to zipping up a Web page of your bus schedule. BOOM! You have an
"offline Web application 1.0" (aka the W3C Widget). Was that hard? No. Will
widgets be the end all of offline Web applications? Certainly not. Though they
fill a gap.

A gap that will exist as long as people do not have the latest software and
aren't inherently connected. That I'm afraid might be a few years.

Well Google will push this as they need a way of slipping you advertisements.
:-)

# WTF happened to my killer widget application then?

Ok, ok, you're thinking what happened to the idea of a widget finding out your
[Geolocation](http://geo.webvm.net/) and then vibrating? You know, using all
these [BONDI device APIs](http://bondi.omtp.org/1.0/)! Widgets are awesome!

Ok let me let you onto a dirty little secret: **The Web's security model is
completely broken**. The reason why all these APIs have not made it onto the
Web so far, is because of the security nightmare that would ensue.

Though we must have these APIs. **How** can we introduce them safely, define
them and then hopefully get them into the Web sanely? And when there is a will
there is a way. That's widgets for you.

Widgets are self-contained little balls of the Web. We can [secure widgets by
signing](http://dev.w3.org/2006/waf/widgets-digsig/) and associating an access
control policy for them. If something goes wrong with the policy, we can pull
the plug and revoke the signature. Great, now we have a basis for a security
model. Rock on!

Once we know how these API control policies work with widgets, the big idea is
that we can bring this "trialled by fire" technologies to Web applications via
[W3C participation](http://www.w3.org/2008/webapps/). So
[BONDI](http://bondi.omtp.org/) is not just about widget APIs, they are looking
to the future with [Web applications](http://whatwg.org/html5).

So for the early adopters, yes you can write widgets using volatile [mobile device
APIs](http://bondi.omtp.org/1.0/) right now, to get
[Geolocation](http://dev.w3.org/geo/api/), your
[addressbook](http://bondi.omtp.org/1.0/apis/contact.html),
[battery
information](http://bondi.omtp.org/1.0/apis/devicestatus.html),
[file
access](http://bondi.omtp.org/1.0/apis/filesystem.html)
and much more!

# So my widget is a Web application! (or not)

Widget applications aren't exactly Web applications. They aren't reliant on the
back ends like Apache & PHP. Widgets are **not inherently connected**. They
probably [[will_not_update_and_degrade|blog/Degrading_Widgets]] seamlessly like
Web applications do at first. Those new [device
APIs](http://bondi.omtp.org/apis/) aren't mature. And ... what happens if
widgets are just [SVG](http://en.wikipedia.org/wiki/SVG) files or [canvas
elements](http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html)?
DUDE that isn't the Web is it?  Or is it?

Thinking of widgets as applications is hard. We are feeling our way here, to
the connected Web application platform (HTML5) several years down the line.  So
let's keep our expectations in check.

Widgets will be useful and they won't neccessarily be doing anything new &
**connected** at first. Though widgets will make sharing content offline a
whole lot easier.

So when you are on the
[Underground](http://en.wikipedia.org/wiki/London_underground) and you want to
share some funny cat pictures, you can now transfer that content as a widget.
Simple.

Get it?

# Ok, fine... then can I have a widget of a book please?

Hey! That's more like it! You understand! Here is a real example of how a zip
file of a book from [Project Gutenberg](http://www.gutenberg.org) is turned
into a widget with shell:

	#!/bin/sh -e
	[ $1 ]
	wget http://www.gutenberg.org/files/$1/$1-h.zip
	unzip $1-h.zip
	rm -f $1-h.zip
	cd $1-h

[index.html is the default start file](http://dev.w3.org/2006/waf/widgets/#start-file-and-default-start-files).

	mv $1-h.htm index.html
	echo '<widget xmlns="http://www.w3.org/ns/widgets"></widget>' > config.xml

The [content must be at the root of the folder](http://dev.w3.org/2006/waf/widgets/#root-of-the-widget).

	zip -D -r ../$1.wgt *
	cd ..
	rm -rf $1-h

Or you could just use the [widget books](http://gwgt.webvm.net/) interface I
cooked up to **save** Gutenberg books as a widget. With that book/widget on
your device, you can read offline and share the widget with a friend who can't
afford a pricey mobile Internet plan. Cool eh?

Remember **widgets are just a simple offline encapsulation format** to begin
with. Backup your files to a widget. Share a widget. Authenticate & trust a
widget. Buy a widget. There are new opportunities, you just need to see them
for what they are.

# Update -- Widgets as a serialisation format for HTML Appcache?

Hopefully widgets will adopt the [cache
manifest](http://www.whatwg.org/specs/web-apps/current-work/multipage/offline.html#manifests)
as a mechanism for updating.

So what does this mean? Imagine you had an HTML5 application installed on your
mobile. It could be a simple [todo list](http://static.webvm.net/appcache/)
that you want to pass on to your partner or perhaps deploy to zillions of
devices.

The Appcached application could be exported into a Widget (a Zip file) and then
bluetoothed or deployed into a ~/widgets directory. When the destination device
boots the browser, the browser will have the application (and its information
contents) readily availble without connecting to the Internet!
