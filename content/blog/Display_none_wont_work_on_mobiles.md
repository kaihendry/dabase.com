For years I have argued incorrectly that mobile browsers should not download images when something like:

	img { display: none; }

Appears in the @handheld [mobile style sheet](http://www.bushidodesigns.net/blog/mobile-device-detection-css-without-user-agent/).

I am wrong because:

* You cannot assume the CSS to be downloaded, parsed and layout understood before images are started to be downloaded
* DHTML and other AJAXy special effects relies on display none to download the images in the background


[Kam](http://exploding-planet.com/) demonstrates the problem on IRC like so:

	14:47 <Kam> well what about a huge page full of images (ads, page chrome and such), how do you decide what you should load and what isnt worth bothering?
	14:47 <Kam> if I looked at a news article I just want the picture associated with that article
	14:47 <Kam> but you load all sorts of other crap aswell
	14:48 <Kam> images set to display:none are the least of your problems surely

I guess it's one of those cases where the browser (the UA) has to become quite smart (innovate) about what it needs to download.

Innovations could be, like the Opera Mini servers that transcode websites from
HTML to OBML (Opera Binary Markup Language), which is a propertiary compressed
format.

I don't think the innovation lies with [Content
Transformation](http://www.w3.org/TR/ct-landscape/). Technologies which fuck
with HTTP posts and SSL and basically technlogies that do not tightly tie into
browser logic are doomed to fail.

I personally would like to see a switch on my UA like a volume button that I
could use to increase communication efficiency. For example if I knew I was in
a noisy environment, I could manually set my browser to agressively make the
connection more efficient.  I.e. removing images and possibly not downloading
JS or something like that. Typically mobile browsers have the option to turn
off image downloading buried within a couple of menus, making it impossible to
reasonably toggle.
