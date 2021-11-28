---
title: Where is the source of AWS services?
date: 2021-11-27
description: What is the source from which AWS APIs and language bindings are generated from?
---

When boto updates:
https://github.com/boto/botocore/commit/d9d692f7a350417480f8eb9592d8b0c936b6825a

Or the AWS GO SDK updates:
https://github.com/aws/aws-sdk-go-v2/pull/1507

Where are the original **models**?


Is it the [CloudFormation resource provider schemas](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-type-schemas.html)?

After a [frantic search it would appear to be an XML based **Coral** is how AWS sources a service](https://news.ycombinator.com/item?id=25238216).

With the future to be https://awslabs.github.io/smithy/ ?
