---
date: 2015-09-06 10:34:09 +0800
---

<blockquote cite="http://lwn.net/Articles/658198/">As a result, we can, unfortunately, expect to continue to be subjected to surveillance and criminal behavior from the devices that we think we own. We can't say we weren't warned.
<cite><a href="http://lwn.net/Articles/658198/">Jonathan Corbet</a></cite>
</blockquote>

<iframe width="560" height="315" src="https://www.youtube.com/embed/6G1iGSypZGk" frameborder="0" allowfullscreen></iframe>

NOT RECOMMENDED: Requires a [plugin to be installed](http://s.natalian.org/2015-09-13/plugins-foscam-c1.png) in order to edit settings in their Web interface

<img alt="C1 image" src=http://s.natalian.org/2015-09-06/c1.jpg>

I've bought 3 Foscam C1s. One in the UK for 53.97GBP and two in Singapore for
100SGD each a few months later. Btw I've now noticed a new [C2 on the
market](http://foscam.us/foscam-c2-white-indoor-hd-1080p-wireless-p2p-ip-camera.html),
which offers 1080p over C1's 720p.

Before Foscam was recommended to me, I only had experience with the
[Y-cam](http://www.y-cam.com/) brand of IP cameras after
[@edent](https://twitter.com/edent) recommended them to me and Raspberry PI
cameras.

# Annoyances

Hostname is blank on my ZNID24xxA-Router's DHCP Leases.

Doesn't show up on `avahi-browse -alr`. Can someone PLEASE EXPLAIN what is this P2P address and how can I peer or at least discover it?!

<img alt="foscam P2P address" src=http://s.natalian.org/2015-09-06/foscam-p2p.jpg>

To my surprise almost, the Webcam doesn't seem to setup UPnP Port Forwarding
Rules by default, making me a little suspicious as to how it punches out of my
home network!?

If UPnP is enabled, to my suprise it [opens a few ports](http://s.natalian.org/2015-09-09/ports.png)!

	Starting Nmap 6.47 ( http://nmap.org ) at 2015-09-09 10:54 SGT
	Host is up (0.0038s latency).
	Not shown: 994 closed ports
	PORT    STATE    SERVICE
	53/tcp  filtered domain
	88/tcp  open     kerberos-sec
	443/tcp open     https
	888/tcp open     accessbuilder


I access it from the odd address of <http://192.168.1.10:88/> (port eighty
eight). It has a fairly odd [nmap scan](http://ix.io/kDy).

<img alt="no login if no plugin installed" src=http://s.natalian.org/2015-09-06/plugin-login.png>

Number one annoyance is that FOSCAM'S WEB INTERFACE DOES NOT LET YOU LOGIN
WITHOUT YOU INSTALLING THEIR PLUGIN. Yes, it's a black hole of an untrusted
proprietary binary. You could be basically installing anything on your system.
It could be malicious. That I find is completely unacceptable. You should be
able to adjust Webcam settings without running their plugin!!

<img src=http://s.natalian.org/2015-09-09/c1-web-interface.png>

You cannot change a most settings without access to their Web interface.

## Doesn't sync ntp time by default

What on earth... why?? Time should always be correct. Except on this Foscam, by default.. it isn't!

## No API

There is no documented API for the C1. There are drips and drabs around the
Internet about how to interact with Foscam Webcams with a restful API, but a
lot of the material is out dated or just wrong. Very frustrating !

## FTP ..OR.. SD CARD

You can't seem to have both which is a shame. Ideally the flow would be to save
to SD card and upload. If upload fails, retry and with sdcard we always have a
backup.

Also it can't upload via HTTP which is a sin in 2015.

## Lots of "Foscam" apps on the appstore

It's hard to compare and judge the value of the zillions of Foscam or Webcam Apps in the Apple Appstore.

* <https://itunes.apple.com/sg/app/foscam-viewer/id740126713?mt=8> sucked
* <https://itunes.apple.com/sg/app/foscam/id924381688?mt=8> is what I use but argh...

So many bugs with
[it](https://itunes.apple.com/sg/app/foscam/id924381688?mt=8). No way to listen
to audio. No sane way to manage alerts, like only get them when out of the
house. Often fails to connect (says it's OFF). Yes I have UPNP enabled.

The one GOOD thing I like about the app is that it shows the bandwidth it's
using on the top right:

<img alt="screenshot of viewing the Webcam from an iPhone6" src=http://s.natalian.org/2015-09-06/webcam-via-app.jpg>

I was expecting to see a Foscam cloud service that had images and videos of
motion alert events. To my surprise, there aren't!

# Web confusion

There are lots of foscam Web sites and I am still not sure which one is
**canonical**.

[foscam.us offers some worrying security advice](http://foscam.us/blog/foscamipcameras/tips-on-securing-your-foscam-camera/).. [Backup link](http://s.natalian.org/2015-09-06/foscam-5-steps.png)

1. install latest firmware - this is absolutely non-trivial on foscam cameras .. like where do you get the firmware?
* never use the defaults... well the defaults are blank soo....
* choose a long password >8 chars ... argh
* change your default ports
* check your logs... I have not figured this out myself

# SDK access

To get documentation or SDK access to Foscam's camera, so you can... use it better, you need to sign an NDA.
