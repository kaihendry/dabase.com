---
title: No dist-upgrade
date: 2023-01-04T15:37:33+08:00
description: Is updating wrong?
---

For decades of my computing life, my daily routine has been something like:

    apt-get update && apt-get upgrade

or nowadays on Archlinux:

    yay

# Daily package patches

Almost every day behind the computer, I enjoyed the village pump of new opensource package updates. Updates to files and binaries replaced via packages. Historically [Archlinux News](https://archlinux.org/news/) announced when interventions are in complex update scenarios.

<img src="https://s.natalian.org/2023-01-04/intervention.png">

# Patching production

When deploying Raspbian or a production release of Red Hat Enterprise, it's unusual for it to be manually updated. Even less so with the automated **unattended-upgrades** package.

Since regular linux updates are common, people tend not to update for fear of jeopardising uptime. Since a linux update neccesitates a reboot.

Furthermore applications tend to depend on underlying operating system libraries, so there is a reluctance to update the operating system, for fear it might affect the running application.

Conservative users might choose "Debian stable" and only security updates, and that is fraught with misery as all the packages are old snapshots deemed "stable" not by upstream, but by package developers.

# The problem with dist-upgrade

The problem with dist-upgrade is that it's a one-way street. You cannot roll back easily. There is no Quality Assurance pipeline in place, so you don't know if your application will run on the new operating system.

#  Modern updates

1. Docker offers a clear application isolation
2. CoreOS offers a self-updating Docker container runtime

Instead of updating the underlying operating system and hoping the application will still work like a game of Jenga, the modern system is isolated into an immutable Docker container runtime and the containers it runs.

Data must be split too, resulting in the modern [Three-tier architecture](https://docs.aws.amazon.com/whitepapers/latest/serverless-multi-tier-architectures-api-gateway-lambda/three-tier-architecture-overview.html) paradigm:

1. Client Web browser - typically everygreen on consumer devices
2. Server - Docker container runtime - updating via [AMI ID](https://aws.amazon.com/blogs/compute/query-for-the-latest-amazon-linux-ami-ids-using-aws-systems-manager-parameter-store/)
3. Date - Seperate and managed like AWS RDS / S3

# Cattle, not pets

Updating a modern service, ignoring the data layer, is matter of choosing your OS <abbr title="Amazon Linux Image">AMI</abbr> and Application image id or tag.

* No patches
* Trivial to roll back
* Immutable

A load balancer with container orchestration needs to be in place to have a container ready to serve requests when a member of the cattle is being replaced.

# Challenges

Most companies are transitioning to modern deployment practices which requires deprecating the old patching strategy. [OSes should not update themselves!](https://forums.raspberrypi.com/viewtopic.php?p=2054478)

For example your Devops team should not be "hardening" (aka patching) images or waiting for "audits" to happen. Frequent updates via CI/CD infrastructure must to be in place to create the artefacts and automate the checks.
