---
title: Identifiers
date: 2021-10-22T13:50:30+08:00
description: There are alternatives UUID
---

A modern computer has the ability to express a 64bit number natively.

How large is a 64 bit number?

	$ python -c "print (2**64-1)"
	18446744073709551615

It's very large and for a private system, probably good enough spatial
range to uniquely identify all the items you are dealing with.

Though how do you express a very large number compactly and in a way a
human can understand?

For example Youtube uses 11 characters of base64:

	$ python -c "print (64**11)"
	73786976294838206464

	$ for i in {1..3}; do head -c9 /dev/urandom | base64 | tr '+/' '_-'; done
	fFwtamv4YJXP
	HB1C9dG7cHGQ
	-HTzHvHLwpyf

https://youtu.be/gocwRvLhDf8?t=85

[UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier) is **128 bit**,
i.e. 2^128-1 and whilst the probability that a UUID will be duplicated is not
zero, it is close enough to zero to be negligible.


{{< tweet 1450302244134420482 >}}

{{< tweet 760977498507124736 >}}

{{< tweet 1450850328610365446 >}}

https://github.com/ulid/spec
