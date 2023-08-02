---
title: Google Kubernetes Engine on GCP
date: 2023-08-02T11:01:24+01:00
description: Fixing observability on GKE Autopilot cluster
---

On https://console.cloud.google.com/apis/dashboard if you notice errors, well then you have a problem!

<img src="https://i.imgur.com/sAtKS8p.png" alt="100% error rate">

Unfortunately there are no logs as to what is causing the errors, so you have to dig around a bit.

I know from examining the workloads https://console.cloud.google.com/kubernetes/workload/overview that I cannot see:
* Metrics
* Logs

<img src="https://i.imgur.com/Obhyavl.png" alt="No data is available for the selected time frame.">

After some searching I found https://cloud.google.com/stackdriver/docs/solutions/gke/troubleshooting#write_permissions

So now I need to add to [IAM](https://console.cloud.google.com/iam-admin/iam):

1. Logs Writer aka roles/logging.logWriter
2. Monitoring Metric Writer aka roles/monitoring.metricWriter
3. Stackdriver Resource Metadata Writer aka roles/stackdriver.resourceMetadata.writer

To the service account that is running the pods. But what is it?

    gcloud iam service-accounts list

There could be many service account emails. Which is associated with the cluster is unclear.

    gcloud projects get-iam-policy $(gcloud config get-value project)  \
    --flatten="bindings[].members" \
    --format='table(bindings.role)' \
    --filter="bindings.members:$1"

Output might look like:

    ROLE
    roles/artifactregistry.createOnPushWriter
    roles/artifactregistry.reader
    roles/container.admin
    roles/container.clusterViewer
    roles/logging.logWriter
    roles/monitoring.metricWriter
    roles/stackdriver.resourceMetadata.writer
    roles/storage.admin

And it still doesn't work.

Browsing [cluster info](https://console.cloud.google.com/kubernetes/list/overview) or the [workloads](https://console.cloud.google.com/kubernetes/workload/overview) surprisingly gives no hint as to which service account they are using.

## Getting an overview

    gcloud projects get-iam-policy $(gcloud config get-value project)