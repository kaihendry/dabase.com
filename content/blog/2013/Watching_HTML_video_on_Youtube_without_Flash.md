---
date: 2013-12-02 10:35:34 +0800
title: "An old YouTube workaround for HTML video without Flash"
description: "A preserved browser-console workaround for YouTube playback in 2013, using a watch_popup URL before HTML video became the normal path."
historical: "A 2013 workaround for Flash-era YouTube playback. The old URL trick is not current browser troubleshooting advice."
noindex: true
---

<img src=http://s.natalian.org/2013-12-02/youtube-flash-required.png>

Launch console, with `shift+ctrl+i` and copy and paste in:

	document.location.pathname = '/watch_popup';

Now HTML video playback should work, without Flash.

You can also make a Javascript bookmark: <http://s.natalian.org/2013-12-16/bookmark.png>

Credit: <https://twitter.com/rouadec/status/385068793673707520>
