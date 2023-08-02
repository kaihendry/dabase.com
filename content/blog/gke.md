---
title: Google Kubernetes Engine on GCP
date: 2023-08-02T11:01:24+01:00
description: Fixing observability on GKE Autopilot cluster
---

On https://console.cloud.google.com/apis/dashboard is you notice errors, well then you have a problem!

<img src="https://i.imgur.com/sAtKS8p.png" alt="100% error rate">

Unfortunately there are no logs as to what is causing the errors, so you have to dig around a bit.

I know from examining the workloads https://console.cloud.google.com/kubernetes/workload/overview that I cannot see:
* Metrics
* Logs

<img src="https://i.imgur.com/Obhyavl.png" alt="No data is available for the selected time frame.">

After some searching I found https://cloud.google.com/stackdriver/docs/solutions/gke/troubleshooting#write_permissions

So now I need to add:

1. Logs Writer
2. Monitoring Metric Writer
3. Stackdriver Resource Metadata Writer

To the service account that is running the pods. But what is it?