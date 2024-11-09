---
title: Dual Monitor with Archlinux
date: 2022-12-03T14:01:01+08:00
description: hotplugging another screen is not easy
---

    AS an Archer
    I WANT to plug my external screen via USB-C
    SO THAT I can compute on a single screen

# Udev

Udev is the place to put rules so that when hardware events can be acted upon.

    sudo udevadm monitor

However there are issues.

## No ID for the external monitor

    sudo udevadm monitor | grep drm
    KERNEL[6296.403550] change   /devices/pci0000:00/0000:00:08.1/0000:04:00.0/drm/card0 (drm)
    UDEV  [6296.409078] change   /devices/pci0000:00/0000:00:08.1/0000:04:00.0/drm/card0 (drm)
    KERNEL[6303.624819] change   /devices/pci0000:00/0000:00:08.1/0000:04:00.0/drm/card0 (drm)
    UDEV  [6303.630592] change   /devices/pci0000:00/0000:00:08.1/0000:04:00.0/drm/card0 (drm)

The device doesn't appear to change whether I'm using the external USB-C monitor. So you don't know if you are connected or not!

## Udev isn't user based

Udev will run the script as root, so it makes working with a user's X session awkward.

## Tricky to work with rules

    cat /etc/udev/rules.d/95-monitor-hotplug.rules
    KERNEL=="card0", ACTION=="change", SUBSYSTEM=="drm", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/hendry/.Xauthority", RUN+="/home/hendry/runme.sh"

If you change the rules, don't forget to run:

    udevadm control --reload-rules && udevadm trigger

Logging via `journalctl -b -u systemd-udevd` isn't much help!

# /sys/class/drm/ - everything is a file on Unix!

We don't need udev! We have the /dev, sorry /sys file interface to check on our
devices!

    external_monitor=/sys/class/drm/card0-eDP-2/status
    read STATUS < $external_monitor
    if test $STATUS == "connected"
    then

This will not work as expected due to fact that
/sys/class/drm/card0-eDP-2/status takes **seconds to update**, so if you run
the script, you will see wrongly see the **state disconnected**, when in fact
you have connected it!

This is why you might see in scripts:

    sleep $START_DELAY

# ~~inotifywait will fix it!~~

> sadly inotify doesnt work on most /sys procfs etc files

`inotifywait -m /sys/class/drm/card0-DP-2/status` will not work or worse will create spurious events.

# Now what?

You have to use some program like [autorandr or xlayoutdisplay](https://wiki.archlinux.org/title/Xrandr#CLI_front-ends).
