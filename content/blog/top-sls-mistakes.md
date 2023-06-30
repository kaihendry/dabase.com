---
title: Top serverless mistakes
date: 2023-06-30T10:32:22+01:00
description: What stops people from adopting serverless?
toc: true
---

## Using API gateway routing instead of a catchall

Aka Functions calling each other directly/coupling functions

Aka splitting up a monolith before you need to and not practicing [Monolith First](https://martinfowler.com/bliki/MonolithFirst.html)

      Events:
        CatchAll:
          Type: HttpApi
          Properties:
            ApiId: !Ref Gateway
            Path: /{proxy+}
            Method: ANY

## Not keeping to the standard http interface

Aka breaking local development

For Javascript users, use [serverless-http](https://www.npmjs.com/package/serverless-http) to abstract away the AWS Lambda interface.

For Go users, use [Apex Gateway v2](https://github.com/apex/gateway)

## Not using a framework

Aka using Terraform or Cloudformation for orchestrating lambdas and finding it challenging.

Leveraging the AWS runtime requires some boilerplate to:

* Setup a role & policy
* Setup a lambda runtime
* Setup a bucket for the code

Doing this from [scratch (or in Terraform) is error prone and time consuming](https://github.com/kaihendry/terraform-aws-canary/).

I recommend using [AWS SAM](https://github.com/kaihendry/helloworld) aka "AWS::Serverless-2016-10-31"