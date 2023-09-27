---
title: "Gitops"
date: 2023-09-27T10:17:45+01:00
description: Platform engineering using Gitops
---

<img src="https://s.natalian.org/2023-09-27/gitops.png">

Gitops in practice is characterised by a Kubernetes custom resource (CRD) that takes the Developer's infrastructure resource requests (checked in YAML) and provisions them.

The platform team limits the CRD requests in the form of Composite Resource Schema to a small set of approved resources to better manage the platform.

Typically Flux or ArgoCD, a Kubernetes controller polls the Git repository for changes and applies them to the cluster.

This pull approach is useful for creating clear separation of concerns between specifying an application to deploy and its configurations by the developers and how it's deployed, including permissions and controls needed.

The cons of this approach is that it's not real time and strong observability capability is required to understand what's going on. For example if there is any "drift" between the desired state and the actual state.

Negatives are that the Platform complexity is increased by the need to manage the Kubernetes Clusters, the controllers (argocd/flux), the CRD schema (typically an [abstraction defined by Crossplane](https://marketplace.upbound.io/providers/upbound/provider-aws-lambda/v0.40.0/resources/lambda.aws.upbound.io/Function/v1beta1)), and the nuances around Continuous Delivery.

The build artifacts are typically handled out of band in a central location, and referenced by the YAML desired state. This increases complexity co-ordinate an update/rollback and if there is any problem with the build artifact.