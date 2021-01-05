---
title: Serverless Speed Survey
date: 2020-12-20T18:13:47+08:00
description: Comparing AWS, Microsoft and GCP managed compute offerings assuming an HTTP endpoint
---

<style>
table { word-break: initial }
</style>

I've used https://github.com/kaihendry/count to "experience" various managed
compute solutions <abbr title="also known as">aka</abbr> [Serverless
computing](https://aws.amazon.com/serverless/). 

AWS Fargate / Elastic Beanstalk is excluded because it does **not scale to
zero** since it requires an underlying compute cluster which you pay hourly
for.

<table>
<tr>
<th>Feature</th>
<th><a href="https://github.com/kaihendry/count/tree/serverless">Serverless framework (AWS)</a></th>
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
<td>Yes</td>
<td>No (Hong Kong)</td>
<td>Yes</td>
<td>No (Hong Kong)</td>
</tr>
<tr>
<td>My subjective <a href="https://serverlesshandbook.dev/serverless-dx/">DX rating</a></td>
<td>OK, custom entrypoint</td>
<td>Favourite</td>
<td>Bad, custom entrypoint</td>
<td>Bad, custom entrypoint</td>
<td>Great, but slow</td>
<td>Confusing, but once setup ... OK</td>
</tr>
<tr>
<td>Demo URL</td>
<td><a href="https://sls.goserverless.sg">AWS SG</a></td>
<td><a href="https://count.goserverless.sg/">AWS SG</a></td>
<td><a href="https://sam.goserverless.sg/">AWS SG</a></td>
<td><a href="https://asia-east2-idiotbox.cloudfunctions.net/Countpage">GCP HK</a></td>
<td><a href="https://count.dabase.com/">GCP SG</a></td>
<td><a href="https://counttesting.azurewebsites.net/">Azure SG</a></td>
</tr>
<tr>
<td>Iteration speed</td>
<td>~30s <img src="https://github.com/kaihendry/count/workflows/Deploy%20SLS/badge.svg?branch=serverless" alt="sls deploy"></td>
<td>~10s <img src="https://github.com/kaihendry/count/workflows/Deploy%20Apex%20Up/badge.svg" alt="Up"></td>
<td>~30s
<img src="https://github.com/kaihendry/count/workflows/Deploy%20SAM/badge.svg?branch=sam" alt="SAM deploy">
</td>
<td>~2mins
<img src="https://github.com/kaihendry/count/workflows/Build%20and%20Deploy%20to%20Cloud%20Functions/badge.svg?branch=gcp-functions" alt="Function deploy">
</td>
<td>~2mins
<img src="https://github.com/kaihendry/count/workflows/Build%20and%20Deploy%20to%20Cloud%20Run/badge.svg?branch=gcp-cloudrun" alt="Cloud run deploy">
</td>
<td>~30s <a href="#not-immediate">[1]</a>
<img src="https://github.com/kaihendry/count/workflows/Deploy%20Azure%20function/badge.svg?branch=azure-functions" alt="Azure func deploy">
</td>
</tr>
<tr>
<td>Custom domain</td>
<td>Yes, via a plugin</td>
<td>Yes</td>
<td>Yes</td>
<td><a href="https://stackoverflow.com/a/58591136/4534">Via Firebase</a> <a href="#no-cli">[2]</a></td>
<td><a href="https://github.com/kaihendry/count/blob/gcp-cloudrun/Makefile#L22">Yes</a> <a href="#not-immediate">[1]</a></td>
<td><a href="https://azure.dabase.com/">Yes</a> <a href="#no-cli">[2]</a></td>
</tr>
</table>

<p><a id="immediate">[1]</a> CLI will say it's "done", though I suspect the Cloud is being <strong>eventually consistent</strong>... leading to some confusion when expected changes are not live!</p>
<p><a id="no-cli">[2]</a> No <abbr title="Command Line Interface">CLI</abbr> / <abbr title="Infrastructure as Code">IaC</abbr> option <abbr title="As far as I can tell">AFAICT</abbr></p>

I've noticed deployment failures can happen when:
* [gcp-cloudrun when there is the same version](https://s.natalian.org/2021-01-05/same-version.png)
* [gcp-functions if it's already deploying](https://s.natalian.org/2021-01-05/deployment-failure.png)

[Apex Up](https://github.com/apex/up) is the clear winner to me. Apex Up has
the **fastest iterations** to the cloud (~2s), a fantastic <abbr
title="Developer Experience">DX</abbr> <abbr title="Command Line
Interface">CLI</abbr> with logging that's easy to use. Apex Up also
automatically bundles `static/` assets which the others don't do and uses the
[standard http request / response API](https://youtu.be/Bj2p6nVt_H4).

To experiment in further public clouds with managed compute, the [serverless
framework](https://www.serverless.com/) does seem to have the best starter
templates with `serverless create -h` to view them.

## Note about iteration speed

There are three types of iteration speed:

1. Local development speed, speed of live reloader like [entr](http://eradman.com/entrproject/). Painful with functions that do not use HTTP req/res interface.
2. Using your serverless tooling to `time make deploy` and view changes on the Cloud endpoint.
3. Time for your CI/CD pipeline (Github action) to deploy (often much longer since env is setup from scratch)

Iteration speed above is **case 2**.

I do not consider the time for the initial setup / <abbr title="Infrastructure
as Code">IaC</abbr> provisioning which can take quite a bit of waiting,
especially for the **custom domain**!

# Price?!

Unfortunately it's quite tedious and difficult to compare the price, especially
when there is a free tier. Just know that I've not noticed an impact on my bill
when using serverless. It's must cheaper than paying hourly. If it becomes
expensive, you have options!

Need more reasons to consider "Serverless"? Please checkout https://goserverless.sg/
