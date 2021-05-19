---
title: Check Prometheus exported metrics
date: 2021-05-19
description: Use Docker to check metrics are correctly exposed for scraping
---

[/metrics format reference](https://prometheus.io/docs/instrumenting/exposition_formats/)

	$ curl -s http://192.168.1.5:9115/metrics | docker run -i --entrypoint=promtool prom/prometheus check metrics --
	$ curl -s http://192.168.1.5:9115/WRONG | docker run -i --entrypoint=promtool prom/prometheus check metrics --
	error while linting: text format parsing error in line 1: invalid metric name
