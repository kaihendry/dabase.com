---
date: 2009-02-01 20:27:51 +0000
title: "Fixed mobile layouts and page zoom: a 2009 opinion"
description: "An early iPhone-era argument for fixed layouts and browser zoom, preserved as a historical opinion rather than modern responsive-design guidance."
historical: "This short recommendation relies on 2009 mobile page-zoom behaviour. It is too dated and incomplete to serve as advice for designing a responsive site today."
noindex: true
---


For years I've promoted liquid, fluid, scalable Web designs.

Designs that use <a href="http://en.wikipedia.org/wiki/Em_(typography)">em</a>
instead of 12px in the style sheet. Those that used complicated floats, so that
when you resize the font the page still "looks good".

That's crap. I was wrong. Use fixed styles. Why? Because **page zooming** is
now the way good browsers scale a Web page. Safari on the iphone demonstrates
this really well.

Jeff Atwood argues well that browser should:

<blockquote cite="http://www.codinghorror.com/blog/archives/001212.html">
adopt full page zoom as the new default page sizing method
</blockquote>

And I whole heartedly agree.
