---
title: Multi Cloud Serverless Cold starts
date: 2021-11-28T12:53:06+08:00
description: Measuring cold starts on AWS, GCP and Azure with Prometheus
---

Continuing from [Serverless DX survey](/blog/2020/serverless-speed/), there
is now a [new arm64 branch](https://github.com/kaihendry/count/tree/sam-arm64).

Since AWS claim arm64 (Graviton) is [cheaper and
**faster**](https://aws.amazon.com/blogs/aws/aws-lambda-functions-powered-by-aws-graviton2-processor-run-your-functions-on-arm-and-get-up-to-34-better-price-performance/)
than amd64, I was thinking how to test this objectively. My previous survey
focused on <abbr title="Developer Exeperience">DX</abbr>, which is not
objectively measurable!

I thought it might be fun to test managed runtime cold starts using my [prometheus setup at home](https://github.com/kaihendry/pingprom).

# Measuring cold starts

<img src="https://s.natalian.org/2021-11-28/multicloud.png">

blackbox.yml is the [blackbox exporter configuration](https://github.com/prometheus/blackbox_exporter)

	  http_cold:
		prober: http
		timeout: 5s
		http:
		  preferred_ip_protocol: ip4
		  fail_if_body_not_matches_regexp:
			- "<title>Count: 1</title>"

The [http function I have running across the major clouds counts
up](https://github.com/kaihendry/count) when invoked. How do I know it's a cold
start?

The count is one when it's a cold start!

My [home Prometheus monitor](https://github.com/kaihendry/pingprom) is configured with my http function endpoints:

	 - job_name: sls
		params:
		  module: [http_cold]
		static_configs:
		  - targets:
			- https://sam.dabase.com/
			- https://sarm.dabase.com/
			labels:
			  cloud: aws
		  - targets:
			- https://asia-east2-idiotbox.cloudfunctions.net/Countpage
			- https://count.dabase.com/
			labels:
			  cloud: gcp
		  - targets:
			- https://counttesting.azurewebsites.net/
			labels:
			  cloud: azure

The query to plot the cold starts is:

	probe_duration_seconds{job="sls"} and probe_success{job="sls"}

Unsuccessful probes are typically when the serverless endpoint is not cold, so
we ignore those.

# Preliminary results

Azure is unsurprisingly slow since it's hosted in Hong Kong, and my <abbr
title="Black box exporter">BBE</abbr> is in my home in Singapore.

Is arm64 faster than x86_64? ... it would appear so!

<img src="https://s.natalian.org/2021-11-28/arm-x86.png.png" alt="yellow is arm64, green is x86_64">

But .. the fastest surprisingly is ... [Google Cloud Platform Cloud Run](https://cloud.google.com/run)!

<img src="https://s.natalian.org/2021-11-28/fastest.png" alt="fastest cold start">

🤯
