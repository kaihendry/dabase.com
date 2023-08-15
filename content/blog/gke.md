---
title: Google Kubernetes Engine on GCP
date: 2023-08-02T11:01:24+01:00
description: Fixing observability on a GKE Autopilot cluster when Policy for Disable Automatic IAM Grants for Default Service Accounts is enabled
---

On https://console.cloud.google.com/apis/dashboard if you notice errors, well then you have a problem!

<img src="https://i.imgur.com/sAtKS8p.png" alt="100% error rate">

<img src="https://i.imgur.com/Obhyavl.png" alt="No data is available for the selected time frame.">

After some searching I found https://cloud.google.com/stackdriver/docs/solutions/gke/troubleshooting#write_permissions

We need to roles to the service account via [IAM](https://console.cloud.google.com/iam-admin/iam):

1. Logs Writer aka roles/logging.logWriter
2. Monitoring Metric Writer aka roles/monitoring.metricWriter
3. Stackdriver Resource Metadata Writer aka roles/stackdriver.resourceMetadata.writer

How do I find the default service account? 

    gcloud iam service-accounts list | grep "default service"
    Compute Engine default service account      XXXXXXXXX-compute@developer.gserviceaccount.com False

To add permissions:

1. https://console.cloud.google.com/iam-admin/iam
2. GRANT ACCESS
3. Use the Principal XXXXXXXXX-compute@developer.gserviceaccount.com aka the **Compute Engine default service account** Principal
4. Assign the roles/logging.logWriter, roles/monitoring.metricWriter, roles/stackdriver.resourceMetadata.writer roles

How to verify the permissions are there:

    gcloud projects get-iam-policy $(gcloud config get-value project)  --flatten="bindings[].members" --format='table(bindings.role)' --filter="bindings.members:XXXXXXXXXX-compute@developer.gserviceaccount.com"
    ROLE
    roles/logging.logWriter
    roles/monitoring.metricWriter
    roles/stackdriver.resourceMetadata.writer