---
date: 2012-04-15 11:40:44 +0800
---

What does a FAQ need?

1. A table of contents listing the questions
2. A way to hyperlink the question

Unfortunately most FAQs seem to fail to do this. To save you time doing this by
hand, I have written [toc](https://github.com/kaihendry/toc), a tool that
creates a table of contents from your headers with `id` anchors.

Here is a Makefile I use on my Websites:

	INFILES = $(shell find . -name "*.src.html")
	OUTFILES = $(INFILES:.src.html=.html)
	TEMP:= $(shell mktemp -u /tmp/web.XXXXXX)

	all: $(OUTFILES)

	%.html: %.src.html
		m4 -PEIinc $< > $(TEMP)
		toc $(TEMP) > $@
		rm -f $(TEMP)

	clean:
		rm -f $(OUTFILES)

	PHONY: all clean

`m4` is used for inserting footers and such.
