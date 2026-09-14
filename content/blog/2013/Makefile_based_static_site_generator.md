---
date: 2013-02-19 23:09:26 +0800
title: "A small Makefile-based static site generator"
description: "A minimal publishing workflow that combines Markdown, m4, shared headers and footers, and Makefile dependency rules."
---

Store [markdown formatted](http://en.wikipedia.org/wiki/Markdown) index.mdwn files in a directory hierarchy. Store the style.css, [header.inc](https://github.com/kaihendry/sg-hackandtell/blob/master/header.inc) & [footer.inc](https://github.com/kaihendry/sg-hackandtell/blob/master/footer.inc) in the base directory with the following [Makefile](https://github.com/kaihendry/sg-hackandtell/blob/master/Makefile):

	INFILES = $(shell find . -name "*.mdwn")
	OUTFILES = $(INFILES:.mdwn=.html)

	all: $(OUTFILES)

	%.html: %.mdwn footer.inc header.inc style.css
		m4 -PEIinc header.inc > $@
		markdown $< >> $@
		cat footer.inc >> $@

	clean:
		rm -f $(OUTFILES)

	PHONY: all clean

Now simply run `make` to generate your site.
