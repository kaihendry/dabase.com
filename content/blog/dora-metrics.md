---
title: DORA metrics failure
date: 2023-07-18T16:24:21+01:00
description: Failure needs to be treated as a learning opportunity
---

For measuring the maturity of a DevOps organisation, there are four key metrics:

1. Lead time
2. Frequency of deployment
3. Change failure rate aka <abbr title="mean time between failures">MTBF</abbr>
4. Mean time to recovery

These indicators do not have to be accurate! They are a guide to help your software delivery process improve.

## Lead time and frequency of deployment

How fast can you deliver a change? How often do you deploy?

Closely related since the smaller the change, the quicker you can deliver.

# Change failure rate

<img src="https://s.natalian.org/2023-07-18/Comparison-between-different-traditional-and-digital-safety-scoreboards.png" alt="Days since last failure">

This is often misunderstood, what we are looking for is **customer impact**. 

If a <abbr title="Continuous Integration">CI</abbr> pipelines fails, but the customer is not impacted, then this is not a failure.

If we do a canary deployment which fails, but the customer by & large is not impacted, then this should not be considered a failure.

This is not quite the same as a constructions site's X days since failure, since we want to set a period of time, so we can work on improving our processes and deliver!

# Mean to recovery

How quickly can you recover from a failure?

Should be a small as possible, as it would lessen the impact of the failure.

# What good looks like

High performers:

1. Deploy multiple times a day
2. Lead time is less than an hour
3. Change fail rate is less than 10%
4. Mean time to recovery is less than a minute

Change fail rate as noted by the book [Accelerate](https://www.amazon.co.uk/Accelerate-Software-Performing-Technology-Organizations/dp/1942788339), might be higher in medium/high performers, since they are more likely to be experimenting than low performers. 😳

If you are not failing, you are not trying hard enough. However if you are making the same mistake, you are missing tests!