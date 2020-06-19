---
title: Thinkpad T480s sdcard slot failure
description: Unable to mount a Sandisk Extreme PRO on a T480s
date: 2020-06-19T10:11:17+08:00
---

<img src="https://s.natalian.org/2020-06-19/t480s.jpeg" alt="Thinkpad T480s which fails">

Using my Thinkpads SD card slot does not work:

	[hendry@t480s mnt]$ sudo mount /dev/sda1 /mnt/sda1
	mount: /mnt/sda1: wrong fs type, bad option, bad superblock on /dev/sda1, missing codepage or helper program, or other error.
	[hendry@t480s mnt]$ sudo exfatfsck /dev/sda1
	exfatfsck 1.3.0
	Checking file system on /dev/sda1.
	ERROR: exFAT file system is not found.
	File system checking stopped. ERRORS FOUND: 1, FIXED: 0.
	[hendry@t480s mnt]$ sudo mount /dev/sda1 /mnt/sda1
	mount: /mnt/sda1: wrong fs type, bad option, bad superblock on /dev/sda1, missing codepage or helper program, or other error.

<img src="https://s.natalian.org/2020-06-19/hootoo.jpeg" alt="Hootoo USB dongle with SDCARD slot">

Using a USB-C dongle does work:

	[hendry@t480s mnt]$ lsblk -f
	NAME          FSTYPE      FSVER LABEL UUID                                 FSAVAIL FSUSE% MOUNTPOINT
	sdb
	└─sdb1        exfat       1.0   LUMIX 315C-B528
	[hendry@t480s mnt]$ sudo exfatfsck /dev/sdb1
	exfatfsck 1.3.0
	Checking file system on /dev/sdb1.
	File system version           1.0
	Sector size                 512 bytes
	Cluster size                128 KB
	Volume size                  59 GB
	Used space                 2791 MB
	Available space              57 GB
	Totally 15 directories and 14 files.
	File system checking finished. No errors found.
	[hendry@t480s mnt]$ sudo mount /dev/sdb1 /mnt/sdb1
	FUSE exfat 1.3.0
