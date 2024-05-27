---
title: Github Action Trunk based development IaC
date: 2024-05-24T13:10:33+01:00
description: A path to production using trunk based development for infrastructure as code
---

We focus on **trunk based development** on **main**, with a re-usuable Github workflow hiding the [details of the deployment](https://github.com/Azure-Samples/terraform-github-actions): 

```yaml
    name: CI/CD

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
            uses: ./.github/workflows/test.yml
            with:
                environment: dev

        deploy-to-stg:
            name: Deploy to stg
            needs:
                - deploy-to-dev
            uses: ./.github/workflows/test.yml
            with:
                environment: stg
```

Notice dev must succeed before staging (stg) can run. Ideally more tests form a safety net before we deploy to staging and production.

test.yml:

```yaml
name: Just testing

on:
  workflow_call:
    inputs:
      environment:
        description: The environment to run against
        type: string
        required: true

jobs:
    deploy:
      runs-on: ubuntu-latest
      environment: ${{ inputs.environment }}
      steps:
        - run: echo ${{ inputs.environment }}
        - run: echo ${{ vars.WORKLOAD }}
```

Notice WORKLOAD is set in the Github Action's environment.

<img src="https://s.natalian.org/2024-05-27/vars.png">

# Approval for production

<img src="https://s.natalian.org/2024-05-27/prd.png">

Use Github's environment **protection rules** to ensure we don't deploy to production without approval.

View the [full Terraform example on Github](https://github.com/kaihendry/bq-terraform/).