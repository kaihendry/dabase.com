---
title: Scalable Prometheus Architecture
date: 2021-08-10T18:02:38+08:00
description: What might a scalable monitoring architecture look like?
---

[Prometheus](https://prometheus.io/) is the industry standard ecosystem within
the observability space for metrics collection. Essentially it's a time series
database queried typically via <https://grafana.com/>. Architecture
considerations come into play if you have extreme requirements, however most of
the time you are scraping / collecting metrics via "metric exporters" between
AWS accounts.

You are sampling, you are looking to **observe trends**. It's not healthy to
stare at metrics coming in and try to make real time decisions. Observe trends
and pre-empt any Site Reliability issues! This is good <abbr title="Site
Reliablity Engieering">SRE</abbr>, not fire fighting!

# Normal "observability" Architecture

Metrics are fed back to a central "observability" account for shared analysis.

<a href="https://excalidraw.com/#json=6682998946660352,FzHJccXZegxPIFJ-XOH3lQ">
<img alt="Standard Prometheus Architecture" src="https://s.natalian.org/2021-08-11/standard.svg">
</a>

# The highly scalable Architecture

You probably do not need https://thanos.io/ unless you are a Unicorn, maybe.
With a fetish for data retention.

<a href="https://excalidraw.com/#json=5031494363906048,xfbeeWO2VqTl1LuTnnMXdQ">
<img alt="Scalable Prometheus Architecture" src="https://s.natalian.org/2021-08-11/extreme.svg">
</a>
