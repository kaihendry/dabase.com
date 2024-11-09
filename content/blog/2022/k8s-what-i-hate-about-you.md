---
title: "Kubernetes What I Hate About You"
date: 2022-07-29T10:05:54+08:00
draft: true
---

# The multi-cloud option

[Multi-Cloud is the worst
practice](https://www.lastweekinaws.com/blog/multi-cloud-is-the-worst-practice/)
and that's more often than not, the **reason why management** choose
Kubernetes.

If all our workloads are described as Kubernetes objects, it should be trivial
to move to another cloud provider, right?

Wrong.

# Kubernetes is not for stateful workloads

Do not run a database or a store in Kubernetes!

# Kubernetes sucks you in

# Tooling is a mess

Helm, Kustomize, ArgoCD... how are you templating your YAML? In an crazy amount
of ways which is annoying to debug.

# Operators - including the kitchen sink

Since you can do complex things with Kubernetes like orchestrate serveral
services with a manifest, it does not mean you should!

A lot of Kubernetes "operators" especially just introduce a crazy amount of
complexity. Now you are running four instances of Redis no time at all.
