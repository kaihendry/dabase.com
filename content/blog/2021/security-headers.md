---
title: "Security Headers"
date: 2021-10-05T12:35:34+08:00
description: Bug bounty scams
---

<img src="https://s.natalian.org/2021-10-05/fail.png" alt="failed at pollution">

{{< x user="kaihendry" id="1445240044491476996" >}}

Dubious sites like "securityheaders.com" will give you a big fat F without a whole bunch of headers.

# Plot twist

## Assuming API endpoint of native app

> My favourite thing is when penetration testers or security scanners complain
> about missing headers like CSP on backend API endpoints that are never called
> a browser.

https://twitter.com/ineffyble

- Strict-Transport-Security - not relevant; https hard coded
- Content-Security-Policy - not relevant, **client not a browser**
- X-Frame-Options - not relevant, **client not a browser**
- X-Content-Type-Options - not relevant, **client not a browser**
- Referrer-Policy - not relevant, **client not a browser**
- Permissions-Policy - not relevant, **client not a browser**

# Adding headers on AWS

tl;dr a PITA -- from AWS Support

Custom response headers is not a native feature built into CloudFront at the
time writing, which means that you need to rely on a feature or service that
allows arbitrary modifications to responses. Currently, this is only allowed by
Lambda@edge or CloudFront functions.

The latter is a recently introduced alternative to Lambda@edge with lower
pricing that allows basic transformations to your requests or responses using
Javascript, and they can only be triggered at viewer requests and responses.
Therefore, if Lambda@edge pricing is your concern, you may write and attach a
CloudFront function triggered at viewer response to achieve this use case.

There are differences in CloudFront functions' event structure[1] and the
accepted function signature[2], please review the documentation links and
examples[3] for more information. Pricing information is available on the main
pricing page[4].

1. https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/functions-event-structure.html
2. https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/writing-function-code.html
3. https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/functions-example-code.html
4. https://aws.amazon.com/cloudfront/pricing/#CloudFront_Functions_Pricing_Details
