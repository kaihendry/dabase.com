---
date: 2009-06-08 23:14:23 +0100
---

After setting up [CUPS-PDF](http://webconverger.org/printing/) for testing
[Webconverger](http://webconverger.com/), I realised I could print from various
browsers and compare their postscript output.

Once I had the PDF, I converted them to PNG and uploaded them to a [Web browser print out shootout set](http://www.flickr.com/photos/hendry/sets/72157619373242517/).

	for i in *.pdf; do convert $i $(basename $i .pdf).png; done

And the winner is ?

I really expected it to be [PrinceXML](http://princexml.com/) which is not
really a Web browser. PrinceXML actually a piece of software designed to make a
Web page look great on paper.

<a href="http://www.flickr.com/photos/hendry/3608976992/" title="Prince 6.0r8-0 by Kai Hendry, on Flickr"><img src="http://farm3.static.flickr.com/2432/3608976992_f331d3ec4a_o.png" width="612" height="792" alt="Prince 6.0r8-0" /></a>

But in truth, I though it did a bad job keeping everything on one page and of the first input field.

I was particularly impressed by Apple's Safari 3.2.1's output:

<a href="http://www.flickr.com/photos/hendry/3608977000/" title="Safari 3.2.1 by Kai Hendry, on Flickr"><img src="http://farm4.static.flickr.com/3376/3608977000_3384b376ff_o.png" width="595" height="842" alt="Safari 3.2.1" /></a>

I think I might have unfairly screwed up printing to my CUPS server from WinXP.
I used [Adobe's postscript
driver](http://www.adobe.com/support/downloads/detail.jsp?ftpID=1500) btw.
Hence the black and white versions from:

* [Internet Explorer 8](http://www.flickr.com/photos/hendry/3608976972/in/set-72157619373242517/)
* [Chromium 1.0](http://www.flickr.com/photos/hendry/3608976966/in/set-72157619373242517/)

Look a bit lack lustre.

Next I should probably use a test that uses [CSS print profile](http://www.w3.org/TR/css-print/). Here I expect <http://www.princexml.com> to really hardcopy some ass.
