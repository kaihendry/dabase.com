---
title: Serverless Speed Survey
date: 2020-12-20T18:13:47+08:00
description: Comparing AWS, Microsoft and GCP managed compute offerings
---

I've used https://github.com/kaihendry/count to "experience" various managed
compute solutions <abbr title="also known as">aka</abbr> [Serverless
computing](https://aws.amazon.com/serverless/). 

AWS Fargate is excluded because it does **not scale to zero** since it requires
an underlying compute cluster which you pay hourly for.

<table>
<tr>
<th>Feature</th>
<th><a href="https://github.com/kaihendry/count">Apex Up (AWS)</a></th>
<th><a href="https://github.com/kaihendry/count/tree/sam"><abbr title="Serverless Application Model">SAM</abbr> (AWS)</a></th>
<th><a href="https://github.com/kaihendry/count/tree/gcp-functions">Functions (GCP)</a></th>
<th><a href="https://github.com/kaihendry/count/tree/gcp-cloudrun">Cloud Run (GCP)</a></th>
<th><a href="https://github.com/kaihendry/count/tree/azure-functions">Functions (Azure)</a></th>
</tr>
<tr>
<td>Local to Singapore</td>
<td>Yes</td>
<td>Yes</td>
<td>No (Hong Kong)</td>
<td>Yes</td>
<td>Yes</td>
</tr>
<tr>
<td><a href="https://serverlesshandbook.dev/serverless-dx/">DX rating</a></td>
<td>Best</td>
<td>Bad, custom entrypoint</td>
<td>Bad, custom entrypoint</td>
<td>Good, but slow</td>
<td><a href="https://youtu.be/u03I1B65xe8">Poor</a></td>
</tr>
<tr>
<td>Demo URL</td>
<td><a href="https://count.goserverless.sg/">AWS</a></td>
<td><a href="https://sam.goserverless.sg/">AWS</a></td>
<td><a href="https://asia-east2-idiotbox.cloudfunctions.net/Countpage">Function</a></td>
<td><a href="https://count.dabase.com/">GCP Cloud Run</a></td>
<td><a href="https://counttesting.azurewebsites.net/">Azure</a></td>
</tr>
<tr>
<td>Iteration speed</td>
<td>~2s <img src="https://github.com/kaihendry/count/workflows/Deploy/badge.svg" alt="Deploy"></td>
<td>~30s
<img src="https://github.com/kaihendry/count/workflows/Deploy%20SAM/badge.svg" alt="SAM deploy">
</td>
<td>~2mins
<img src="https://github.com/kaihendry/count/workflows/Build%20and%20Deploy%20to%20Cloud%20Functions/badge.svg" alt="Function deploy">
</td>
<td>~2mins
<img src="https://github.com/kaihendry/count/workflows/Build%20and%20Deploy%20to%20Cloud%20Run/badge.svg" alt="SAM deploy">
</td>
<td>~30s <a href="#immediate">[1]</a></td>
</tr>
<tr>
<td>Custom domain</td>
<td>Yes</td>
<td>Yes</td>
<td><a href="https://stackoverflow.com/a/58591136/4534">Via Firebase</a> <a href="#no-cli">[2]</a></td>
<td><a href="https://github.com/kaihendry/count/blob/gcp-cloudrun/Makefile#L22">Yes</a> <a href="#immediate">[1]</a></td>
<td><a href="https://azure.dabase.com/">Yes</a> <a href="#no-cli">[2]</a></td>
</tr>
</table>

<p><a id="immediate">[1]</a> Not immediate. CLI will say it's done but Cloud is being <strong>eventually consistent</strong>... leading to some confusion!</p>
<p><a id="no-cli">[2]</a> No <abbr title="Command Line Interface">CLI</abbr> / <abbr title="Infrastructure as Code">IaC</abbr> option <abbr title="As far as I can tell">AFAICT</abbr></p>

[Apex Up](https://github.com/apex/up) is the clear winner to me. Apex Up has
the **fastest iterations** to the cloud (~2s), a fantastic <abbr
title="Developer Experience">DX</abbr> <abbr title="Command Line
Interface">CLI</abbr> with logging that's easy to use. Apex Up also
automatically bundles `static/` assets which the others don't do and uses the [standard http request / response API](https://youtu.be/Bj2p6nVt_H4).

## Note about iteration speed

There are three types of iteration speed:

1. Local development speed, speed of live reloader like [entr](http://eradman.com/entrproject/). Painful with functions that do not use HTTP req/res interface.
2. Using your serverless tooling to `make deploy` and view changes on the Cloud endpoint
3. Time for your CI/CD pipeline (Github action) to deploy (often much longer since env is setup from scratch)

Iteration speed above is **case 2**.

## TODO

* Cloudflare workers only appear to [support Javascript](https://developers.cloudflare.com/workers/platform/languages)
* [Serverless framework](https://github.com/kaihendry/count/issues/3)
