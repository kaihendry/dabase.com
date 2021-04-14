---
title: Is Java really faster than Go?
date: 2021-04-14T15:26:24+08:00
description: Load testing between a Java and Go application against a Postgresql database
---

Full disclosure: I'm a Rob Pike / Russ Cox / Go fan boy and I am keen to see it more at my
workplace, where the Java language rules by a wide margin.

Earlier I [blogged that Go is better than
Java](/blog/2021/Java-vs-Go/), but it lacked evidence and datapoints.

So after searching https://dzone.com/ for "Java Go" comparisons I was surprised
to find an article by Ivan Nikitsenka at the top of results:

<img src="https://s.natalian.org/2021-04-14/java-vs-go.png">

Which concluded that [Java can serve twice as many simultaneous users as the Go
application](https://dzone.com/articles/java-vs-go-multiple-users-load-test-1).

WHAT? 🤯

Is that true?! Can Java bytecode be faster than a Go static binary?! Can I
reproduce his results!?

# Reproducing the results

To Ivan's credit, he publishes the source of his
[Java](https://github.com/nikitsenka/bank-java) &
[Golang](https://github.com/nikitsenka/bank-go) application as well as [how he
tested with
Jmeter](https://github.com/nikitsenka/bank-test/blob/master/jmeter/bank-test.jmx),
his results AND how to run it all on a neutral playing ground of [AWS via
Cloudformation](https://github.com/nikitsenka/bank-go/blob/master/aws/cloudformation.yml)!

I ran it locally on my T14s Thinkpad and indeed **the Go application was erroring and slower
than the Java app**. Despite the `bank-go` image weighing in at 10.2MB compared
to the 991MB image size of `bank-java` and consuming a lot less resources
whilst running:

<img src="https://s.natalian.org/2021-04-14/java-running.png" alt="Java running with docker stats">
<img src="https://s.natalian.org/2021-04-14/go-running.png" alt="Go running with docker stats">

# Why is Go slower?

Instinctly I thought the database connection must be the bottle neck. Ivan's
[bank-go database
functions](https://github.com/nikitsenka/bank-go/blob/master/bank/postgres.go)
use https://github.com/lib/pq#status which recommends using pgx which is
actively maintained. Great! All I need is to do, is switch the database driver
from **pq** to [**pgx**](https://github.com/jackc/pgx). Despite making the
change to the "sql.DB" type compatible github.com/jackc/pgx/v4/stdlib ... the
same [type of errors](https://github.com/nikitsenka/bank-go/issues/6) occured
with testing...

	 read tcp 127.0.0.1:XXXXX->127.0.0.1:5432: read: connection reset by peer #6

Next after some soul searching and tea, perhaps it has something to do with how
the connections are pooled to the database. Unfortunately it means a [heavy
refactor from *sql.DB to *pgxpool.Pool where
context](https://github.com/nikitsenka/bank-go/pull/7/files) needs to added.

Some moments later, it's up and running. Yes! The errors have gone away. It
also appears much faster. Whatever **pgxpool** is doing, seems to be working!

# Time to race!

Java does take a few seconds to get going...

<img src="https://s.natalian.org/2021-04-14/java.png">

Using [hey load tester](https://github.com/rakyll/hey) instead of Jmeter:

<img width="45%" src="https://s.natalian.org/2021-04-14/java-hey.png">
<img width="45%" src="https://s.natalian.org/2021-04-14/go-hey.png">

Locally I was seeing Go at 7457 requests/sec and Java at 5758 requests/sec once
it warmed up. We need some neutral compute though.
