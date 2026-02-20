---
title: "CDK for Terraform and two pizza teams"
date: 2025-12-16T12:00:00Z
description: "https://github.com/hashicorp/terraform-cdk/commit/a0c56138e2b4c7b6c128bd7ba08a8e317df852af

Trying to plot the changing Infrastructure landscape."
image: "https://img.youtube.com/vi/rM2pj0JKc0g/hqdefault.jpg"
draft: false

podcast:
  episode: 11
  season: 1
  episodeType: "full"
  duration: 3712
  audioUrl: "/podcast/audio/011-cdk-for-terraform-and-two-pizza-teams.mp3"
  audioSize: 89085007
  youtubeId: "rM2pj0JKc0g"
  youtubeUrl: "https://www.youtube.com/watch?v=rM2pj0JKc0g"
---

https://github.com/hashicorp/terraform-cdk/commit/a0c56138e2b4c7b6c128bd7ba08a8e317df852af

Trying to plot the changing Infrastructure landscape.

[Watch on YouTube](https://www.youtube.com/watch?v=rM2pj0JKc0g)

## `summarize "https://youtu.be/rM2pj0JKc0g" --timestamps --slides`

This discussion explores the volatile state of the Infrastructure as Code (IaC) ecosystem following IBM's acquisition of HashiCorp and the subsequent sunsetting of the CDK for Terraform (CDKTF). The speakers analyze the technical and organizational shifts driving developers away from traditional configuration-based tools toward programmatic frameworks like Pulumi and AWS CDK. They examine the trade-offs between developer experience and operational control, the rise of platform engineering, and how modern "two-pizza teams" are redefining the boundary between application code and infrastructure.

[![Slide 1](/podcast/slides/rM2pj0JKc0g/youtube-rM2pj0JKc0g/slide_0001_0.87s.png)](https://youtu.be/rM2pj0JKc0g?t=0)
## The Fall of CDKTF and the Rise of Alternatives
The conversation begins with the news that IBM decided to sunset CDKTF, a project that was a collaboration between AWS and HashiCorp. The speakers note that the repository had been neglected for some time, remaining pinned to Terraform version 1.6 while the main project advanced to version 1.13. This lack of maintenance occurred despite the project being positioned as a way to bring the benefits of the AWS Cloud Development Kit (CDK) to the broader Terraform ecosystem. The sunsetting event triggered significant reactions on platforms like Reddit and Hacker News, where many users expressed that the tool was "half-baked" or simply not being used. Pulumi is identified as a primary beneficiary of this fallout, having launched years earlier with a more mature programmatic approach to infrastructure. The speakers suggest that for those still tied to the Terraform ecosystem, the move toward OpenTofu is becoming increasingly logical following HashiCorp's shift to the Business Source License (BSL). *Terraform Hashikorp language is a horrible way for developers to manage their infrastructure.* This sentiment reflects a growing frustration with the limitations of HCL (HashiCorp Configuration Language) for product engineers who prefer familiar programming languages.

[![Slide 2](/podcast/slides/rM2pj0JKc0g/youtube-rM2pj0JKc0g/slide_0002_610.64s.png)](https://youtu.be/rM2pj0JKc0g?t=610)
## Pulumi and the Open Source IaC Landscape
Pulumi is highlighted as a strong alternative that supports a wide array of languages, including TypeScript, Python, Go, and even YAML. Unlike HashiCorp's recent licensing changes, Pulumi's source code remains Apache 2 licensed, allowing it to position itself as the "real" open-source option for infrastructure. A key advantage of Pulumi is its ability to interact directly with Terraform backends, allowing organizations to run both tools side-by-side during a migration rather than requiring a total rewrite. The speakers also discuss SST (Serverless Stack), which originally built abstractions on top of AWS CDK but has recently pivoted to use Pulumi as its engine. This shift is significant because it moves away from the "all or nothing" database-transaction style of CloudFormation, which can often get stuck during rollbacks. Pulumi and Terraform offer more granular control over state refactoring, which is essential for large-scale enterprise environments. While Pulumi offers a free open-source tier, its commercial model involves a managed cloud UI for state and orchestration, similar to Terraform Cloud.

[![Slide 3](/podcast/slides/rM2pj0JKc0g/youtube-rM2pj0JKc0g/slide_0003_1229.24s.png)](https://youtu.be/rM2pj0JKc0g?t=1229)
## Defining Developer Experience in Platform Engineering
The speakers attempt to map various tools on a scale of Developer Experience (DevX) versus operational features. They define the role of a platform engineer as providing tools that allow developers to take full ownership of their services in production. High-DevX tools like Vercel, Netlify, and Fly.io are praised for their simplicity, often requiring only a CLI and a basic configuration file. However, these tools often lack the "operational depth" required for complex infrastructure, such as fine-grained control over database bootstrapping or networking. AWS CDK is placed high on the DevX scale but lower on operational flexibility because it is backed by CloudFormation, which can lose track of resources if logical IDs change. The speakers argue that a good developer experience is not just about ease of use, but about the "agility" it provides to a team. They note that many organizations struggle with "click-ops," where developers manually configure resources in the AWS console because the IaC tools are too convoluted to use effectively.

[![Slide 4](/podcast/slides/rM2pj0JKc0g/youtube-rM2pj0JKc0g/slide_0004_1847.48s.png)](https://youtu.be/rM2pj0JKc0g?t=1847)
## The Complexity of Low-Level Resource Management
A major criticism of Terraform is that it forces developers to manage every single low-level API resource, such as IAM roles, trust policies, and security group rules, just to connect a simple Lambda function to an API Gateway. This "low-level" perspective is a barrier for product engineers who want to focus on application logic rather than infrastructure plumbing. The speakers discuss the varying quality of Terraform providers, citing the Snowflake provider as an example of a tool that can be "experimental" and prone to recreating resources unexpectedly. They describe the "nightmare" of trying to manage everything through Terraform, such as running SQL queries to configure database extensions, which requires complex networking tunnels and security compliance measures. Some argue that IaC should be reserved for stable, long-lived resources like databases, while more dynamic application components should be handled by higher-level abstractions. The lack of automated testing in many Terraform setups further complicates long-term maintenance, leading to "complex interfaces" that are difficult to refactor after a year or two of development.

[![Slide 5](/podcast/slides/rM2pj0JKc0g/youtube-rM2pj0JKc0g/slide_0005_2466.48s.png)](https://youtu.be/rM2pj0JKc0g?t=2466)
## Strategic Infrastructure Mapping for the Enterprise
When considering how a CTO should manage hundreds of AWS accounts, the speakers weigh the benefits of Pulumi, SST, and AWS CDK. Pulumi is noted for its "on-event" hooks, which allow for dynamic logic during deployment—such as automatically adjusting configurations based on the number of availability zones in a specific region. This is contrasted with Terraform's deterministic, static nature. AWS CDK uses "context providers" to achieve a similar effect, querying the environment during the synthesis phase and storing the results in a `cdk.context.json` file to ensure builds remain deterministic when checked into version control. The speakers discuss the "Two-Pizza Team" model used at AWS, where the team responsible for the product also handles observability, paging alerts, and reliability. In this model, the separation between "infrastructure" and "code" disappears. For organizations with strict silos—where security teams own IAM and networking teams own VPCs—adopting these integrated programmatic tools can be challenging, as they require a platform team that understands object-oriented programming and software testing rather than just system administration.

[![Slide 6](/podcast/slides/rM2pj0JKc0g/youtube-rM2pj0JKc0g/slide_0006_3085.56s.png)](https://youtu.be/rM2pj0JKc0g?t=3085)
## Integrated Deployments and the Construct Hub
The final segment focuses on the "Construct Hub," a registry for AWS CDK, CDKTF, and Projen constructs that allows teams to share high-level integration patterns. Unlike the Terraform Module Registry, which is often limited to HCL, the Construct Hub supports multiple programming languages and leverages native package managers like NPM and PyPI. The speakers highlight the "Construct Hub" itself as a prime example of a mature serverless application built by a two-pizza team, featuring automated failovers and detailed runbooks. They argue that the traditional separation of infrastructure and application code is fundamentally "wrong" for modern DevOps. *The whole deployment process belongs to the product team not to the infrastructure team.* This integrated approach is facilitated by the AWS CDK asset pipeline, which bundles application code (like Docker images or Lambda zip files) directly with the infrastructure definition. While some criticize this for making deployments dependent on local build environments or rate limits, the speakers view it as a vital feature for developer autonomy. The discussion concludes with a look toward the future, where AI might assist in governing these complex environments by guiding LLMs with organizational rules and "sandboxes" to prevent rampant, unmanaged resource creation.

*Model: google/gemini-3-flash-preview*
