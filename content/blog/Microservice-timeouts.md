---
title: Microservice Timeouts
date: 2021-02-09T14:20:32+08:00
description: My microservice architecture is timing out
---

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
