---
title: DORA metrics
date: 2023-07-18T16:24:21+01:00
description: Understanding DevOps Research and Assessment
---

For measuring the maturity of a DevOps organisation, there are four key metrics:

1. Lead time
2. Frequency of deployment
3. Mean time to failure
4. Mean time to recovery

There do not have to be accurate! They are a guide to help your delivery improve.

## Lead time and frequency of deployment

How fast can you deliver a change? How often do you deploy?

Closely related since the smaller the change, the quicker you can deliver.

# Mean time to failure

<img src="https://s.natalian.org/2023-07-18/Comparison-between-different-traditional-and-digital-safety-scoreboards.png" alt="Days since last failure">

This is often misunderstood, what we are looking for is **customer impact**. 

If a <abbr title="Continuous Integration">CI</abbr> pipelines fails, but the customer is not impacted, then this is not a failure.

If we do a canary deployment which fails, but the customer by large is not impacted, then this should not be considered a failure.

This is not quite the same as a constructions site's X days since failure, since we want to set a period of time, so we can work on improving our processes.

# Mean to recovery

How quickly can you recover from a failure?

Should be a small as possible, as it would lessen the impact of the failure.