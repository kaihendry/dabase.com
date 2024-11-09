---
title: Microservice Timeouts
date: 2021-02-09T14:20:32+08:00
description: My microservice architecture is timing out
---

{{< youtube clagrT5BC7g >}}

I'm still cynical since my earlier [poor Microservice pattern
experience](https://natalian.org/2019/05/16/Microservices_pitfalls/),
nonetheless I see the pattern increasingly.

Microservices are attractive to people familiar with the Unix philosophy:

- Do one thing and do it right
- Separation of ownership -- each service can have clear ownership and
boundaries, allowing the service owner to operate and make deployments
independently from each other
- Universal interface between them

However...

# Microservices fail often

<img src="https://s.natalian.org/2021-02-09/basic.png" alt="basic microservice sequence diagram">

	@startuml
	"Purchase" -> "Auth" : Check user
	"Auth" --> "Purchase" : 2s
	"Purchase" -> "Payment" : Deduct balance
	"Payment" --> "Purchase" : 2s
	"Purchase" -> "Provision" : Supply
	"Provision" --> "Purchase" : 3s
	@enduml

APIs without a <abbr title="Service Level Objectives">SLO</abbr> & a
strict [response time
budget](https://www.atlassian.com/incident-management/kpis/sla-vs-slo-vs-sli),
inevitably have response times that grow. And don't forget unavoidable **network issues**!

So in the above case we can easily timeout, aka **504 Gateway Timeout**.

What are the approaches to handle this case?

1. Introduce a queue to retry
2. Make the purchase API asynchronous
3. Monitor the APIs to start strictly enforcing low response times
4. Introduce caching
5. Make the API idempotent

Each of these solutions are actually very hard to implement!

1. Queues sound trivial, but they are not. You need AWS SQS with support for <abbr title="Deadletter queues">DLQs</abbr>
2. Asynchronous APIs often require a callback, which require addressable endpoints
3. Monitoring each API via Prometheus / Grafana is non-trivial .. you will go down a rabbit hole when it comes to distributed tracing
4. Caching is hard
5. To make an API idempotent aka "retry-abble", often you need to store state so you know where you left off

Let's imagine the Payment API also has microservice dependencies:

<img src="https://s.natalian.org/2021-02-09/mm.png" alt="Microservices calling microservices">

	@startuml
	"Purchase" -> "Auth" : Check user
	"Auth" --> "Purchase" : 2s
	"Purchase" -> "Payment" : Take payment
	"Payment" -> "Account" : Check balance
	"Account" --> "Payment" : 1s
	"Payment" -> "Account" : Deduct balance
	"Account" --> "Payment" : 1s
	"Payment" --> "Purchase" : 2s
	"Purchase" -> "Provision" : Supply
	"Provision" --> "Purchase" : 3s
	@enduml

# Distributed systems are really hard

1. Microservices delegate things outside their domain, and introduce inter dependencies
1. There isn't a Universal interface. REST/HTTP is great for synchronous, but what happens when you need to go asynchronous?

# [Rebuttal via a YT comment](https://www.youtube.com/watch?v=clagrT5BC7g&lc=Ugw47ke7wwObvTbduAh4AaABAg)

Luis Santos correctly points out the bad practices here:

1. Using Queues without proper monitoring or a deadletter strategy
2. Not having proper monitoring
3. Neglecting performance
4. Sharing a database between services
5. Distributed transactions
6. Incorrect service boundaries (this is cause of the previous 2 bad practices)

> Regarding the idempotence problem. You don't need a cache. You just need to
> take advantage of your database optimistic locking mechanisms.  You could use
> something like upsert, insert ignore or a [conditional
> insert](https://github.com/apex/gh-polls/blob/820156017c1e3de466a6efa5b078c2be9d692f67/internal/poll/poll.go#L155).

I'm not sure "Sharing a database between services" (read-only) is such a bad
practice. Since duplicate data on several databases can be far worse.
