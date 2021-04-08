---
title: Java vs Go
date: 2021-04-05T15:23:30+08:00
description: Where is Go lacking in Enterprise adoption?
toc: true
---

<style>
img {
float: right;
height: 20em;
filter: drop-shadow(1px 1px 0 gold)
        drop-shadow(-1px -1px 0 gold);
}
</style>

[Modern Java](https://github.com/binkley/modern-java-practices) is a well known
and massive Ecosystem in the Enterprise.

Go (2009) on the other hand is probably best known as a "Google language",
notably powering Web Apps (APIs) and DevOps (Docker) workloads.


## Java compared to Go

<img src="https://s.natalian.org/2021-04-05/duke.svg" alt="Duke, the Java Mascot" >

Strengths:

- Mature JVM
- [Massive amount of libraries](https://mvnrepository.com/)
- Many developers in the market

Weaknesses:

- Confusing licensing terms esp [regarding their API](https://news.ycombinator.com/item?id=26699106)
- Bloat everywhere
- Slow iterations
- No clear way to do one one thing e.g. maven/gradle
- Verbose
- Requires an IDE for productivity
- Reliance on heavyweight tooling
- Some fragmentation - Scala & Kotlin might offer short term productivity gains, but long term support is unknown

## Go compared to Java

<img src="https://s.natalian.org/2021-04-05/gopher.svg" alt="Go Gopher">

Strengths:

- Simple BSD licensing
- [Simple, well designed language](https://golang.org/ref/spec)
- Strong standard library for most needs with a strong [third party package ecosystem](https://pkg.go.dev/)
- Better performance
- Less moving parts (LOC)
- Concurrency is easier to achieve
- Backed by Google with [several case studies](https://go.dev/solutions#case-studies)
- Build (no gradle!), packaging & testing is part of the distribution (no tricky choices)
- Debugger (delve), code formatter (gofmt) & language server (gopls) independent of any IDE so any editor can integrate (including vim!)
- Near instant build/run times
- [Better error capture](https://www.youtube.com/watch?v=Fh4AT4SC17U)
- [Growing libraries](https://pkg.go.dev/)
- <https://play.golang.org/> makes it simple to share running code by URL

Weaknesses:

{{< tweet 1379620502361137154 >}}

- Scarcity hiring Go developers

## Conclusion

Finding a good engineer is a problem with any programming language. Go is [easy
to learn](https://tour.golang.org/) and productive with "just works" developer
experience, unlike Java which has many crufty corners.

{{< tweet 1379626478875201537 >}}
