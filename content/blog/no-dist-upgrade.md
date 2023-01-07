---
title: No dist-upgrade
date: 2023-01-04T15:37:33+08:00
description: In-place updating is not best practice for production deployments
---

For decades of my computing life, my routine has been something like:

    apt-get update && apt-get upgrade

or nowadays on Archlinux:

    yay

# Daily package patches

Almost every day behind the computer, I enjoyed the village pump of new opensource package updates. Updates to files & binaries replaced via packages. Historically [Archlinux News](https://archlinux.org/news/) announced **manual interventions** in complex update scenarios.

<img src="https://s.natalian.org/2023-01-04/intervention.png">

# Patching production is no longer recommended

When deploying [Raspbian](https://forums.raspberrypi.com/viewtopic.php?p=2054478) or a production release of Red Hat Enterprise, it's unusual for it to be manually updated frequently. Even less so automated, for example with the **unattended-upgrades** package, since it's deemed fragile.

Since regular Linux updates are common, people tend not to update for fear of jeopardizing uptime. Since a Linux update necessitates a reboot.

Furthermore dynamically linked applications depend on underlying operating system libraries, so there is a reluctance to update the operating system, for fear it might affect the running application.

Conservative users might choose "Debian stable" and only security updates, and that is fraught with misery as all the packages are old snapshots deemed "stable" not by upstream, but by package developers. This often results in frustration by upstream who do not support arbitrary snapshots of their software.

# The problem with dist-upgrade

The problem with `dist-upgrade` is that it's a one-way street. You cannot roll back easily. With no Quality Assurance (tests) pipeline in place, you don't know if your application will run on the new underlying operating system.

Redhat themselves warn that since <abbr title="Redhat Enterprise Linux">RHEL</abbr> is "highly customisable", they do not recommend upgrading between major releases. 

An **in-place upgrade** RHEL 7 to 8 at your workplace, is the legacy patching way. Instead a new host OS image ID should be selected, together with the container image IDs to run on top of it.

#  Modern updates

1. Docker offers clear application isolation in containers
2. CoreOS / AWS ECS / Kubernetes offers a minimal Docker container runtime or Host OS

In-place updating the underlying operating system and hoping the application will still work is like a **game of Jenga**. The modern best practice requires an immutable Docker container runtime OS and the Application container IDs it runs.

<img src="https://s.natalian.org/2023-01-06/valery-fedotov-CxE1H2_9B9s-unsplash.webp" alt="Jenga" title="Jenga photo by Valery Fedoto https://unsplash.com/photos/CxE1H2_9B9s">

Your application's **data** must be split out too, resulting in the modern [Three-tier architecture](https://docs.aws.amazon.com/whitepapers/latest/serverless-multi-tier-architectures-api-gateway-lambda/three-tier-architecture-overview.html) paradigm:

1. Client Web browser - typically evergreen on consumer devices
2. Server - Docker container runtime - updating the host Operating System by ID, e.g. via [AMI ID](https://aws.amazon.com/blogs/compute/query-for-the-latest-amazon-linux-ami-ids-using-aws-systems-manager-parameter-store/)
3. Data - Separate and managed like AWS RDS / S3

# Cattle, not pets

Pets are patched and groomed. Cattle can be culled and replaced at any time.

The data tier aside, updating is now a matter of choosing your OS and Application image identifier. Ideally automated by <abbr title="Continuous Delivery">CD</abbr> pipelines.

How to get the ID for a typical host image:

    aws ssm get-parameters --names /aws/service/ecs/optimized-ami/amazon-linux-2/recommended

How to get the ID for the latest upstream of a Dockerized container using the _latest_ convention:

    docker pull $yourApplication:latest
    docker image inspect --format '{{.RepoDigests}}' $yourApplication:latest

Locking to a version means:

* No patching
* Trivial to roll back, specify previous ID
* Immutable

When cattle are replaced, a load balancer with container orchestration to dispatch requests to ready containers is needed to avoid any dropped requests.

# An industry shift to immutable artefacts

Most companies are transitioning to modern deployment practices which requires retiring the old patching processes.

For example your Devops team should not be "hardening" (aka patching) images or waiting for "audits" to happen. 

Instead **invest** in CI/CD pipelines to create the required host/image artefacts and automate / "shift left" the checks. 

The **goal is continuous delivery**, in robust reproducible build pipelines with tests, and not an _after the fact_ ah-hoc patch.