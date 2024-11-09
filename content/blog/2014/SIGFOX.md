---
date: 2014-08-06 22:07:01 +0800
---

<video controls width=640 height=360>
<source src=http://r2d2.webconverger.org/2014-08-06/sigfox-impressions.mp4 type=video/mp4>
</video>

I attended an event at Hackerspace.SG [Running your IoT devices on a low power,
long range network](https://www.facebook.com/events/1512203065680395/), which
showcased [Lee Lup's slides on SIGFOX at
Singtel](https://docs.google.com/file/d/0B_0snazaPutfQnRrLVNiaGp0ajA/).

My thoughts are that the 12 byte payload is not really suitable for monitoring, but more for **events**.

* Door closed
* Bin's full
* Some significant threshold exceeded

It's not super good for monitoring since:

* payload is too small
* there is no accurate time
* you can't monitor any less than 10 minute intervals

I found the people tracking / GPS use cases to be silly, since GPS needs a lot of power.

SIGFOX lends itself to well known **fixed locations**.

**Fixed locations**, such as public property that need maintenance and don't
have Internet connectivity for one reason or another.

I'm thinking:

* alerting to street lamps failing
* alerting to flooding
* alerting to when a bin is full & needs emptying
* alerting when a special door/gate is opened

I like how the SIGFOX station seems to send out Github style
[Webhook](https://developer.github.com/webhooks/) payloads to a payload URL.
