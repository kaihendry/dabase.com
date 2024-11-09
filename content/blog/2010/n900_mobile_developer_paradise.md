---
date: 2010-01-22 18:47:16 +0000
---

<a href="http://www.flickr.com/photos/hendry/4295918782/" title="Multiple widgets by Kai Hendry, on Flickr"><img src="http://farm5.static.flickr.com/4055/4295918782_478a271f4a_o.png" width="800" height="480" alt="Multiple widgets" /></a>

Wow, something that usually takes a couple of days has been achieved on a
single day with the n900. I brought up the Web stack on maemo5! I am so
excited, I am going to share my notes with you in order to kill some time.

There is a proper [libwebkit-1.0-2 maemo
package](http://maemo.org/packages/view/libwebkit-1.0-1) by [Christian
Dywan](http://twotoasts.de/), though I just do things manually myself to get to
know maemo5 better.

32bit Debian squeeze [i7
hetzner](http://www.hetzner.de/en/hosting/produkte_rootserver/eq4/) build
machine made life a lot easier.

Installing the SDK was painless via a couple of shell scripts found:
<http://wiki.maemo.org/Documentation/Maemo5_Final_Installation#Installing_Maemo_5_SDK_on_x86-32_Debian_based_distribution>

	sb-conf select FREMANTLE_ARMEL

	/scratchbox/login

	[sbox-FREMANTLE_ARMEL: ~] > cat /etc/apt/sources.list
	deb http://repository.maemo.org/ fremantle/sdk free non-free
	deb-src http://repository.maemo.org/ fremantle/sdk free
	deb http://repository.maemo.org/ fremantle/tools free non-free
	deb-src http://repository.maemo.org/ fremantle/tools free
	deb http://repository.maemo.org/extras-devel/ fremantle free non-free
	deb-src http://repository.maemo.org/extras-devel/ fremantle free non-free

I had to add extras-devel for something. I don't know why it isn't on there by
default.

On the host system, `/scratchbox/users/hendry/home/user` is the working directory.

I had to build:

* gail-1.22.0 (wtf is this crap)
* glib-2.22.4
* libsoup-2.28.1
* xmlsec1-1.2.12 (my stuff, not needed for Webkit per-se)
* And a fairly recent WebKit checkout from 12/2009 with a few patches

(Later found out Christian has patches to remove gail and enchant. Nice.)

Try build things into /usr/local in order not to screw up the rootstrap and to
know what stuff to copy across.

	export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig
	export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib

I hate configure. You GNU guys have brought me to the edge of insanity and
back.

When building, `make -j8` speed things up a bit on a i7 machine. :)

For some reason or another some arm generated Webkit stuff is b0rked. Fixed
with commands like:

	cp WebKit/gtk/webkit/webkitenumtypes.h /scratchbox/users/hendry/home/user/webkit/WebKit/gtk/webkit/webkitenumtypes.h
	cp DerivedSources/CSS* /scratchbox/users/hendry/home/user/webkit/DerivedSources/

If you see:

	undefined reference to hildon_g_scanner_cache_open

That means maemo5 is going nuts because it can't find some brain dead hildon
patches my own sane **glib**. Simply implement the function like so:

	void hildon_g_scanner_cache_open() {}

And the nightmarish thoughts of rebuilding  a new gtk with hildon go away. Btw
I noticed that -lselinux somehow snuck in the build process. Had to remove it
manually from the Makefile.

I would like to build some Debian packages, though I **need** debhelper7. I
dislike the previous versions like 5 currently installed on Fremantle. Also dpkg-buildpackage does not seem to understand `-j8`. wtf!

# Copying arm built stuff to the device

<a href="http://www.flickr.com/photos/hendry/4295957522/" title="Power save off by Kai Hendry, on Flickr"><img src="http://farm5.static.flickr.com/4027/4295957522_90ea24ae9c_o.png" width="800" height="480" alt="Power save off" /></a>

`ssh -A` forwarding does not seem to work. Rsync seems a little unreliable
directly from the device. So I first rsync down from my remote build server
like so `rsync --progress -artv
88.198.64.227:/scratchbox/users/hendry/targets/FREMANTLE_ARMEL/usr/local/ .`
and then scp stuff to like this `scp -r * root@n900:/home/opt/`.

Turn off the n900's wireless power saving to avoid transfers **STALL**ing.

root fs does not have a lot of space! So use **/home/opt**

	Nokia-N900-42-11:~# df -h
	Filesystem                Size      Used Available Use% Mounted on
	rootfs                  227.9M    195.6M     28.1M  87% /
	ubi0:rootfs             227.9M    195.6M     28.1M  87% /
	tmpfs                     1.0M     68.0k    956.0k   7% /tmp
	tmpfs                   256.0k     84.0k    172.0k  33% /var/run
	none                     10.0M     72.0k      9.9M   1% /dev
	tmpfs                    64.0M      4.0k     64.0M   0% /dev/shm
	/dev/mmcblk0p2            2.0G    316.0M      1.6G  17% /home
	/opt/pymaemo/usr/lib/python2.5
							  2.0G    316.0M      1.6G  17% /usr/lib/python2.5
	/opt/pymaemo/usr/share/pyshared
							  2.0G    316.0M      1.6G  17% /usr/share/pyshared
	/opt/pymaemo/usr/lib/pyshared
							  2.0G    316.0M      1.6G  17% /usr/lib/pyshared
	/opt/pymaemo/usr/share/python-support
							  2.0G    316.0M      1.6G  17% /usr/share/python-support
	/opt/pymaemo/usr/lib/python-support
							  2.0G    316.0M      1.6G  17% /usr/lib/python-support
	/dev/mmcblk0p1           27.0G    481.3M     26.5G   2% /home/user/MyDocs

Argh, I hate Python.

To get the stuff running, I source a script:

	Nokia-N900-42-11:~# cat setup
	export LD_LIBRARY_PATH=/opt/lib:/usr/lib
	export PATH=/opt/bin:$PATH
	. ./setup

And run my freshly built arm binaries.

Summary: maemo5 is a mobile developer's paradise.
