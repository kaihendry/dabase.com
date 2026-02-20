---
title: "Who is Vincent DE Smet & what is Grid?"
date: 2025-10-29T12:00:00Z
description: "00:00 Why move to Vietnam?
33:34 Spec Kit and https://github.com/steveyegge/beads? 
44:49 Demo of the Grid"
image: "https://img.youtube.com/vi/OacVAuGFSHg/hqdefault.jpg"
draft: false

podcast:
  episode: 4
  season: 1
  episodeType: "full"
  duration: 3949
  audioUrl: "/podcast/audio/004-who-is-vincent-de-smet-what-is-grid.mp3"
  audioSize: 94771052
  youtubeId: "OacVAuGFSHg"
  youtubeUrl: "https://www.youtube.com/watch?v=OacVAuGFSHg"
---

00:00 Why move to Vietnam?
33:34 Spec Kit and https://github.com/steveyegge/beads? 
44:49 Demo of the Grid

[Watch on YouTube](https://www.youtube.com/watch?v=OacVAuGFSHg)

## `summarize "https://youtu.be/OacVAuGFSHg" --timestamps --slides`

Vincent De Smet discusses his professional journey from implementing ERP systems in Vietnam to becoming a specialist in cloud infrastructure and Kubernetes. The conversation covers the evolution of container orchestration, the technical trade-offs between different cloud services, and the development of his new project, Grid. De Smet details how his background in manual system administration led him to seek better automation and type safety in infrastructure as code. He also provides a deep dive into his current development workflow, which leverages AI agents and spec-driven development to build complex software systems.

[![Slide 1](/podcast/slides/OacVAuGFSHg/youtube-OacVAuGFSHg/slide_0001_1.52s.png)](https://youtu.be/OacVAuGFSHg?t=1)
## From ERP Consulting to Infrastructure Automation
Vincent De Smet moved to Vietnam in 2006, initially working for a decade as a professional services consultant. His primary role involved implementing Infor ERP systems for international clients, including major hospitality brands like Hilton Hotels. During this time, he learned that *you really only understand something if you if you can explain it to someone else* while training users on complex accounting software. His transition toward software engineering and infrastructure began as he sought to automate the repetitive, manual processes of installing Windows systems. He moved from following static Word documents with screenshots to writing extensive PowerShell scripts. These scripts allowed him to interact with the .NET framework, load access databases, and create unattended installation routines. This early exposure to automation and the realization that manual processes were inefficient set the stage for his later interest in immutable infrastructure and containerization.

[![Slide 2](/podcast/slides/OacVAuGFSHg/youtube-OacVAuGFSHg/slide_0002_650.13s.png)](https://youtu.be/OacVAuGFSHg?t=650)
## Gaming Origins and the Rise of Docker
The shift into infrastructure engineering was heavily influenced by De Smet's interest in gaming. Around 2013, he attempted to run Counter-Strike: Global Offensive servers in Vietnam. He discovered that running game servers in traditional virtual machines led to significant performance degradation. This challenge led him to explore Linux containers and Docker as a more efficient alternative. He began building a gaming platform that required ingesting massive amounts of log data to generate player statistics, similar to professional platforms like ESEA. He utilized IRC bots and regular expressions to parse logs and manage tournament flows. This project forced him to learn modern web technologies, including NodeJS, Python, and Angular. By attending local meetups in Vietnam, he transitioned from the Windows-centric world of ERP to the burgeoning ecosystem of Go, Docker, and immutable server architecture.

[![Slide 3](/podcast/slides/OacVAuGFSHg/youtube-OacVAuGFSHg/slide_0003_1308.26s.png)](https://youtu.be/OacVAuGFSHg?t=1308)
## The Early Days of Kubernetes and CoreOS
De Smet was an early adopter of Kubernetes, following its announcement by Google in 2014. He initially viewed the system as overkill but was fascinated by the kubelet's ability to manage containers. He documented the "hard way" of setting up Kubernetes on Digital Ocean droplets, which involved manually bootstrapping PKI, configuring etcd, and setting up Flannel for overlay networking. He highlights the significance of CoreOS during this era, particularly its container-centric operating system and the Fleet scheduler. He describes the technical competition between Docker and CoreOS, noting how CoreOS developed Rocket (rkt) to address security concerns like image signing and verification. This period was marked by rapid innovation and shifting standards, as Kubernetes eventually superseded alternative schedulers like Fleet and Docker Swarm. De Smet notes that while CoreOS was eventually acquired by Red Hat, its influence on the industry remains through projects like ignition and the concept of automated OS updates.

[![Slide 4](/podcast/slides/OacVAuGFSHg/youtube-OacVAuGFSHg/slide_0004_1966.36s.png)](https://youtu.be/OacVAuGFSHg?t=1966)
## Infrastructure Trade-offs and Resource Management
The discussion explores the practical trade-offs between using Kubernetes and managed services like AWS Fargate. De Smet argues that while Fargate offers simplicity, it lacks the fine-grained control over resource oversubscription that Kubernetes provides. In Kubernetes, engineers can oversubscribe nodes, allowing pods to burst and utilize available memory and CPU beyond their guaranteed limits, which is essential for handling bury workloads cost-effectively. He notes that *the reason developers like to run docker compose is because it's easy almost no dials and knobs* but emphasizes that enterprise-scale infrastructure requires more robust controls. He discusses the evolution of ECS and the recent introduction of managed autoscaling groups, highlighting that the choice of tool depends on the specific business value and operational requirements of the organization. This understanding of trade-offs led him to develop Grid, a tool designed to manage infrastructure state with stronger type safety than traditional methods.

[![Slide 5](/podcast/slides/OacVAuGFSHg/youtube-OacVAuGFSHg/slide_0005_2624.49s.png)](https://youtu.be/OacVAuGFSHg?t=2624)
## AI-Driven Development and Task Management
De Smet provides a detailed look at his current development process, which heavily utilizes AI agents like SpecKit and Beads. He describes a "spec-driven" approach where he uses AI to plan features, perform gap analysis, and generate functional requirements in Markdown. He highlights the challenges of managing massive AI-generated task lists, which can grow to thousands of lines. To solve this, he uses Beads, a tool that tracks tasks in a database rather than a flat file, allowing for better context management and issue linking. He explains how he uses different AI models for specific tasks: Gemini for reviewing code and plans due to its speed and large context window, and Claude for the actual implementation. This workflow allows him to "slice and dice" complex features into manageable issues with clear acceptance criteria. He emphasizes that the planning phase is critical, often taking up the majority of the development time to ensure the AI agent has sufficient context to execute correctly.

[![Slide 6](/podcast/slides/OacVAuGFSHg/youtube-OacVAuGFSHg/slide_0006_3282.81s.png)](https://youtu.be/OacVAuGFSHg?t=3282)
## The Grid Project and Strongly Typed State
The final segment focuses on "Grid," De Smet's project for managing infrastructure state. Grid is designed to solve the problems associated with "integration registries" in large organizations, where different teams need to share infrastructure outputs like VPC IDs or subnet IDs. Unlike existing solutions that rely on loosely typed strings, Grid aims to provide strongly typed schemas for infrastructure outputs using Terra Constructs. This allows for better contract testing between teams and ensures that dependencies are versioned and validated. De Smet demonstrates the Grid API and dashboard, showing how it tracks dependencies between different Terraform states. The system can detect when a dependency becomes "stale" due to changes in an upstream resource. He explains that Grid uses state as an encapsulation mechanism, allowing platform teams to expose specific resources to product teams without revealing the underlying complexity. The project is built using Go and Connect RPC, providing autogenerated clients for multiple languages and a React-based visualization layer.

*Model: google/gemini-3-flash-preview*
