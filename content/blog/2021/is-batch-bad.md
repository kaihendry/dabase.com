---
title: Is Batch Bad?
date: 2021-03-03T17:22:15+08:00
description: A batch process should not be deprecated as soon as an API appears!
---

tl;dr A batch job **should NOT be be immediately deprecated** once an API
appears since the API will probably take quite some time to mature!

> We want a real time system! We need a single source of truth!

To share data between distributed systems you have a few choices:

1. Synchronise the data in a "batch" job (typically daily / overnight), and often a push (from the source) instead of a pull
2. Allow some (internal) database sharing via a "database-link" to query
3. Create a Restful <abbr title="Application Programming Interface">API</abbr> for the database, and fetch data from it

# Batch

Pros:

* Allows a large volume of data to be transferred
* Easy to debug, support and understand
* Can allow for further validation and sign off
* Can facilitate a **local cache**
* Transactional -- you have it ... or you don't
* Keeps your application simple

Cons:
* Might not be timely enough due to the stress on the system or some other legacy reason (import/export might require downtime!)
* Often needs co-ordination, batch window must align
* Can be out of date -- "wait until tomorrow please"
* Not a single source of truth, since the data might have since changed!
* Can the business really afford the data to be out of date?
* If done as a PATCH, it can be a bit too naive (cursor at wrong position)

# database-link

Pros:
* Real time
* Fast
* No need to worry about a sync
* Allows for powerful SQL queries
* "Single source of truth"

Cons:
* Could lose connection
* Should not be used on the Internet (Beyond Corp), only intranet
* Could overwhelm the database if read replicas not setup correctly
* Makes security people nervous because whole database could be dumped without fine-grained controls
* Might be a database protocol that's difficult to support

# API

Pros:
* Restful
* Realtime
* "Single source of truth"
* "Internet scale"

Cons:
* Hard to sync without really good design of the API
* **Slow** and chatty (an order of magnitude slower than a DB connection probably)
* Might be tricky to cache / scale etc
* Might be unreliable ... what happens when it fails / times out / returns an error code? Do you retry?
* Client has to become more complex to handle contracts / error cases
* If write/POST it needs to be idempotent so the API can be re-tried without side effects
* API _will be poorly_ designed (on first iteration) or simply not fit for purpose!
* Can't support complex SQL queries (GROUP BY) which could be simple with a database connection
* Synchronous / pull -- going into the future you really need to **event** (Kafka) to be "real time"

# Conclusion

If Enterprise grade reliability is required, I think the **resilience** that
_batch_ offers, is hard to beat. Distributed systems suffer from network
failures, and with batch you have plenty of time to make sure that's not an
issue if your business process can afford it. It is great to have a local copy
at hand to operate without dependencies in a fast manner. Batch jobs should not
be deprecated immediately when an API shows up.

<img alt="Why not both?" src="https://s.natalian.org/2021-03-03/why-not-both.gif">

The ideal solution during this transition is to probably have **batch as a
fallback** and **API** with a tight <abbr title="Service level
Objective">SLO</abbr> / budget. However it needs to be crystal clear to the
client how old the data is, as to not get the false impression that a fall back
result is "real time".

As the "real time" API matures, it's conceivable that the batch job can be
deprecated in favour of just using the API to cache some results up front, i.e.
use the API to batch.
