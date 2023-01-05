---
title: No dist-upgrade
date: 2023-01-04T15:37:33+08:00
description: In-place updating is not best practice
---

For decades of my computing life, my daily routine has been something like:

    apt-get update && apt-get upgrade

or nowadays on Archlinux:

    yay

# Daily package patches

Almost every day behind the computer, I enjoyed the village pump of new opensource package updates. Updates to files & binaries replaced via packages. Historically [Archlinux News](https://archlinux.org/news/) announced **manual interventions** in complex update scenarios.

<img src="https://s.natalian.org/2023-01-04/intervention.png">

# Patching production

When deploying [Raspbian](https://forums.raspberrypi.com/viewtopic.php?p=2054478) or a production release of Red Hat Enterprise, it's unusual for it to be manually updated frequently. Even less so automated, for example with the **unattended-upgrades** package, since it's deemed fragile.

Since regular Linux updates are common, people tend not to update for fear of jeopardising uptime. Since a Linux update neccesitates a reboot.

Furthermore dynamically linked applications depend on underlying operating system libraries, so there is a reluctance to update the operating system, for fear it might affect the running application.

Conservative users might choose "Debian stable" and only security updates, and that is fraught with misery as all the packages are old snapshots deemed "stable" not by upstream, but by package developers. This often results in frustration by upstream who do not support arbitary snapshots of their software.

# The problem with dist-upgrade

The problem with dist-upgrade is that it's a one-way street. You cannot roll back easily. There is no Quality Assurance pipeline in place, so you don't know if your application will run on the new underlying operating system.

Redhat themselves warn that since <abbr title="Redhat Enterprise Linux">RHEL</abbr> is "highly customisable", they do not recommend upgrading between major releases. 

If you are tasked to **in-place upgrade** RHEL 7 to 8 at your workplace, think twice. The best practice is now containerization.

#  Modern updates

1. Docker offers clear application isolation in containers
2. CoreOS / AWS ECS / Kubernetes offers a minimal Docker container runtime

In-place updating the underlying operating system and hoping the application will still work is like a game of Jenga. The modern best practice requires an immutable Docker container runtime OS and the Application containers it runs.

Your application's **data** must be split out too, resulting in the modern [Three-tier architecture](https://docs.aws.amazon.com/whitepapers/latest/serverless-multi-tier-architectures-api-gateway-lambda/three-tier-architecture-overview.html) paradigm:

1. Client Web browser - typically everygreen on consumer devices
2. Server - Docker container runtime - updating the Operating System by ID, e.g. via [AMI ID](https://aws.amazon.com/blogs/compute/query-for-the-latest-amazon-linux-ami-ids-using-aws-systems-manager-parameter-store/)
3. Data - Seperate and managed like AWS RDS / S3

# Cattle, not pets

Pets are patched and groomed. Cattle can be culled and replaced at any time.

The data tier aside, updating is now a matter of choosing your OS and Application image identifer. Automated by <abbr title="Continuous Delivery">CD</abbr> pipelines.

* No patches
* Trivial to roll back
* Immutable

A load balancer with container orchestration needs to be in place to have a container ready to serve requests when a member of the cattle is being replaced.

# The only constant is change

Most companies are transitioning to modern deployment practices which requires retiring the old patching processes.

For example your Devops team should not be "hardening" (aka patching) images or waiting for "audits" to happen. Frequent updates via CI/CD infrastructure must to be in place to create the image artefacts and automate / "shift left" the checks. 

Now everything is transparent in a robust reproduciable build pipeline with tests, and not an _after the fact_ ah-hoc patch.