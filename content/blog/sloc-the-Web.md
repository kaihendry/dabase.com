---
title: "SLOC the Web"
date: 2020-07-04T09:24:09+08:00
description: Notes on trying to measure the Web's implementation
---

Since [my video on measuring the <abbr title="Source Lines of Code">SLOC</abbr>](https://youtu.be/g7jpfAlC-Zg) using
[ohcount](https://github.com/blackducksoftware/ohcount), I've been wanting to
tackle the elephant in the room. **The Web!!**

You can moan about the Web all day, but if you are [not looking at the codebase](https://www.youtube.com/watch?v=6WRlMvxPlCA&feature=youtu.be&t=93), then you're just a consumer and you're not really helping. Don't worry, I've been guilty of this too, though I'm trying to change.

The gist of <abbr title="Source Lines of Code">SLOC</abbr>, is if there is more
code, there is more complexity. As The Notorious B.I.G. said: Mo Code, Mo
Problems.

There are too thorny issues whilst counting to be aware of before we get started:
1.. Tests, I made a [testbloat.sh](https://s.natalian.org/2020-07-04/sloc-from-arch.txt) script to rip them out
2. Dependencies (look at Arch's PKGBUILD for some clues)

## Blink

* Used in the Market share leader "Chrome" (chomium in OSS) by Google
* Fork of Webkit in [August 2001](https://chromium.googlesource.com/chromium/src/+/d869b93fe74f4d6cb2dd6f6c3e9bf9daee39ba19)
* `git clone https://chromium.googlesource.com/chromium/src blink`
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

# Count!

I want to examine the git checkout to see if it differs from the source downloads. I'm also keen to examine their sloc over time using https://github.com/kaihendry/graphsloc
