---
title: Devops Evolution
date: 2016-07-18 17:11:38 +0800
description: Explaining how Devops is changing over time
---

Related content: [No dist-upgrade](/blog/2023/no-dist-upgrade/)

<img src="https://s.natalian.org/2020-12-03/spectrum.jpeg" alt="The Spectrum of Compute">

Ignoring the complexities surrounding data.

# Phase 1

Manual everything.

Not scalable at all. Well it might be surprisingly scalable if the code is well
engineered, since everything is so simple! ;)

Probably never reboots, despite updates (e.g. Linux) requiring it.

# Phase 2

Using a [Configuration
Management](https://en.wikipedia.org/wiki/Configuration_management) tool like
Chef, Puppet or Ansible.

Scalability achieved with AMI snapshots and such. Zero downtime with a [load
balancer](https://aws.amazon.com/elasticloadbalancing/) fronting at least two
instances running your App independently of one another.

Updates are applied before making a new AMI image. Latest AMI images are
applied haphazardly.

# Phase 3

Using <abbr title="Platform as a Service">PaaS</abbr> like
[Dokku](https://github.com/dokku/dokku), so a developer can `git push` to a
"[Heroku-ish](https://github.com/gliderlabs/herokuish)" endpoint.

Probably can't scale very well. Zero downtime can be achieved cheaply using
[some
tricks](http://dokku.viewdocs.io/dokku/deployment/zero-downtime-deploys/).
Probably best solution for personal projects or starting out since it's fairly
simple.

Probably never reboots or applies security updates properly.

# Phase 4

Using Docker & containerizing all the things on something like
[CoreOS](https://aws.amazon.com/lambda/details/) or RancherOS. Scalability is
as manual as making sure you can quickly spin up new CoreOS instances & run the
Docker images with a load balancer in front.

Bonus points if you have moved from Postfix <abbr title="Mail transfer
agent">MTA</abbr> to an external Restful mail API or queue.

Bonus points is if one has figured out how to get a <abbr title="Continuous
Integration">CI</abbr> to build the image and deploy it.

Bonus points for running two instances for Blue/Green deployments behind the
load balancer for zero downtime.

Serious kudos if you manage to orchestrate your updates with [etcd
locks](https://coreos.com/os/docs/latest/update-strategies.html) and have no downtime.

# Phase 5

Orchestrating Docker deployments with [Docker
Compose](https://docs.docker.com/compose/), using things like <a href="http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_Console_Repositories.html">AWS <abbr
title="Elastic Container Repository">ECR</abbr> (private Docker image hosting)</a>
and AWS <abbr title="Elastic Container Service">ECS</abbr> for managing the
containers on EC2.

Tip: Getting into ECS like myself? Checkout [ECS questions](/blog/ECS_questions/) or [AWS ECS Workflow](/blog/AWS_ECS_Workflow/).

Scales in a complex way (worry about bother Container & Instance utilisation
and timings), providing you have [Service Auto Scaling in your
region](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-auto-scaling.html).

# Phase 6

<iframe width="560" height="315" src="https://www.youtube.com/embed/l08c8uQJL_o?ecver=1" frameborder="0" allowfullscreen></iframe>

Serverless computing?
[FaaS](https://en.wikipedia.org/wiki/Function_as_a_Service)! [AWS
Lambda](https://aws.amazon.com/lambda/details/).  It's not without servers of
course, it more of a *managed Containers* or *dynamic server allocation*
solution.

Included with "serverless":

* A/B deployments
* Logging
* Optionally: API gateway is pretty sweet (basically you get Cloudfront integrated)

Most apps would probably have to be completely rewritten and somewhat tied to
the hosting platform's API.
