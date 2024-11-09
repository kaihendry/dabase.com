---
title: Github Action Trunk based development IaC
date: 2024-05-24T13:10:33+01:00
description: A path to production using trunk based development for infrastructure as code
---

We focus on **trunk based development** on **main**, with a re-usuable Github workflow hiding the [details of the deployment](https://github.com/Azure-Samples/terraform-github-actions): 

```yaml
name: CI/CD done right

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
    deploy-to-dev:
        name: Deploy to dev
        uses: ./.github/workflows/deploy.yml
        permissions:
            id-token: write
            contents: read
            pull-requests: write
        with:
            environment: dev

    test-dev:
        uses: ./.github/workflows/test.yml
        needs:
            - deploy-to-dev
        permissions:
            id-token: write
            contents: read
            pull-requests: write
        with:
            environment: dev

    deploy-to-stg:
        name: Deploy to stg
        needs:
            - test-dev
        uses: ./.github/workflows/deploy.yml
        permissions:
            id-token: write
            contents: read
            pull-requests: write
        with:
            environment: stg

    test-stg:
        uses: ./.github/workflows/test.yml
        needs:
            - deploy-to-stg
        permissions:
            id-token: write
            contents: read
            pull-requests: write
        with:
            environment: stg
```

Notice dev must succeed before staging (stg) can run. Tests form a safety net before promotion.

# oidc-setup/ for GCP and Github Actions

For each environment, we need to bootstrap the OIDC setup for each environment. The repo name is critical and the outputs:
* `service_account_email` to SVCACCOUNT
* `workload_identity_provider` maps to the WORKLOAD variable

<img src="https://s.natalian.org/2024-05-27/vars.png">

# Approval for production

<img src="https://s.natalian.org/2024-05-27/prd.png">

Use Github's environment **protection rules** to ensure we don't deploy to production without approval.

View the [full Terraform example on Github](https://github.com/kaihendry/trunk-terraform/).
