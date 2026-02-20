---
title: "Beads, Speckit, Perles, Opus, Agents, oh my!"
date: 2025-12-11T12:00:00Z
description: "https://www.loom.com/share/e2ab7a2dc7354bff88c9f528398e1bbf

Do please comment & Europeans must go to these FREE events:

https://fosdem.org/2026/
https://cfgmgmtcamp.org/ghent2026/"
image: "https://img.youtube.com/vi/yokbTRUvxQU/hqdefault.jpg"
draft: false

podcast:
  episode: 10
  season: 1
  episodeType: "full"
  duration: 2521
  audioUrl: "/podcast/audio/010-beads-speckit-perles-opus-agents-oh-my.mp3"
  audioSize: 60504236
  youtubeId: "yokbTRUvxQU"
  youtubeUrl: "https://www.youtube.com/watch?v=yokbTRUvxQU"
---

https://www.loom.com/share/e2ab7a2dc7354bff88c9f528398e1bbf

Do please comment & Europeans must go to these FREE events:

https://fosdem.org/2026/
https://cfgmgmtcamp.org/ghent2026/

[Watch on YouTube](https://www.youtube.com/watch?v=yokbTRUvxQU)

## `summarize "https://youtu.be/yokbTRUvxQU" --timestamps --slides`

This discussion explores advanced AI-driven development workflows, focusing on the integration of tools like Speckit, Beads, and Perles to manage complex infrastructure projects. The speakers detail how these tools shift the balance of software engineering toward rigorous planning and automated execution, allowing developers to handle sophisticated tasks such as building a Terraform state back end with high precision.

[![Slide 1](/podcast/slides/yokbTRUvxQU/youtube-yokbTRUvxQU/slide_0001_1.21s.png)](https://youtu.be/yokbTRUvxQU?t=1)
## Advanced AI Workflows and The Grid
The primary project discussed is "The Grid," a Terraform state back end that requires more advanced cloud code usage than typical web traffic applications. The developer explains his workflow using Speckit, a tool he has customized by maintaining a local copy of prompts and merging them with upstream changes from the project's changelog. One significant modification involved improving the branch naming logic; while the original tool generated nonsensical names, the developer updated the scripts to use Large Language Models (LLMs) to create descriptive, context-aware branch names. He views Claude Opus not merely as a coding assistant but as a planning agent capable of structuring the entire development lifecycle. The conversation touches on the importance of contributing these personalizations back to the open-source community, though the developer notes a recent lack of activity in the upstream repository. The workflow is designed to handle non-trivial cloud infrastructure, moving beyond simple automation to manage the intricate state requirements of Terraform.

[![Slide 2](/podcast/slides/yokbTRUvxQU/youtube-yokbTRUvxQU/slide_0002_412.16s.png)](https://youtu.be/yokbTRUvxQU?t=412)
## Planning Inversion and Agile Backtracking
A central theme is the "inversion" of traditional development cycles. The speaker argues that AI workflows should be approximately 70% planning and 30% agent-led coding. This approach mirrors the use of Architecture Decision Records (ADRs) but applies them more dynamically. *It's like 70% planning 30% and agents writing code.* By defining specifications, user data, and technical research upfront, the developer creates a contract that agents must follow. This method allows for a unique form of agility: because generating code is inexpensive and fast, a developer can "throw away" an entire branch if the implementation hits a design flaw and return to the research phase to course-correct. The speaker uses a bridge-building analogy, noting that while agents work on separate components, they must meet in the middle according to the predefined contract. If one side of the bridge encounters a massive issue, the developer must be able to step back and adjust the entire plan rather than trying to fix the code mid-stream.

[![Slide 3](/podcast/slides/yokbTRUvxQU/youtube-yokbTRUvxQU/slide_0003_840.64s.png)](https://youtu.be/yokbTRUvxQU?t=840)
## Context Management with Beads and Perles
The discussion introduces Beads (also referred to as Beats) and Perles as essential tools for managing the limited context windows of current AI models. *Beads allows me to manage the context window loving it but in the future the context is bound to grow.* While Speckit creates task files for specific features, Beads acts as a central database for the entire repository, allowing developers to slice and dice issues using labels. This is particularly useful for querying the next set of "ready" tasks across multiple feature branches. The speaker maps the hierarchy of his project by translating Speckit's features into epics, user stories into features, and specific actions into tasks. This structured approach ensures that every task is backed by a functional requirement. There is a forward-looking concern that as models like Claude Sonnet 3.5 evolve toward "unlimited" context, the manual effort of managing context might become obsolete, though the speakers suspect these workflows will eventually be integrated directly into core development environments.

[![Slide 4](/podcast/slides/yokbTRUvxQU/youtube-yokbTRUvxQU/slide_0004_1252.48s.png)](https://youtu.be/yokbTRUvxQU?t=1252)
## Agent Memory and Terminal Interactivity
The developer demonstrates a highly interactive terminal workflow using a "continue last session" feature to maintain prompt history. By using a double-escape shortcut, he can review the sequence of prompts that drove a specific session, such as running tests or updating agent memory. He emphasizes the importance of "progressive disclosure" in markdown files, where the AI is given only the necessary details for a specific task to keep it focused. To prevent agents from reinventing the wheel, he adds specific comments to tasks instructing the AI to use existing helpers rather than writing new ones. The workflow involves a foundational phase followed by specific user stories, such as "rename state logic," which serves as the Minimum Viable Product (MVP). This phase-based approach allows the developer to build the entire stack—API, CLI, and SDK—simultaneously. He also notes the utility of status indicators and progress bars in the UI, which show the completion percentage of specific epics and phases.

[![Slide 5](/podcast/slides/yokbTRUvxQU/youtube-yokbTRUvxQU/slide_0005_1672.16s.png)](https://youtu.be/yokbTRUvxQU?t=1672)
## The Vision for Perles and BQL
The speakers recount a conversation with Zack, the creator of Perles and a director-level engineer at a major Fortune 500 company. Zack is "bullish" on the idea that structured databases like Beads will become the core of agent memory and context management. Perles features a sophisticated query language known as BQL (Beats Query Language), which includes a lexer and parser that translates queries into SQL for the issue database. This allows for advanced views, such as a Kanban board that can instantly transition into a full dependency tree by pressing a specific key. Zack's vision involves onboarding thousands of engineers to these LLM-driven workflows, focusing on the most logical ways to handle complex task diagrams. The tool has evolved to include topological sorting and detailed metadata, such as whether a child task is closed or open. The speaker notes that Zack acts as a strong product owner, often refining user requests to find the most efficient implementation rather than simply adding requested features.

[![Slide 6](/podcast/slides/yokbTRUvxQU/youtube-yokbTRUvxQU/slide_0006_2092.80s.png)](https://youtu.be/yokbTRUvxQU?t=2092)
## Security Hurdles and Corporate AI Adoption
The final segment addresses the challenges of implementing these AI workflows within large engineering organizations. A major point of contention is the Model Context Protocol (MCP), which some security teams disable due to fears of code harvesting or prompt injection. The speaker argues that blanket prohibitions are counterproductive, as they often drive employees to use less secure "copy-paste" methods. Instead, companies should implement AI routers that provide observability, monitoring, and fine-grained access control. The conversation highlights a recent Cloudflare outage as a cautionary tale; the incident was triggered by a botched rollback of firewall rules designed to mitigate a React remote code execution (RCE) vulnerability. This illustrates the complexity of modern software supply chains and the need for robust process management. The speakers conclude that while AI is evolving rapidly, corporate processes must remain flexible enough to adopt new workflows day-by-day rather than remaining static and enshrined in outdated security policies.

*Model: google/gemini-3-flash-preview*
