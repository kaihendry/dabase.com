---
title: Identifiers
date: 2021-10-22T13:50:30+08:00
description: There are alternatives to UUID
---

A modern computer has the ability to express a 64bit number natively.

How large is a 64 bit number?

    $ python -c "print (2**64-1)"
    18446744073709551615

It's very large and for a private system, probably good enough spatial
range to uniquely identify all the items you are dealing with.

Though how do you express a very large number compactly and in a way a
human can understand?

For example Youtube uses 11 characters of base64. How many base64 characters
would it require to express a 2^64 number? 2^6^x = 2^64 .. so x = 64/6 =
10.666666666 ... i.e. eleven rounded up.

    $ for i in {1..3}; do head -c9 /dev/urandom | base64 | tr '+/' '_-'; done
    fFwtamv4YJXP
    HB1C9dG7cHGQ
    -HTzHvHLwpyf

https://youtu.be/gocwRvLhDf8?t=85

[UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier) is **128
bit**, i.e. 2^128-1 and whilst the probability that a UUID will be duplicated
is not zero, it is close enough to zero to be negligible. However it's opaque,
generic and 64 bit is more than enough. For better 128 bit identfiers look at
https://github.com/ulid/spec

{{< tweet user="kaihendry" id="1450302244134420482" >}}

{{< tweet user="tjholowaychuk" id="760977498507124736" >}}

{{< tweet user="_beyondcode" id="1450850328610365446" >}}

<abbr title="Universally Unique Lexicographically Sortable
Identifier">ULID</abbr> aside, I do simply prefer base64 encoded 64 bits
numbers, aka the "Youtube style Identifier"
https://stackoverflow.com/questions/69675161/how-to-generate-a-youtube-id-in-go

Although extremely unlikely a duplicate (aka collision) random 64 bit number is
possible in a large public system, so generated identifiers would ideally need
to be checked before usage. A timestamp + <abbr title="Youtube">YT</abbr> style
to play it safe.

However I'd argue for private system, 64 bit should be more than enough to
identify (use a prefix!) everything you need to like so:
https://github.com/auth0/id-generator
