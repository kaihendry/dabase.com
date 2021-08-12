---
title: Scalable Prometheus Architecture
date: 2021-08-10T18:02:38+08:00
description: What might a scalable monitoring architecture look like?
---

**tl;dr** don't focus on real time, metrics are not events, scrape don't push

[Prometheus](https://prometheus.io/) "prom" is the industry standard ecosystem
within the observability space for metrics collection. Essentially it's a time
series database queried typically via <https://grafana.com/>. Architecture
considerations come into play if you have extreme requirements, however most of
the time you are scraping / collecting metrics via "metric exporters" between
AWS accounts.

You can architect Proms to be in a hierachy and use [recording
rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/)
or plain federation to aggregate metrics upstream.

With Prometheus, remember you are sampling, you are not capturing every event.
You are looking to **observe trends**. My philosophy is that it's not healthy
to stare at "real time" metrics coming in and try to make real time decisions.
Quick decisions are triggered off **events** from your Cloud provider!

Metrics **are not events**, metrics are for observing trends and pre-empt any
Site Reliability issues. Good <abbr title="Site Reliablity
Engieering">SRE</abbr> is knowing in a week you will run out of disk space.
Not alerting when it happens!

# Normal "observability" Architecture

Metrics are fed (scraped) back to a central "observability" account for shared
analysis either by

1. Directly from the exporter's /metrics endpoint (simplest)
2. Federation; [example on how to scrape via Federation...](https://github.com/kaihendry/debugprom#how-to-federate-particular-metrics)
3. [Recording rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) which is a way of local team to express what's important and **deliver signal**

<a href="https://excalidraw.com/#json=5529885153951744,mY5yU9vQRE0JFXzcJayJLQ">
<img alt="Standard Prometheus Architecture" src="https://s.natalian.org/2021-08-12/scraping-arch.svg">
</a>

Notice at any time one can scrape the various addressable target endpoints,
without relying on a potential central point of failure. This is not the case when you push metrics.

# The highly scalable Architecture

You probably do not need https://thanos.io/ unless you are a Unicorn, maybe.
With a dangerous fetish for data retention.

<a href="https://excalidraw.com/#json=5031494363906048,xfbeeWO2VqTl1LuTnnMXdQ">
<img alt="Scalable Prometheus Architecture" src="https://s.natalian.org/2021-08-11/extreme.svg">
</a>

Unfortunately Thanos/Cortex/AWS encourage ingesting metrics via a **push** [remote
write](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-onboard-ingest-metrics.html),
which hits up against [Prometheus hierarchical
federation](https://prometheus.io/docs/prometheus/latest/federation/#hierarchical-federation) and my love for scraping.

# ❤️Scraping is good, why?

<img src="https://s.natalian.org/2021-08-12/prom-scrape.png" alt="Prom targets">

* Prom is designed to [pull rather than push](https://prometheus.io/docs/introduction/faq/#why-do-you-pull-rather-than-push)
* It's easier to debug when things are going wrong from /targets ! Endpoints should be addressable, if they are not, it's like blocking ICMP (completely daft)
* You don't need to worry about being overwhelmed, as with scraping, you are always in control. Perhaps can be be argued with the [Robustness Principal](https://en.wikipedia.org/wiki/Robustness_principle)

Scraping sucks less and is idiomatic Architecture of Prometheus.
