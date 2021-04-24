---
title: Is Java really faster than Go?
date: 2021-04-14T15:26:24+08:00
description: Load testing between a Java and Go application against a Postgresql database
---

STATUS: DRAFT / WIP

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
when load testing...

	 read tcp 127.0.0.1:XXXXX->127.0.0.1:5432: read: connection reset by peer #6

After some soul searching and a cup of tea, perhaps it has something to do with
how the **connections are pooled to the database**. Unfortunately it means a
[heavy refactor from *sql.DB to *pgxpool.Pool where
context](https://github.com/nikitsenka/bank-go/pull/7/files) needs to be added.

<img src="https://s.natalian.org/2021-04-14/moments-later.webp" alt="moments later">

Some moments later, it's up and running. Yes! The errors have gone away. It
also appears much faster. Whatever **pgxpool** is doing, it seems to be working!

# Time to race!

Java does take a few seconds to get going...

<img src="https://s.natalian.org/2021-04-14/java.png">

Using [hey load tester](https://github.com/rakyll/hey) instead of Jmeter:

<a href="https://s.natalian.org/2021-04-14/java-hey.png">
<img width="45%" src="https://s.natalian.org/2021-04-14/java-hey.png">
</a>

<a href="https://s.natalian.org/2021-04-14/go-hey.png">
<img width="45%" src="https://s.natalian.org/2021-04-14/go-hey.png">
</a>

Locally I was seeing Go at ~7457 requests/sec and Java at ~5758 requests/sec
once it warmed up. We need some neutral compute though.

# Benchmarking Go/Java on AWS

There are three potential bottlenecks:

1. The client benchmarking tool (as well as the network)
2. The app
3. The database

And lets not forget the T type instances are **Burstable Performance
Instances** and might too variable for benchmarking.

I decided to use m4.large for both bank-{app,db} and run the jmeter benchmark
upon the app server and update the [Cloudformation to use AWS Linux
ECS](https://github.com/kaihendry/bank-go/blob/master/aws/cloudformation.yml).
Not that I hard coded the IP address of the database, so you need to change
that if you are reproducing results yourself.

I setup my ssh public key like so:

	aws --profile dev ec2 import-key-pair --key-name "hendry" --public-key-material fileb://~/.ssh/id_rsa.pub

So my AWS benchmarking workflow was something like:

1. [make](https://github.com/kaihendry/bank-go/blob/master/aws/Makefile) delete
2. make deploy
3. Wait especially long for the [Java version](https://s.natalian.org/2021-04-24/cloudformation.yml)
4. [benchmark.sh](https://github.com/kaihendry/bank-test/blob/master/benchmark.sh) "test-name"

Go [Test 1](https://s.natalian.org/2021-04-24/go1/index.html) [Test 2](https://s.natalian.org/2021-04-24/go3/index.html) [Test 3](https://s.natalian.org/2021-04-24/go-m5a.large/index.html)
Java [Test 1](https://s.natalian.org/2021-04-24/java2/index.html) [Test 2](https://s.natalian.org/2021-04-24/java4/index.html) [Test 3](https://s.natalian.org/2021-04-24/java-m5a.large/index.html)

# Conclusions

* Java takes a lot longer to stand up that Go - not a good candidate for serverless!
* Orchestration like an ALB health check could be incorporated into the stack though I ran out of time. The instances build the Docker image and it's not clear when they are ready...
* Repeated testing on bank-{go,java} resulted in **No file descriptors available** exhaustion, this must be a ECS Docker issue
* Detailing monitoring via Cloudwatch of the instance was too course grained to tell if the database was the bottle neck
* Generally Go is faster, and far more stable, with the 99p being far lower ~100ms than Java's >2000ms

Not clear what the [errors](https://s.natalian.org/2021-04-24/errors.png) that Ivan initially saw.
