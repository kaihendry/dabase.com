* <http://dabase.com/blog/Starting_n900_development>
* <http://dabase.com/blog/n900_mobile_developer_paradise>
* <http://wiki.maemo.org/User:Jebba/Package_Building_HOWTO>

## A shell with less key strokes and human memory needed

The [bash shell](http://en.wikipedia.org/wiki/Bash) over busybox is much nicer
since you get to use `ctrl+r` for bash history which I find very productive.

	apt-get install bash

And change the root shell in `/etc/passwd` to `/bin/bash`.

## debhelper seven works on maemo5

debhelper7 "maemo ported" packages are provided by
<http://www.maemory.com/N900/> are **well worth** installing. All my own Debian
packages use [Joey Hess](http://kitenet.net/~joey/)'s
[debhelper7](http://kitenet.net/~joey/code/debhelper/) because of its brilliant
[suckless](http://suckless.org/) properties. dh7 `debian/rules` are much
smaller and much more manageable.

As mentioned before the N900's root space is stupidly tiny. :( I'm disappointed
maemo developers didn't union/aufs mount this problem away. Have a look at
<http://wiki.maemo.org/Opt_Problem> for the "/opt solution".

TODO: Figure out wtf maemo keeps it's kernel configuration and perhaps try
build my own with [aufs](http://en.wikipedia.org/wiki/Aufs) support.

## strace embedded debugging

In my `/etc/apt/sources.list.d/debug.list` I have:

	deb http://repository.maemo.org/ fremantle/sdk free non-free
	deb http://repository.maemo.org/ fremantle/tools free non-free

`apt-get install strace` and bliss

## Where to put maemo desktop shortcuts

	/usr/share/applications/hildon

These maemo specific shortcuts have some interesting options.

The I use for starting [Web commander](http://wiki.webvm.net/wrtc/) looks like:

	[Desktop Entry]
	Encoding=UTF-8
	Version=0.1
	Type=Application
	Name=Web Commander
	Exec=/home/user/w
	Terminal=true
	X-HildonDesk-ShowInToolbar=true
	X-Osso-Type=application/x-executable
	X-HildonDesk-ShowInToolbar=true

What `/home/user/w` looks like:

	#!/bin/sh
	. /home/user/setup
	ID=$(wrtc -i webc /home/user/WebCommander.wgt)
	wrtc -r $ID

And `/home/user/setup`:

	export LD_LIBRARY_PATH=/opt/lib:/usr/lib

## Android debug bridge on maemo5

<http://git.webvm.net/?p=adb> has a maemo port (debhelper7 based) of
[adb](http://developer.android.com/guide/developing/tools/adb.html).

There is an odd pty issue with maemo5 that limits the amount of open shells you
can have. Unfortunately `adb` does not alleviate this problem. However if you
are an Android developer like myself it does seem to unify development
somewhat. It also seems a little more responsive than ssh. Try it out.
