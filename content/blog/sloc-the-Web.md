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
* Hard Fork of Webkit in 2013, though I can't find/trace a single similar file between [Webkit](https://git.webkit.org/?p=WebKit.git;a=tree;f=Source/WebCore/dom;) and [Blink](https://chromium.googlesource.com/chromium/src.git/+/refs/heads/master/third_party/blink/renderer/core/dom/) in 2020
* [Webkit can be seen to have merged in 2001](https://chromium.googlesource.com/chromium/src/+/d869b93fe74f4d6cb2dd6f6c3e9bf9daee39ba19)
* `git clone https://chromium.googlesource.com/chromium/src blink` Warning: Takes forever
* Web view: https://chromium.googlesource.com/chromium/src.git/+/refs/heads/master/content/
* [Archlinux package](https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/chromium)

`testbloat.sh chromium`:

	6.2G src with tests
	3.7G src without tests

<object type="image/svg+xml" data="https://s.natalian.org/2020-07-20/chromium.svg"></object>

Flamegraph via https://github.com/brendangregg/FlameGraph

## Webkit

* Originated from Konquerer and the KDE project (grep for kde.org), Apple hired Antti Koivisto
* `git clone git://git.webkit.org/WebKit-https.git WebKit`
* Web view: https://trac.webkit.org/browser
* [Archlinux package](https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=webkitgtk)

`testbloat.sh webkit2gtk`:

	227M src with tests
	201M src without tests

<object type="image/svg+xml" data="https://s.natalian.org/2020-07-20/webkit2gtk.svg"></object>

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

<object type="image/svg+xml" data="https://s.natalian.org/2020-07-20/firefox.svg"></object>

# Source distribution

Using Archlinux, I grabbed the {firefox,webkit2gtk,chromium} distributions like so:

	asp checkout $1
	cd $1/trunk
	makepkg -os --skippgpcheck
	cd src/$1*

Lets look at:

* number of files `find chromium-83.0.4103.116/ -type f | wc -l`
* cloc's number of files
* number of lines `find chromium-83.0.4103.116 -type f -exec cat {} + | wc -l`
* cloc's number of lines

I chose [cloc](https://github.com/AlDanial/cloc/issues/500#issuecomment-656476950) over ohcount since it was faster. It ignores files that it doesn't
deem as source. Tbh, I think every file in a source distribution should be
considered source. Since pruning non-source files, tests and documentation is a
slipperly slope!

<img src="https://s.natalian.org/2020-07-11/combined.svg" alt="browser source files/lines count">

I was surprised to see chromium/blink to be more <abbr title="Lines of
Code">LOC</abbr> than Firefox!

gnuplot source is here:

	$Data <<EOD
	browser,wcfiles,wclines,clocfiles,cloclines
	webkitgtk-2.28.2,19472,4710385,18620,3120740
	firefox-78.0.1,289298,43627834,240137,24371602
	chromium-83.0.4103.116,420343,100340817,269434,49597826
	EOD

	set terminal svg
	set datafile separator ','
	set title 'sloc the Web'

	set yrange [1000:*]
	set logscale y
	set ytics format "%.0s%c"

	set style data histogram
	set style histogram cluster gap 1
	set style fill solid border -1
	set boxwidth 0.9

	plot $Data u 2:xtic(1) ti col,\
		 '' u 4 ti col,\
		 '' u 3 ti col,\
		 '' u 5 ti col

Thank you [Stackoverflow](https://stackoverflow.com/a/62846787/4534)


# Git checkout

From which the source distribution (x86 target) is somehow 🤷 derived!

So **with the git history**, the projects weigh in at:


Flamegraph via https://github.com/brendangregg/FlameGraph
	hendry@knuckles ~/sloc $ du -sh *
	11G     WebKit
	26G     blink
	5.6G    gecko

<img src="https://s.natalian.org/2020-07-11/sources.svg" alt="bar chart comparison between webkit, gecko, blink">

	$Data <<EOD
	browser srcurl rev commitcount files lines
	WebKit git://git.webkit.org/WebKit-https.git 3a2f99102aca947abcf9f70d0785dc3e5c073560 226748 310036 43304162
	blink https://chromium.googlesource.com/chromium/src fa66724154f74bab505fe38c4b6d0d31b5a83ed0 906439 330146 42244206
	gecko git@github.com:mozilla/gecko-dev.git 668686ae0504450a8c93501d1eb115f201eb982d 716280 281292 43547855
	EOD
	set terminal svg
	set datafile separator ' '
	set title 'git source'
	set yrange [1000:*]
	set logscale y
	set ytics format "%.0s%c"
	set style data histogram
	set style histogram cluster gap 1
	set style fill solid border -1
	set boxwidth 0.9
	set key left top
	plot $Data u 4:xtic(1) ti col,\
		 '' u 5 ti col,\
		 '' u 6 ti col

It's an incredible **coincidence** how the sloc (without .git) is roughly the
same between the three git checkouts!

	blink/ 42244206
	gecko/ 43547855
	WebKit/ 43298218

Data was generated by:

	hendry@knuckles ~/sloc $ cat wc.sh
	echo browser srcurl rev commitcount files lines
	for i in WebKit blink gecko
	do
			G="--git-dir ./$i/.git"
			commit=$(git $G rev-parse HEAD)
			commitcount=$(git $G rev-list --count $commit)
			srcurl=$(git $G config --get remote.origin.url)
			files=$(find $i/ -not -path '*/\.git/*' -type f | wc -l)
			lines=$(find $i/ -not -path '*/\.git/*' -type f -exec cat {} + | wc -l)
			echo $i $srcurl $commit $commitcount $files $lines
	done

## Blink

<object type="image/svg+xml" data="https://s.natalian.org/2020-07-20/nogit-blink-fa66724154f74bab505fe38c4b6d0d31b5a83ed0.svg"></object>

## Webkit

<object type="image/svg+xml" data="https://s.natalian.org/2020-07-20/nogit-WebKit-757ebd954ef013db82b2e4d02d7b311b32691975.svg"></object>

##  Gecko

<object type="image/svg+xml" data="https://s.natalian.org/2020-07-20/nogit-gecko-668686ae0504450a8c93501d1eb115f201eb982d.svg"></object>

# LOC over time

I'm also keen to examine their sloc over time using a tool I wrote
https://github.com/kaihendry/graphsloc

## Blink

Can anyone make
[collect-stats.sh](https://github.com/kaihendry/graphsloc/blob/master/collect-stats.sh)
faster because these took DAYS to gather the data.

<img src="https://s.natalian.org/2020-07-09/blink-fa66724154f7.svg" alt="blink lines changes from git">

45M lines of code when I add up all the lines of all the commits. However that falls considerably short of the **100M** of `find chromium-83.0.4103.116 -type f -exec cat {} + | wc -l`. However if you look at cloc's analysis of 49M... it's pretty close to 45M!

## Gecko

<img src="https://s.natalian.org/2020-07-06/gecko-668686ae0504.csv.svg" alt="gecko lines changes from git">

I'm not quite sure why there are horizontal lines. Do please look at the [gecko source CSV](https://s.natalian.org/2020-07-10/gecko-668686ae0504.csv)!

The total is ~130M, but when I look at just the firefox-78.0.1 source
distribution... it's just 43M or if you just want to look at source files with
`cloc` ... 23M. I suspect the git - mercurial bridge is problematic.

## Webkit

<img src="https://s.natalian.org/2020-07-10/WebKit-3a2f99102ac.svg" alt="webkit lines changes from git">

40M doesn't come close to the 5-3M of code I got from the https://webkitgtk.org
sources... that's because a release is **cut** from the git, which is
documented upon https://trac.webkit.org/wiki/WebKitGTK/Releasing

# Conclusion

I'm still making sense of this.
