---
title: Github Action Trunk based development IaC
date: 2024-05-24T13:10:33+01:00
description: A path to production using trunk based development for infrastructure as code
---

    name: CI/CD

    permissions:
      contents: read
      id-token: write
      actions: read

We focus on **trunk based development**, with `./.github/workflows/deploy.yaml` hiding the [details of the deployment](https://github.com/Azure-Samples/terraform-github-actions): 

    on:
      push:
        branches:
          - main

    jobs:
      deploy-to-dev:
        name: Deploy to dev
        secrets: inherit # to pass on the secrets to the deploy action
        uses: ./.github/workflows/deploy.yaml
        environment:
            name: dev

      deploy-to-stg:
        name: Deploy to stg
        secrets: inherit

Notice we don't deploy to staging unless we managed to deploy to dev first:

        needs:
          - deploy-to-dev
        environment:
            name: stg
        uses: ./.github/workflows/deploy.yaml
        with:
          environment: stg

Ensure we deploy the same version that we deployed to dev:

          version: ${{ needs.deploy-to-dev.outputs.version }}

