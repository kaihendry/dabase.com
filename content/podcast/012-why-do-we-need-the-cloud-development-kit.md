---
title: "Why do we need the Cloud Development Kit?"
date: 2025-12-19T12:00:00Z
description: "The Cloud is too complex, we need a programming language, we need abstractions. Terraform isn't enough for AWS."
image: "https://img.youtube.com/vi/NfzsrgTmBtY/hqdefault.jpg"
draft: false

podcast:
  episode: 12
  season: 1
  episodeType: "full"
  duration: 4216
  audioUrl: "/podcast/audio/012-why-do-we-need-the-cloud-development-kit.mp3"
  audioSize: 101199345
  youtubeId: "NfzsrgTmBtY"
  youtubeUrl: "https://www.youtube.com/watch?v=NfzsrgTmBtY"
---

The Cloud is too complex, we need a programming language, we need abstractions. Terraform isn't enough for AWS.

[Watch on YouTube](https://www.youtube.com/watch?v=NfzsrgTmBtY)

## `summarize "https://youtu.be/NfzsrgTmBtY" --timestamps --slides`

This episode of the AI Infrastructure Podcast features Kai Hendry and Vincent Smith discussing the evolving landscape of the Cloud Development Kit (CDK), specifically focusing on the future of CDK for Terraform (CDKTF) following its deprecation by HashiCorp and IBM. The conversation centers on why high-level abstractions are essential for managing modern cloud complexity and how programming languages provide a superior interface compared to traditional declarative configuration files. The hosts argue that as infrastructure becomes more intricate, the ability to reason about systems through code—rather than "vibe coding" via the command line—is the only way to achieve reproducible and deterministic results. *It's a high level abstraction and it allows complicated cloud infrastructure to be reasoned about.*

[![Slide 1](/podcast/slides/NfzsrgTmBtY/youtube-NfzsrgTmBtY/slide_0001_1.54s.png)](https://youtu.be/NfzsrgTmBtY?t=1)
## The Terra Constructs Fork
Following the sunsetting of CDKTF by IBM, Vincent Smith took immediate action by forking the project to ensure the continued availability of L2 constructs. This fork, currently referred to by the working name Terra Constructs or "TCON," is being developed in collaboration with the Open Construct Foundation. The foundation serves as a neutral host for various CDK-related projects, providing a path forward for the community. While the project is currently in a transitional phase regarding its final naming—due to likely trademark restrictions from HashiCorp—it has already seen significant community engagement. One contributor has already submitted seven high-quality pull requests, focusing on refactoring and aligning the library more closely with the core AWS CDK. This community-driven effort aims to maintain the operational friendliness and refactorability that the original CDK brought to the infrastructure-as-code ecosystem.

[![Slide 2](/podcast/slides/NfzsrgTmBtY/youtube-NfzsrgTmBtY/slide_0002_694.76s.png)](https://youtu.be/NfzsrgTmBtY?t=694)
## Regional Fact Tables and CDKTF Mechanics
A key technical advantage of the CDK ecosystem is the regional information library, which maintains a "fact table" of cloud capabilities across different global regions. This library tracks details such as which NodeJS versions are supported in specific regions (e.g., version 22 in China versus version 24 in standard regions) and the specific domain suffixes for S3 bucket endpoints. By leveraging these fact tables, CDKTF can dynamically determine the correct configuration for a resource based on the stack's target region, a task that is often manual and error-prone in raw Terraform. CDKTF works by synthesizing a tree of constructs into raw, readable Terraform configuration. While it generates unique logical IDs with hash suffixes to prevent naming conflicts in nested modules, the final output is standard Terraform that can be inspected and deployed using existing workflows. This allows teams to bridge the gap between the expressive power of TypeScript and the established reliability of the Terraform provider ecosystem.

[![Slide 3](/podcast/slides/NfzsrgTmBtY/youtube-NfzsrgTmBtY/slide_0003_1396.92s.png)](https://youtu.be/NfzsrgTmBtY?t=1396)
## The Power of Imperative Abstractions
The discussion highlights a major trend in infrastructure: the shift from declarative YAML to imperative programming languages. CDK allows for "lazy evaluation" and late binding, where functions can execute during the synthesis phase to determine attribute values. This is particularly powerful for complex tasks like generating IAM policies, where the code can programmatically identify the exact actions required based on the resources connected by the user. This approach moves beyond the limitations of static definitions, which often require pre-processors or complex template languages to handle dynamic logic. The hosts note that even Terraform has moved toward this by adding list comprehensions and dynamic blocks, but a proper programming language like TypeScript offers a more robust environment for building these abstractions. CDK for Kubernetes (CDK8s) applies these same principles, allowing developers to define high-level intentions—such as pod spreading rules—that are then translated into the verbose and deeply nested API objects required by Kubernetes.

[![Slide 4](/podcast/slides/NfzsrgTmBtY/youtube-NfzsrgTmBtY/slide_0004_2100.32s.png)](https://youtu.be/NfzsrgTmBtY?t=2100)
## GitOps and Reconciliation Loops
The conversation explores the "rendered manifest pattern" within GitOps, emphasizing the importance of keeping the source of truth in Git as close to the final state as possible. Tools like Argo CD and Flux are discussed as ways to manage this, though the hosts caution against performing "magic" on the server side, such as last-minute Helm rendering. Instead, they advocate for rendering manifests into Git so that the deployment tool simply fires raw configuration at the Kubernetes API. This section also contrasts Terraform's "plan and apply" model with the continuous reconciliation loops of Kubernetes. While Terraform only updates infrastructure when a command is manually or programmatically run, Kubernetes constantly monitors and corrects the state of the cluster. This difference is crucial when managing stateful resources like databases; the hosts suggest that stateful data should often live outside the cluster to allow the infrastructure itself to remain stateless and easily rebuildable.

[![Slide 5](/podcast/slides/NfzsrgTmBtY/youtube-NfzsrgTmBtY/slide_0005_2812.12s.png)](https://youtu.be/NfzsrgTmBtY?t=2812)
## AI Intuition and Type Safety
AI's role in infrastructure is a major theme, with the hosts arguing that CDK's structure makes it more resilient to AI "hallucinations" than raw JSON or YAML. Because CDK is built on strongly typed interfaces, an AI generating code will be constrained by the language's type system. For example, if an AI attempts to place a "swappiness" attribute at the wrong level of an ECS task definition, a TypeScript-based CDK project will throw a compilation error. In contrast, the AWS API might simply ignore unknown fields in a JSON blob, leading to silent failures. *The fact that it can generate AWS CDK correctly and in Typescript to me is proof that I would rather focus on a highle language.* The discussion also touches on the Model Context Protocol (MCP), which allows LLMs to use "tools" to discover information about a cluster on demand, such as checking CPU usage via cubectl, rather than trying to fit the entire cluster state into a limited context window.

[![Slide 6](/podcast/slides/NfzsrgTmBtY/youtube-NfzsrgTmBtY/slide_0006_3505.72s.png)](https://youtu.be/NfzsrgTmBtY?t=3505)
## Delivering Business Value Over Clusters
The final segment addresses the ultimate goal of infrastructure engineering: delivering business value. While new technologies like System Initiative offer innovative "digital twin" approaches and programmable graphs for infrastructure, the hosts emphasize that the most valuable tools are those that allow developers to move fast without getting bogged down in low-level details. AWS CDK is praised for its "intent-oriented" methods, which encapsulate ten years of community knowledge and AWS service team contributions. This allows a developer to deploy a complex application—like a Next.js site with Lambda and API Gateway—without needing to manually configure every underlying permission and routing rule. The trade-off between "click-ops" for speed and IaC for reproducibility is a constant challenge, but the hosts conclude that leveraging high-level, cloud-backed abstractions is the most effective way to innovate and maintain a competitive edge in the market.

*Model: google/gemini-3-flash-preview*
