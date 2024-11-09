---
date: 2016-07-12 13:32:43 +0800
title: Whats the difference between a Docker container and a Virtual machine?
---

Docker is much **faster** and more productive to work with than a Virtual
machine. It's basically a front end on [**Linux containers** aka
LXC](https://en.wikipedia.org/wiki/LXC).

Ideally Docker is running on a "bare metal" machine since it does not need to
be virtualised. It runs a lot faster, but admittedly you probably won't see the
performance boon if you are running on a already virtualised VPS like EC2 or
MacOS. A lightweight Linux OS like [CoreOS](https://coreos.com/) or
[RancherOS](http://rancher.com/rancher-os/) makes more sense for running Docker
containers.

Docker runs whole services in containers which are isolated and can be
controlled much like a Virtual machine, but without any complex hardware
abstractions.

But Docker is much more; For example the <https://hub.docker.com/> is a public
repository where you can almost pick a pre-**packaged** service off the shelf.
Instead of running Nginx packaged by your distribution for example, you can run
the [official nginx Docker image from Nginx](https://hub.docker.com/_/nginx/),
who know the software and dependencies best.

Docker defines a
[Dockerfile](https://docs.docker.com/engine/reference/builder/) which like
`debian/rules` or Arch's `PKGBUILD` is a very succinct way of describing how a
service is packaged and furthermore deployed in a network and run.

Docker has a layered filesystem to make it easy for developers to isolate
changes and to iterate quickly. You can painlessly keep current or roll back
and forth atomically using image tags.

Docker has a raft of handy tools in their popular ecosystem to help network
containers and manage filesystem mounts between the container and host.
[Compose](https://docs.docker.com/compose/) is a advanced tool with a
definition language for managing a whole formation of Cloud services. A complex
network of services can be launched and maintained using it.
