---
title: Thinkpad vs M1
date: 2021-07-26T11:18:07+08:00
description: M1 boasts breakthrough hardware, with a poor developer experience
---

# Price

* Bought 20-05-2021 13-inch MacBook Air - 512GB 8GB RAM - 1690SGD (16GB RAM wasn't in stock and I didn't want to wait)
* Bought 29-08-2020 [Thinkpad T14s](https://www.youtube.com/watch?v=ihFPynCqfzc&list=PLiKgVPlhUNuy_AnTdTxCVGsMgidyGuCcQ) (20UHS01400) - 1662SGD (inc a 135SGD ThinkPad USB-C Dock Gen 2)

<https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_1>

The Lenovo buying experience was awful.

# Keyboard / Mouse

About the same actually.

The M1 Trackpad is far superior. I need an external mouse with the Thinkpad.

# Suspend

* M1 is blazing fast, like faster than you can open the lid! Like a mobile phone?
* Thinkpad is also pretty good. 

# CPU

I was impressed by the Ryzen oompf, but tbh I was not super satisfied with
Video acceleration.

M1 feels very fast.

# Battery

* M1 wins - it can easily last all day
* Thinkpad lasts enough ... however

	/etc/udev/rules.d/99-lowbat.rules:
	SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+="/usr/bin/systemctl hibernate"

However these "Discharging" events don't get reported to `udevadm monitor`! 

# Screen

* M1 wins 2650x1600 and it's awesome
* Thinkpad has a sad 1920x1080 screen

# Microphone / Camera / Speakers

T14s microphone is unusable. So is the camera. Speakers are better than I
remember previous Thinkpads had, but still woeful compared to the MBA M1.

# Ram

* M1 has 8GB fixed. It manage to make it panic on not enough memory, enough to close an app.
* Thinkpad has 16GB also fixed (soldered on)

# Heat

Admittedly the T14s would get hot on challenging workloads, like playing games.
But under normal browser + terminal workloads, I found it fine. Though it was easy to put it over the edge... _perhaps_ by running Slack or running Firefox/Chrome together. :/

M1 wins. It doesn't even have a fan. You can actually use this laptop **on your lap**.

# Ports

Both have two USB-C ports. T14s has two extra USB-As. Win for Thinkpad!

Tbh if the Thinkpad had a network port and a SD card reader, I would sing the
heavens of it.

# Software

M1 run MacOS and FCPX / Safari are beautifully optimised for it. But don't forget [Safari sucks for the Web](https://news.ycombinator.com/item?id=27968394)!

T14s can run any OS, and I've chosen Archlinux btw.

Fans of Apple Silicon are working to port Linux to it: <https://asahilinux.org/> ... it's not there yet

<img src="https://raw.githubusercontent.com/amworsley/asahi-wiki/main/images/USB-keyboard-boot.png">

# Conclusion

{{< youtube c4QpF9EjaGY >}}

Despite the M1's hardware being amazing, I just hate [brew](https://brew.sh/) over pacman/yay. I
hate the [bewildering](https://dabase.com/tips/Apple/2021/Alt-Tab-behaviour-on-MacOS/) MacOS window manager and the stupid animations I can't turn off. I
hate the xcode nonsense. I hate not being in control of the software. I hate
being someone's bitch when it comes to software choices. That said, you can workaround the contempt for developers with a [whole bunch of tweaks](https://www.swyx.io/new-mac-setup-2021/), that would probably take more time for me to apply than install Archlinux on a Thinkpad.

Would I install Linux if I could? Probably not. I actually like to see what's
going on in MacOS, and to importantly use Photos and FCPX, which I am sadly
reliant upon for my pictures and videos!

So what's your next Linux laptop? idk. Not Apple hardware.

Tbh my idea of late is to [build a quiet team Red PC](https://streacom.com/products/db4-fanless-mini-itx-case/). When I'm out and about, I'll only take the M1 with me.
