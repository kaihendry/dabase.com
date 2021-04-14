---
title: Is Java really faster than Go?
date: 2021-04-14T15:26:24+08:00
description: Load testing between a Java and Go application against a Postgresql database
---

Full disclosure: I'm a Rob Pike / Russ Cox / Go fan boy and I am keen to see it more at my
workplace, where the Java language rules by a wide margin.

Earlier I [blogged that Go is better than
Java](/blog/2021/Java-vs-Go/), but it lacked evidence and datapoints.

So after searching https://dzone.com/ for "Java Go" comparisons I was surprised to find an article at the top of results:

<img src="https://s.natalian.org/2021-04-14/java-vs-go.png">

Which concluded that [Java can serve twice as many simultaneous users as the Go
application](https://dzone.com/articles/java-vs-go-multiple-users-load-test-1).

WHAT? 🤯

Is that true?! Can I reproduce his results!?

# Reproducing the results

To Ivan's credit, he publishes the source of his [Java](https://github.com/nikitsenka/bank-java) & [Golang](https://github.com/nikitsenka/bank-go) application as well as [how he tested with Jmeter](https://github.com/nikitsenka/bank-test/blob/master/jmeter/bank-test.jmx), his results AND how to run it all on a neutral playing ground of [AWS via Cloudformation](https://github.com/nikitsenka/bank-go/blob/master/aws/cloudformation.yml)!

I ran it locally and indeed **the Go application was erroring and slower
than the Java app**. Despite the `bank-go` image weighing in at 10.2MB compared
to the 991MB image size of `bank-java` and consuming a lot less resources
whilst running:

<img src="https://s.natalian.org/2021-04-14/java-running.png" alt="docker stats">
<img src="https://s.natalian.org/2021-04-14/go-running.png" alt="docker stats">
