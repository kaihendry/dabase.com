---
title: suckless Second Display
date: 2021-09-03T07:03:53+08:00
description: A 4K screen stacked ontop of my T14s as my window to the world
---

The LG 27UN880-B is a 4K USB-C screen I bought to improve my desktop setup.

<img src="https://s.natalian.org/2021-09-02/lg.jpeg" alt="LG 27UN880-B">

I find I get best results when I connect via DisplayPort or USB-C which also appears in `xrandr` as **DisplayPort-1**.

<img src="https://s.natalian.org/2021-09-03/annotated-usbc.png" alt="USB-C connections on a T14s">

	ins)[hendry@t14s ~]$ xrandr --auto --output DisplayPort-1 --above eDP
	(ins)[hendry@t14s ~]$ xrandr
	Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 16384 x 16384
	eDP connected primary 1920x1080+0+0 (normal left inverted right x axis y axis) 309mm x 174mm
	   1920x1080     60.05*+
	   1680x1050     60.05
	   1280x1024     60.05
	   1440x900      60.05
	   1280x800      60.05
	   1280x720      60.05
	   1024x768      60.05
	   800x600       60.05
	   640x480       60.05
	HDMI-A-0 disconnected (normal left inverted right x axis y axis)
	DisplayPort-0 disconnected (normal left inverted right x axis y axis)
	DisplayPort-1 connected (normal left inverted right x axis y axis)
	   3840x2160     60.00 +  30.00
	   2560x1440     59.95
	   1920x1200     60.00
	   1920x1080     60.00    59.94
	   1600x1200     60.00
	   1680x1050     60.00
	   1600x900      60.00
	   1280x1024     60.02
	   1440x900      60.00
	   1280x800      59.81
	   1280x720      60.00    59.94
	   1024x768      60.00
	   800x600       60.32
	   720x480       60.00    59.94
	   640x480       60.00    59.94

Using `udevadm monitor 2>&1 | tee LG-27UN880-B-with-inputs-udev.txt`, I am not sure which event to hinge a rule off: https://s.natalian.org/2021-09-03/LG-27UN880-B-with-inputs-udev.txt

# Issues

Since the font appears small on 4K, should I be scaling the screen?

<img src="https://s.natalian.org/2021-09-03/fourk.png">

Or should I just get into the habit of punching Ctrl-Plus to resize my browser
windows or terminals?

## Keyboard

Numpad doesn't work in Linux.

https://www.reddit.com/r/logitech/comments/pfnlwt/mx_keys_for_archlinux/

## Xlayoutdisplay

	(ins)[hendry@t14s dabase.com]$ xlayoutdisplay
	eDP active 31cm/17cm 1920x1080+0+2160 60Hz
	*+!1920x1080 60Hz
	   1680x1050 60Hz
	   1280x1024 60Hz
	   1440x900 60Hz
	   1280x800 60Hz
	   1280x720 60Hz
	   1024x768 60Hz
	   800x600 60Hz
	   640x480 60Hz
	HDMI-A-0 disconnected
	DisplayPort-0 disconnected
	DisplayPort-1 active 60cm/34cm 3840x2160+0+0 60Hz
	*+!3840x2160 60Hz
	   3840x2160 30Hz
	   2560x1440 60Hz
	   1920x1200 60Hz
	   1920x1080 60Hz
	   1920x1080 60Hz
	   1600x1200 60Hz
	   1680x1050 60Hz
	   1600x900 60Hz
	   1280x1024 60Hz
	   1440x900 60Hz
	   1280x800 60Hz
	   1280x720 60Hz
	   1280x720 60Hz
	   1024x768 60Hz
	   800x600 60Hz
	   720x480 60Hz
	   720x480 60Hz
	   640x480 60Hz
	   640x480 60Hz
	*current +preferred !optimal

	laptop lid open or not present

	calculated DPI 156 for output eDP

	xrandr \
	 --dpi 156 \
	 --output eDP --mode 1920x1080 --rate 60 --pos 0x0 --primary \
	 --output HDMI-A-0 --off \
	 --output DisplayPort-0 --off \
	 --output DisplayPort-1 --mode 3840x2160 --rate 60 --pos 1920x0

	echo "Xft.dpi: 156" | xrdb -merge

## Tearing


## whatever

	(ins)[hendry@t14s ~]$ grep -v "#" /etc/systemd/logind.conf

	[Login]
	HandlePowerKey=lock
	HandleLidSwitch=ignore
	HandleLidSwitchExternalPower=ignore
	HandleLidSwitchDocked=ignore
	LidSwitchIgnoreInhibited=yes

## Barrier

### MacOS the server

Due to MacOS secure keyboard, the [keyboard is not
shared](https://github.com/debauchee/barrier/issues/393) to my Archlinux
machine intermittedly. This makes running barrier on MacOS unworkable.

## Archlinux as the barrier server

I can feel the lag from to time.

Copy and paste for images does not work

Clipboard does feel a bit cripped, like I can't see to paste without formatting.
