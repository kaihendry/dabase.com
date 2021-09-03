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
