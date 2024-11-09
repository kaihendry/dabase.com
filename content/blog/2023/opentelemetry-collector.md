---
title: Opentelemetry Collector for Kubernetes
date: 2023-07-31T13:22:35+01:00
description: Setup hints for the Kubernetes collector for traces
---

The helm chart for
[open-telemetry/opentelemetry-collector](https://github.com/open-telemetry/opentelemetry-helm-charts/tree/main/charts/opentelemetry-collector)
is complex, not easy to use or debug.

Do note you need at a mininum a service with:

1. A receiver
2. A processor
3. An exporter

Or it just won't work.

Sample YAML:

    service:
      pipelines:
        traces:
          receivers: [otlp]
          processors: [batch]
          exporters: [otlp]

The listener is typically GRPC on port 4317.
