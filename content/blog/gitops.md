---
title: Gitops
date: 2023-09-27T10:17:45+01:00
description: Platform engineering using Gitops
---

<img src="https://s.natalian.org/2023-09-27/gitops.png">

# Platform team needs

Kubernetes clusters, typically one cluster for each environment.

Gitops "pulls" Developer's infrastructure resource requests "desired state" that is checked into git and continuously applies them to the cluster.

The platform team limits requests in the form of Composite Resource Schema to a small set of approved / default resources to better manage the platform.

A Kubernetes controller polls (typically Flux or ArgoCD) the Git repository for changes and applies them to the cluster using some sort of path structure, typically values.$env.yaml

This pull approach is useful for creating clear separation of concerns between specifying an application to deploy and its configurations by the developers and how it's deployed, including permissions and controls needed.

The cons of this approach is that it's not real time and a strong observability capability to understand what's going on. For example if there is any **drift** between the desired state and the actual state.

Cons to Gitops are that the Platform complexity needed to manage the Kubernetes Clusters, the controllers, the CRD schema (typically an [abstraction defined by Crossplane](https://marketplace.upbound.io/providers/upbound/provider-aws-lambda/v0.40.0/resources/lambda.aws.upbound.io/Function/v1beta1)), secrets, and the nuances around CI/CD pipelines.

The build artifacts are typically handled out of band in a central carefully managed location, and referenced by the YAML desired state. This increases complexity co-ordinate an update/rollback, retention and if there is any problem with the build artifact. Promoting and ensuring an artifact deployed into production went through proper testing.

# Developer needs

1. Documentation around the Composite Resource Schema (YAML)
2. A portal to search logs 
3. A portal to see metrics - e.g. what version of their application
4. A way to set secrets and tokens
5. A Continuous Integration pipeline to build their application that places the artifact in the right place