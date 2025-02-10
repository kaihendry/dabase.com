---
title: "Devops Is Dead"
date: 2022-08-29T20:43:07+08:00
description: When do you need a Platform team
---

{{< x user="sidpalas" id="1551936840453820417" >}}

1. Treat the Internal Developer Platform as a product!
1. Enable self-service!
1. Provide structure and standardization!

Sid makes some good points about [the developer comfort
zone](https://twitter.com/sidpalas/status/1551936875216134147).

My take is that the Cloud that at least AWS/GCP/Azure is certainly
uncomfortable.

In an ideal world you could give a developer team an account with managed
services like lambda, s3, cloudwatch and dynamodb... and **everything else
turned off**!

That would inevitably provide:

1. Self service
2. Provide structure and standardization

And a bonus is that you would **not need to an Internal Developer Platform**, aka "Platform team".

# We don't live in an ideal world

Inevitably you need to run container workloads and spin up an RDS.

Then you fall down the black hole of complexity that in Kubernetes, the lowest
common denominator.

Of course k8s does everything, including spinning up resources like via https://kubevela.io/ or https://aws.amazon.com/blogs/containers/aws-controllers-for-kubernetes-ack/.

It can be done well with Gitops, though inevitably it's not.

It's not self service when an App team needs to make a Pull Request / Merge Request.

I don't think you can call it a **Internal Product Team** when there is no
choice.
