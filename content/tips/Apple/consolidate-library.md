---
title: Consolidating the FCPX Library
date: 2021-05-22
description: How to ensure all your media is in the Library
---

Some people prefer to reference their media, I prefer to keep all the files for
a particular video idea in one place; the <abbr title="Final Cut Pro X">FCPX</abbr> Library. To do this, [Select the Library in the left-hand pane and over on the right in Library Properties, click Consolidate](https://www.reddit.com/r/fcpx/comments/nhfwem/how_do_i_copy_media_referenced_by_my_library_into/gyxcw1k/).

<img src="https://s.natalian.org/2021-05-22/consolidate.png">

I run:

	for i in *.fcpbundle; do ./test-not-consolidated.sh $i; done

With the bash script `test-not-consolidated.sh`:

	#!/bin/bash

	[[ $1 = *.fcpbundle ]] || exit

	for i in ${1}/*/'Original Media'/*
	do
		test -L "$i" && echo $i needs consolidating
	done

To discover which libraries need consolidating. This happens for me largely by
accident when I fail to specify "Copy to Library" whilst importing.
