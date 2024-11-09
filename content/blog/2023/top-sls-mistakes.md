---
title: Top serverless mistakes
date: 2023-06-30T10:32:22+01:00
description: What mistakes are people making when adopting serverless?
toc: true
---

## Using API gateway routing instead of a catchall

<abbr title="Also known as">Aka</abbr> Functions calling each other directly/coupling functions 

<abbr title="Also known as">Aka</abbr> [using Step Functions](https://www.primevideotech.com/video-streaming/scaling-up-the-prime-video-audio-video-monitoring-service-and-reducing-costs-by-90) 🤦‍♂️

<abbr title="Also known as">Aka</abbr> **splitting up a application for no good reason** and not practicing [Monolith First](https://martinfowler.com/bliki/MonolithFirst.html)

      Events:
        CatchAll:
          Type: HttpApi
          Properties:
            ApiId: !Ref Gateway
            Path: /{proxy+}
            Method: ANY

**Putting the whole application into one lambda is best practice** in my eyes and is also known as "fat lambdas" by some.

## Not keeping to the standard http interface

<abbr title="Also known as">Aka</abbr> breaking local development

For Javascript users, use [serverless-http](https://www.npmjs.com/package/serverless-http) to abstract away the awkward AWS Lambda interface.

For Go users, use [Apex Gateway v2](https://github.com/apex/gateway)

And whilst I have your attention, please use structured logs!

## Not using a framework

<abbr title="Also known as">Aka</abbr> using Terraform or Cloudformation for orchestrating lambdas and finding it awkward.

Leveraging the AWS runtime requires some boilerplate to:

* Setup a role & policy
* Setup a lambda runtime
* Setup a bucket for the code

Doing this from [scratch (or in Terraform) is error prone and time consuming](https://github.com/kaihendry/terraform-aws-canary/).

I recommend using [AWS SAM](https://github.com/kaihendry/helloworld) <abbr title="Also known as">Aka</abbr> `AWS::Serverless-2016-10-31`.

---

Thanks for contributing [Rich Buggy](https://twitter.com/richdevelops/status/1673961925007544321), [Yan Cui](https://twitter.com/theburningmonk/status/1673967556984553474) & [Jordan Finneran](https://twitter.com/JordanFinners/status/1673952407057727488)!