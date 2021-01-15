---
title: A make build tool that sucks less
date: 2021-01-13T17:29:43+08:00
description: GNU Make could be replaced by... redo
---

<abbr title="D. J. Bernstein">djb</abbr> introduced
[redo](https://cr.yp.to/redo.html)'s elegant design in a couple of pages.
[@apenwarr](https://twitter.com/apenwarr) then created a Python version with [good documentation and fleshed
out examples](https://redo.readthedocs.io/en/latest/).

The design of redo unlike [GNU make](https://www.gnu.org/software/make/) is
elegant and can be shown to implemented in [1000LOC of
C](https://github.com/leahneukirchen/redo-c) or even in
[shell](http://news.dieweltistgarnichtso.net/bin/redo-sh.html)!

[redo in Golang introduced by Sergey
Matveev](https://lists.suckless.org/dev/2012/34100.html), is where I began to
learn and be persuaded:

> I understand you very good there! I spent several months at home and
> work converting Makefiles without assurance that it is worth of it and
> not just making another kind of bicycle without any visible profits. But
> now my scepticism is lost completely and I literally have no Makefile in
> nearly all of my (and work) projects (of course except various projects
> forks). redo is life-changing :-).
>
> * no pain and struggle with various Make implementations (I use BSD,
>   GNU/Linux systems use GNU Make, that also have slightly different
>   behaviour in its versions)
> * cool autodependency on .do files and deterministic behaviour with work
>   directories (some Make implementation change to directory when doing
>   "$(MAKE) -C dir", some are not)
> * I can create dynamic targets in Makefiles now, like autodetecting what
>   "#include"s exist in .c files to depend them on
> * guaranteed working of parallel builds, that are often just does not
>   work properly on many many existing Makefile
> * no complete rebuilding of the project "just to be sure"
>
> All of that just saves much time and greatly helps to make the job done.

### [Why hasn't redo eaten Make' lunch?](https://groups.google.com/g/redo-list/c/-7ksrHEsIYI)

> Some combination of multiple fragmented implementations and lack of critical mass?

[Tests collected by
Sergey](http://www.git.cypherpunks.ru/?p=goredo.git;a=tree;f=t;) are becoming
more comprehensive. Uses the same [test harness as
git](https://github.com/chriscool/sharness).

### I want a single file, like a `Makefile` instead of bunch of *.do files?

[Yes you can have one file](https://lists.suckless.org/dev/2101/34125.html),
but making a modification to this build file has a **huge disadvantage**... **all
targets will expire**!

### Packages?

* [Archlinux](https://aur.archlinux.org/packages/goredo/)
* [Homebrew](https://formulae.brew.sh/formula/goredo)
* [Upstream](http://www.goredo.cypherpunks.ru/Install.html)
