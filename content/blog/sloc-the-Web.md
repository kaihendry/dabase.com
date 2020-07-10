---
title: SLOC the Web
date: 2020-07-04T09:24:09+08:00
description: Notes on trying to measure the Web's client, aka the browser
---

<style>
img {
  background-color: white;
  border: thin solid black;
  border-radius: 20px;
  }
video { width: 100%; }
</style>

Since [my video on measuring the <abbr title="Source Lines of Code">SLOC</abbr>](https://youtu.be/g7jpfAlC-Zg) using
[ohcount](https://github.com/blackducksoftware/ohcount), I've been wanting to
tackle the elephant in the room. **The Web!!**

You can moan about the Web all day, but if you are [not looking at the codebase](https://www.youtube.com/watch?v=6WRlMvxPlCA&feature=youtu.be&t=93), then you're just a consumer and you're not really helping. Don't worry, I've been guilty of this too, though I'm trying to change.

The gist of <abbr title="Source Lines of Code">SLOC</abbr>, is if there is more
code, there is more complexity. As The Notorious B.I.G. said: Mo Code, Mo
Problems.

There are too thorny issues whilst counting to be aware of before we get started:
1. Tests, I made a [testbloat.sh](https://s.natalian.org/2020-07-04/sloc-from-arch.txt) script to rip them out
2. Dependencies (look at Arch's PKGBUILD for some clues)

[Firefox](https://s.natalian.org/2020-07-10/firefox-ldd.txt) &
[chromium](https://s.natalian.org/2020-07-10/chromium-ldd.txt) actually have a
few dependencies compared to
[surf](https://s.natalian.org/2020-07-10/surf-webkit2gtk-ldd.txt)'s Webkit.
This suggests that {Firefox,Chromium} pull in a lot of dependencies into their
source distribution and compile it in. Hence we should see much bigger <abbr title="Source Lines of Code">SLOC</abbr> for {Firefox,Chromium}...

## Blink

* Used in the Market share leader "Chrome" (chomium in OSS) by Google
* Fork of Webkit in [August 2001](https://chromium.googlesource.com/chromium/src/+/d869b93fe74f4d6cb2dd6f6c3e9bf9daee39ba19)
* `git clone https://chromium.googlesource.com/chromium/src blink` Warning: Takes forever
* Web view: https://chromium.googlesource.com/chromium/src.git/+/refs/heads/master/content/
* [Archlinux package](https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/chromium)

`testbloat.sh chromium`:

	6.2G src with tests
	3.7G src without tests

## Webkit

* Originated from Konquerer and the KDE project, whereby Apple hired its developers
* `git clone git://git.webkit.org/WebKit-https.git WebKit`
* Web view: https://trac.webkit.org/browser
* [Archlinux package](https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=webkitgtk)
* [blink is fork from Webkit](https://chromium.googlesource.com/chromium/src.git/+/refs/heads/master/third_party/blink/)

`testbloat.sh webkit2gtk`:

	227M src with tests
	201M src without tests

## Gecko

* Originated from Netscape in 1998
* Used in Firefox
* `git clone git@github.com:mozilla/gecko-dev.git` backed is actually mercurial
* Web view: https://github.com/mozilla/gecko-dev
* [Archlinux package](https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/firefox)

`testbloat.sh firefox`:

	2.7G src with tests
	1.2G src without tests

More than half the code base is... **tests** !

# Source distribution

Using Archlinux, I grabbed the {firefox,webkit2gtk,chromium} distributions like so:

	asp checkout $1
	cd $1/trunk
	makepkg -os --skippgpcheck
	cd src/$1*

Lets look at:

* number of files `find chromium-83.0.4103.116/ -type f | wc -l`
* cloc's number of files

<img src="https://s.natalian.org/2020-07-10/files.svg" alt="browser source files count">

* number of lines `find chromium-83.0.4103.116 -type f -exec cat {} + | wc -l`
* cloc's number of lines

<img src="https://s.natalian.org/2020-07-10/lines.svg" alt="browser source lines count">

I was surprised to see chromium/blink to be more <abbr title="Lines of
Code">LOC</abbr> than Firefox!

gnuplot source is here:

	$summary << EOD
	browser,wcfiles,wclines,clocfiles,cloclines
	webkitgtk-2.28.2,19472,4710385,18620,3120740
	firefox-78.0.1,289298,43627834,240137,24371602
	chromium-83.0.4103.116,420343,100340817,269434,49597826
	EOD
	set terminal svg
	set datafile separator ','
	set yrange [0:*]      # start at zero, find max from the data
	set boxwidth 0.5      # use a fixed width for boxes
	set style fill solid border -1
	set ytics format "%.0s%c" #  will generate labels 100k 200k 300k ... 1M
	set title 'lines'
	plot '$summary' using 3:xtic(1) ti col, '' u 5 ti col


# Git checkout

I want to examine the git checkout to see if it differs from the source
downloads. I'm also keen to examine their sloc over time using
https://github.com/kaihendry/graphsloc

So **with the git history**, the projects weigh in at:

	hendry@knuckles ~/sloc $ du -sh *
	11G     WebKit
	26G     blink
	5.6G    gecko

<img src="https://s.natalian.org/2020-07-10/web-commit-count.svg" alt="count of commits in respective git repositories">

Can anyone make
[collect-stats.sh](https://github.com/kaihendry/graphsloc/blob/master/collect-stats.sh)
faster because these took DAYS to gather the data.

## Blink

<img src="https://s.natalian.org/2020-07-09/blink-fa66724154f7.svg" alt="blink lines changes from git">

## Gecko

<img src="https://s.natalian.org/2020-07-06/gecko-668686ae0504.csv.svg" alt="gecko lines changes from git">

I'm not quite sure why there are horizontal lines. Do please look at the [gecko source CSV](https://s.natalian.org/2020-07-10/gecko-668686ae0504.csv)!

## Webkit

<img src="https://s.natalian.org/2020-07-10/WebKit-3a2f99102ac.svg" alt="webkit lines changes from git">

# Git versus source distribution

The mapping isn't clear for me.

## Chromium/Blink

<video src="https://s.natalian.org/2020-07-09/chromium-vs-blink-git.mp4" controls></video>

## Firefox

<video src="https://s.natalian.org/2020-07-09/firefox-vs-git.mp4" controls></video>

## webkit2gtk

<video src="https://s.natalian.org/2020-07-09/webkit2gtk-src-vs-git.mp4" controls></video>

# Conclusion

I'm still making sense of this.
