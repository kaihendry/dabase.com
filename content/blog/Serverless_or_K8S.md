---
title: Serverless or CNCF Kubernetes?
date: 2022-01-31T09:56:37+08:00
description: Reacting to Go serverless or stay on Kubernetes for deploying microservices?
---

{{< youtube qjTiNTu1A9w >}}

[tl;dw version](https://m.economictimes.com/tech/technology/thoughtworks-xconf-tech-talk-series-serverless-vs-kubernetes-when-deploying-microservices/amp_articleshow/89085544.cms)

My main feedback is that it appears to compare the two platforms in the context
of **heavy loads** and **microservices**.

- heavy loads -- not the typical use case
- microservices -- serverless I feel (perhaps wrongly) is cast as a
  "microservice" platform. It's not! I personally run entire monoliths on
  serverless platforms, no problems.

# In comparison to Kubernetes

## Scaling

https://youtu.be/qjTiNTu1A9w?t=1499

In my experience the K8S autoscaler is complex, unreliable and doesn't scale
[without capacity planning](https://youtu.be/qjTiNTu1A9w?t=1863). Serverless is
much simpler and it scales without thinking about it.

For example with k8s you typically need some extra nodes to scale. So in your
cluster you are paying for resources you do not use.

## Observability

https://youtu.be/qjTiNTu1A9w?t=1559

Kubernetes observation is massively complex and the lines are often blurred between App and Ops.

Serverless applications typically utilise the native cloud native solution
like AWS Cloudwatch. No need for an "observability team".

## Deployment strategies

https://youtu.be/qjTiNTu1A9w?t=1682

Deploying with Serverless is radically simpler compared to different HTTP
ingress / meshing solutions for k8s. Furthermore deploying and _rolling back_ serverless
functions typically take <5s!

Measure a roll out an Application on a typical k8s cluster. It will not be less
than five seconds!

## Infrastructure costs

https://youtu.be/qjTiNTu1A9w?t=1828

1.5 millions transactions with three seconds execution time I think is
unrealistic. Three seconds for a transaction is unacceptable for most Web
applications. In startups I've worked at, the upper threshold was more like
150ms.

## Total cost of Ownership

<img src="https://s.natalian.org/2022-01-31/tco.png" alt="Total cost of ownership of k8s vs serverless">

Although "serverless" won the contest above, in my experience, employing the
"devops" teams running Kubernetes can be huge.

{{< tweet user="nathankpeck" id="1466617249419051010" >}}

The k8s maintenance cost per month of ~4k is unrealistic.

I have observed Kubernetes setups where there is a team to manage the k8s
cluster, an ops team to manage the running applications and an observability
team. Nevermind the application developers!

The above serverless maintenance (and infrastructure) cost of ~3k is also
unrealistic, it's closer to single digit dollars in my experience.

It's not atypical to see three engineers able to develop, run and observe their
application on the serverless platform, this a dramatic saving to <abbr
title="Total Cost of Ownership">TCO</abbr>!

The <abbr title="Total Cost of Ownership">TCO</abbr> chart in my mind could be
better focused on accounting for people's time.

# Reacting to the Key takeaways

## Standardization. Vendor Lock-In.

> Standardization/vendor lock-in: there is no Cloud Native Computing Foundation
> (CNCF)-backed serverless codebase like there is for Kubernetes. Each provider
> has its own implementation and features. You will need to adapt to these
> differences.

There are libraries to pave over vendor specific interfaces & expose a typical
http interface, like
[serverless-express](https://www.npmjs.com/package/serverless-express) or [Go's
Lambda Gateway](https://github.com/apex/gateway/). The cost is a couple of
lines of code and conforming to the **standard HTTP interface**.

    if awsDetected {
    	err = gateway.ListenAndServe("", s.router)
    } else {
    	err = http.ListenAndServe(fmt.Sprintf(":%s", os.Getenv("PORT")), s.router)
    }

Do please have a look at my [article where I can the same code running on all major cloud vendors with minimal code changes](https://dabase.com/blog/2020/serverless-speed/).

## Execution time

RE "Vendor Lock-In" and _No <abbr title="Cloud Native Computing Foundation">CNCF</abbr> mandated
"standardization"_, such as "Execution time" can be different between vendors. Who
cares if it's 9 or 30 minutes, when you are trying to serve a request as quick
as possible? My personal target is to be below 30ms, not 30 minutes!

## Cold starts

"Cold starts" are moot if your application is **in use**. Furthermore [cold
starts are getting faster and
faster](https://dabase.com/blog/2021/multi-cloud-serverless/) over time... < 0.5s!

And as mentioned in the [original
article](https://m.economictimes.com/tech/technology/thoughtworks-xconf-tech-talk-series-serverless-vs-kubernetes-when-deploying-microservices/amp_articleshow/89085544.cms),
there are good workarounds like AWS provisioned concurrency if your endpoint is
infrequently used and you need to save half a second.

## Limited support

Essentially no "language support" is needed if there is a clear interface to
running a native binary. This has been shown with AWS's new "provided.al2"
(Graviton runtime) which didn't support any language initially.

    Properties:
      Architectures:
        - arm64
      Handler: main
      Runtime: provided.al2

Serverless doesn't require a bloated packaging format like Docker images.
Essentially it can be an ELF binary, so it plays well with good practices
like [shipping one static binary](https://youtu.be/daPIjh2W1Qw).

## Security

The benefits of out of the box serverless security are understated. Why?

- Drastically simpler than Kubernetes
- Not long running (ephemeral)
- Managed underlying OS

If you're concerned about "multi-tenancy" you must have same qualms about
running EC2 workloads? It's the [same
technology](https://firecracker-microvm.github.io/).

# Conclusion

Despite my (overly) enthusiastic comments, I think we are all coming around to
the stark benefits of "serverless". Yes, we do have to think differently, the
mindset of fast booting **http transactions**, how we structure service
teams and [how we ship code](https://dabase.com/blog/2021/java-vs-go-load-test/).

For most workloads including monoliths and heavy loads, utilising serverless is
a great start! [Go build](https://github.com/kaihendry/go-web-dynamo-starter)!
