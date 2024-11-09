---
title: Deploying a Lambda
date: 2023-10-10T13:11:13+01:00
description: Breaking down what AWS SAM does
---

[AWS SAM](https://aws.amazon.com/serverless/sam/) has a guided deployment mode, which is also triggered by `--resolve-s3`, which abstracts: 

1. sam build
2. sam package
3. sam deploy

`sam sync` also effectively does the same as the above.

## sam build

`sam build` parses the `template.yaml`, builds the code and creates a `.aws-sam` directory with the artifacts and exports `template.yaml`.

## sam package

`sam package` takes the `template.yaml` and uploads the artifacts to S3 into a zip file.

## sam deploy

`sam deploy` takes the `template.yaml` and creates a CloudFormation stack. It also replaces the `CodeUri` with the S3 location.