---
title: Is Java really faster than Go?
date: 2021-04-14T15:26:24+08:00
description: Load testing between a Java and Go application against a Postgresql database
toc: true
---

{{< youtube 8lGW2CsYA9o >}}

## Researching earlier Java/Go benchmarks

Earlier I [blogged that Go is better than Java](/blog/2021/Java-vs-Go/), but it
lacked evidence and datapoints. I wanted to start from some earlier work, to
prove to my colleagues that Go is as fast as Java and quick to start up.
**Speed is critical for serverless** since the process can be stopped when not
in use and started again from cold to serve a request!

So after searching https://dzone.com/ for "Java Go" comparisons I was surprised
to find a benchmark article by Ivan Nikitsenka (original author) at the top of results:

<img src="https://s.natalian.org/2021-04-14/java-vs-go.png">

Which concluded that [**Java can serve twice as many simultaneous users** as the Go
application](https://dzone.com/articles/java-vs-go-multiple-users-load-test-1).

WHAT? 🤯

Is that true?! Can Java's lazily just-in-time compiler be faster than a Go static
binary?! Can I reproduce his results!?

## Reproducing the results

To the original author's credit, he publishes the source of his
[Java](https://github.com/nikitsenka/bank-java) &
[Golang](https://github.com/nikitsenka/bank-go) application as well as [how he
tested with
Jmeter](https://github.com/nikitsenka/bank-test/blob/master/jmeter/bank-test.jmx),
his results AND how to run it all on a neutral playing ground of [AWS via
Cloudformation](https://github.com/nikitsenka/bank-go/blob/master/aws/cloudformation.yml)!

I ran it locally on my T14s Thinkpad and indeed **the Go application was
erroring compared to the "springboot" Java app**. Despite the `bank-go` image
weighing in at 10.2MB compared to the 991MB image size of `bank-java` and
consuming a lot less resources whilst running:

<img src="https://s.natalian.org/2021-04-14/java-running.png" alt="Java running with docker stats">
<img src="https://s.natalian.org/2021-04-14/go-running.png" alt="Go running with docker stats">

## Why is Go slower?

Instinctively I thought the database connection must be the bottle neck. The original author's
[bank-go database
functions](https://github.com/nikitsenka/bank-go/blob/master/bank/postgres.go)
use https://github.com/lib/pq#status which recommends using pgx which is
actively maintained. Great! All I need is to do, is switch the database driver
from **pq** to [**pgx**](https://github.com/jackc/pgx). Despite making the
change to the "sql.DB" type compatible github.com/jackc/pgx/v4/stdlib ... the
same [type of errors](https://github.com/nikitsenka/bank-go/issues/6) occurred
when load testing...

     read tcp 127.0.0.1:XXXXX->127.0.0.1:5432: read: connection reset by peer #6

After some soul searching and a cup of tea, perhaps it has something to do with
how the **connections are pooled to the database**. Unfortunately it meant a
[refactor from *sql.DB to *pgxpool.Pool where
context](https://github.com/nikitsenka/bank-go/pull/7/files) needs to be added.

<img src="https://s.natalian.org/2021-04-14/moments-later.webp" alt="moments later">

Yes! The errors have gone away. It also appears much faster. Whatever
**pgxpool** (limiting connections to the database?) is doing, it seems to be
working!

## Load testing locally on my T14s

Java does take a few seconds to get going to generate the machine code under
the hood...

<a href="https://s.natalian.org/2021-04-14/java.png">
<img src="https://s.natalian.org/2021-04-14/java.png">
</a>

Using [hey load tester](https://github.com/rakyll/hey) instead of Jmeter:

<a href="https://s.natalian.org/2021-04-14/java-hey.png">
<img width="45%" src="https://s.natalian.org/2021-04-14/java-hey.png">
</a>

<a href="https://s.natalian.org/2021-04-14/go-hey.png">
<img width="45%" src="https://s.natalian.org/2021-04-14/go-hey.png">
</a>

Locally I was seeing Go at ~7457 requests/sec and Java at ~5758 requests/sec
once it warmed up. Pretty much the same. However we should run the original
author's jmeter test with a controlled / reproducible environment... enter the Cloud.

## Load testing Go/Java on AWS

There are three potential bottlenecks:

1. The client benchmarking tool (as well as the network)
2. The app
3. The database

And lets not forget that AWS's T type instances (virtual machines) are
**Burstable Performance Instances** and might be too variable for benchmarking.

I decided to use m4.large for both bank-{app,db} and run [original jmeter benchmark](https://github.com/nikitsenka/bank-test)
upon the app server and update the [Cloudformation to use AWS Linux
ECS](https://github.com/kaihendry/bank-go/blob/master/aws/cloudformation.yml).
Note that I hard coded the IP address of the database, so you need to change
that when you are reproducing results yourself.

I setup my ssh public key like so:

    aws --profile dev ec2 import-key-pair --key-name "hendry" --public-key-material fileb://~/.ssh/id_rsa.pub

So my AWS benchmarking workflow was something like:

1. [make](https://github.com/kaihendry/bank-go/blob/master/aws/Makefile) delete - tear down Cloud resources
2. make deploy - bring up the App and Database on the static IP
3. Wait especially long for the [Java version](https://s.natalian.org/2021-04-24/cloudformation.yml) - running `mvn` seemed to be where it was mostly
4. [benchmark.sh](https://github.com/kaihendry/bank-test/blob/master/benchmark.sh) "test-name"

Go [Benchmark 1](https://s.natalian.org/2021-04-24/go1/index.html) [Benchmark 2](https://s.natalian.org/2021-04-24/go3/index.html) [Benchmark 3](https://s.natalian.org/2021-04-24/go-m5a.large/index.html)
Java [Benchmark 1](https://s.natalian.org/2021-04-24/java2/index.html) [Benchmark 2](https://s.natalian.org/2021-04-24/java4/index.html) [Benchmark 3](https://s.natalian.org/2021-04-24/java-m5a.large/index.html)

## Conclusions

- Java takes a lot longer to stand up than Go - not a good candidate for serverless! **2022 UPDATE** may have changed with [Lambda SnapStart](https://aws.amazon.com/blogs/aws/new-accelerate-your-lambda-functions-with-lambda-snapstart/)
- Orchestration like an ALB health check could be incorporated into the stack though I ran out of time. The instances build the Docker image and it's not clear when they are ready...
- Repeated testing on bank-{go,java} resulted in **No file descriptors available** exhaustion, this [appears to be an AWS ECS issue](https://medium.com/@pahud/ulimit-of-nofile-in-amazon-ecs-optimized-ami-6790aedee582)
- Detailed monitoring via Cloudwatch of the instance was too course grained to tell if the database was the bottle neck... quite a disappointing <abbr title="Developer Experience">DX</abbr>. Further instrumentation is probably needed to work out where the bottle necks lie
- Go appears a little faster, however more stable from a cold start, with the 99p being far lower ~100ms than Java's >2000ms .. However over some runtime I suspect Java will be more stable.

Not clear what the [errors](https://s.natalian.org/2021-04-24/errors.png) that
the [original author initially
observed](https://dzone.com/articles/java-vs-go-multiple-users-load-test-1),
since I think this is how the original author **mistakenly concluded that Java could serve
twice as many users**. In my testing, I could run the tests **without errors in**
either Go/Java stack when I waited patiently for the Java service to be ready, and
not run the tests repeatedly as to cause [**too many open files**](https://medium.com/@pahud/ulimit-of-nofile-in-amazon-ecs-optimized-ami-6790aedee582).

The original authors's Go code appears to have had a [database connection pool limit
issue](https://github.com/nikitsenka/bank-go/issues/2) which goes away when
[using pgxpool](https://github.com/nikitsenka/bank-go/pull/7).

As the Reddit
[/r/java](https://www.reddit.com/r/java/comments/mxzsuc/discussion_is_java_really_faster_than_go/)
and YouTube comments suggest, <q>For most tasks Java and Go are completely fine
performance wise.</q> However I did find Java quite unwieldy, with proponents
mandating **warm up time for Java**, which would certainly result in a
problematic Serverless **cold start**. In comparison Go has out of the box
developer productivity and serverless friendly execution times.

Nonetheless Java frameworks to their credit are targeting [slow startup
times](https://www.slideshare.net/VadymKazulkin/adopting-java-for-the-serverless-world-at-aws-user-group-pretoria)
with Ahead of Time Compilation (AoT) with [GraalVM](https://www.graalvm.org/) &
[Quarkus](https://quarkus.io/). It is great to see healthy competition, though
currently Java has some catching up to do!
