---
title: Scalable Prometheus Architecture
date: 2021-08-10T18:02:38+08:00
description: What might a scalable monitoring architecture look like?
---

[Prometheus](https://prometheus.io/) "prom" is the industry standard ecosystem within
the observability space for metrics collection. Essentially it's a time series
database queried typically via <https://grafana.com/>. Architecture
considerations come into play if you have extreme requirements, however most of
the time you are scraping / collecting metrics via "metric exporters" between
AWS accounts.

You are sampling, you are looking to **observe trends**. My philosophy is that
it's not healthy to stare at metrics coming in and try to make real time
decisions. Quick decisions are probably made off **events** from your Cloud provider!

Metrics **are not events**, metrics are for observing trends and pre-empt any
Site Reliability issues! This is good <abbr title="Site Reliablity
Engieering">SRE</abbr>, not fire fighting!

# Normal "observability" Architecture

Metrics are fed (scraped) back to a central "observability" account for shared analysis.

<a href="https://excalidraw.com/#json=6682998946660352,FzHJccXZegxPIFJ-XOH3lQ">
<img alt="Standard Prometheus Architecture" src="https://s.natalian.org/2021-08-11/standard.svg">
</a>

# The highly scalable Architecture

You probably do not need https://thanos.io/ unless you are a Unicorn, maybe.
With a dangerous fetish for data retention.

<a href="https://excalidraw.com/#json=5031494363906048,xfbeeWO2VqTl1LuTnnMXdQ">
<img alt="Scalable Prometheus Architecture" src="https://s.natalian.org/2021-08-11/extreme.svg">
</a>

Unfortunately Thanos/Cortex/AWS encourage ingesting metrics via a **push** [remote
write](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-onboard-ingest-metrics.html),
which hits up against [Prometheus hierarchical
federation](https://prometheus.io/docs/prometheus/latest/federation/#hierarchical-federation). [Example on how to scrape via Federation...](https://github.com/kaihendry/debugprom#how-to-federate-particular-metrics) / aka aggregated metrics.

# ❤️Scraping is good, why?

<img src="https://s.natalian.org/2021-08-12/prom-scrape.png" alt="Prom targets">

* Prom is designed to [pull rather than push](https://prometheus.io/docs/introduction/faq/#why-do-you-pull-rather-than-push)
* It's easier to debug when things are going wrong from /targets ! Endpoints should be addressable, if they are not, it's like blocking ICMP (completely daft)
* You don't need to worry about being overwhelmed, as with scraping, you are always in control. Perhaps can be be argued with the [Robustness Principal](https://en.wikipedia.org/wiki/Robustness_principle)
