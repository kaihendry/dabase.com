---
title: "Spec Kit vs Conductor"
date: 2025-12-23T12:00:00Z
description: "https://developers.googleblog.com/conductor-introducing-context-driven-development-for-gemini-cli/

Clip is from https://www.youtube.com/watch?v=CEvIs9y1uog

Don't paste screenshots of terminals, use:
https://tools.simonwillison.net/terminal-to-html

https://adrianhall.github.io/posts/2025/2025-12-06-spec-kit.html
https://www.sanity.io/blog/you-should-never-build-a-cms"
image: "https://img.youtube.com/vi/gvgK2wp_-UQ/hqdefault.jpg"
draft: false

podcast:
  episode: 13
  season: 1
  episodeType: "full"
  duration: 3135
  audioUrl: "/podcast/audio/013-spec-kit-vs-conductor.mp3"
  audioSize: 75234860
  youtubeId: "gvgK2wp_-UQ"
  youtubeUrl: "https://www.youtube.com/watch?v=gvgK2wp_-UQ"
---

https://developers.googleblog.com/conductor-introducing-context-driven-development-for-gemini-cli/

Clip is from https://www.youtube.com/watch?v=CEvIs9y1uog

Don't paste screenshots of terminals, use:
https://tools.simonwillison.net/terminal-to-html

https://adrianhall.github.io/posts/2025/2025-12-06-spec-kit.html
https://www.sanity.io/blog/you-should-never-build-a-cms

[Watch on YouTube](https://www.youtube.com/watch?v=gvgK2wp_-UQ)

## `summarize "https://youtu.be/gvgK2wp_-UQ" --timestamps --slides`

The landscape of AI-driven development is shifting from simple code completion to complex, context-aware agents that manage entire workflows. This discussion explores the emergence of tools like Google's Conductor and Microsoft's Spec Kit, which aim to provide structured frameworks for LLMs to operate within. By moving away from raw code generation toward high-level abstractions, developers can guide AI models to produce more consistent, expert-level results. However, this transition introduces new challenges, including significant token consumption during planning phases and the unpredictable behavior of autonomous agents that can quickly exhaust API budgets.

[![Slide 1](/podcast/slides/gvgK2wp_-UQ/youtube-gvgK2wp_-UQ/slide_0001_1.54s.png)](https://youtu.be/gvgK2wp_-UQ?t=1)
## High-level abstractions and AI expertise
The conversation begins with the premise that AI models perform significantly better when working with high-level abstractions rather than low-level implementations. Using the Cloud Development Kit for Terraform (CDKTF) as an example, the speakers argue that deterministic abstractions allow AI to avoid "reinventing the wheel" for every task. While current AI models are brilliant, they often lack the specific domain expertise required for non-trivial tasks like managing Lambda deployments on Terraform. To bridge this gap, developers are looking toward tools that provide consistent execution through domain-specific guidance.
*“Abstract deterministic abstractions allow you to work better than reinventing the wheel every time.”*
The discussion highlights a talk from Anthropic suggesting that agents today are capable of amazing things when given proper guidance but often lack the necessary context up front. They struggle to absorb human expertise over time, making structured frameworks essential for maintaining consistency across complex projects.

[![Slide 2](/podcast/slides/gvgK2wp_-UQ/youtube-gvgK2wp_-UQ/slide_0002_512.80s.png)](https://youtu.be/gvgK2wp_-UQ?t=512)
## Spec Kit versus Google Conductor
A major focus is the comparison between Spec Kit and Google's newly announced Conductor. Spec Kit operates by defining a "constitution"—a memory file that identifies the core principles and rules for a project. This constitution guides the LLM on how to create plans, subdivide tasks, and prioritize work, such as mandating automated testing or specific formatting rules. In contrast, Conductor introduces a "track" system that utilizes a JSON document to manage state.
While Spec Kit separates artifacts and processes into different commands that generate Markdown, Conductor uses a single prompt to identify the current step within a JSON-based state machine. This allows the LLM to decide the next action based on the previous state. Conductor's setup phase is more rigid, requiring the definition of the tech stack, workflow, and product vision before any work can proceed. If these foundational elements are missing, the tool is designed to halt and prompt the user for setup.

[![Slide 3](/podcast/slides/gvgK2wp_-UQ/youtube-gvgK2wp_-UQ/slide_0003_1033.68s.png)](https://youtu.be/gvgK2wp_-UQ?t=1033)
## The measure twice code once philosophy
Google's Conductor emphasizes a "measure twice, code once" approach, which forces the model to complete a comprehensive planning phase before generating any code. This strategy is intended to prevent the model from making false assumptions or hallucinations that lead to "waterfall" style failures midway through a project. However, this approach comes with a trade-off: it consumes a large number of tokens during the planning stage without providing immediate output, which can be frustrating for developers accustomed to rapid code generation.
The speakers also touch on how LLMs like GPT-4 perform "deep research" by constantly crawling platforms like Reddit to gauge community reactions and technical sentiment. This behavior was observed when researching the community's stance on forking the Terraform CDK. The reliance on external sources like Reddit suggests that public announcements on these platforms are increasingly important for influencing the "knowledge" that AI models surface to other developers.

[![Slide 4](/podcast/slides/gvgK2wp_-UQ/youtube-gvgK2wp_-UQ/slide_0004_1555.56s.png)](https://youtu.be/gvgK2wp_-UQ?t=1555)
## The parallel agent budget horror story
A cautionary tale is shared regarding the use of autonomous agents for research tasks. In one instance, a developer tasked Claude Opus with researching React routers and Vite plugins. Instead of performing the task directly, the model spawned six parallel research agents. Because each agent performed multiple web searches and tool calls, the entire five-hour token budget was exhausted within just three minutes.
*“We force the model to plan first. That means you're going to use a lot more tokens without any output.”*
The developer attempted to recover the findings by adding funds to their account, but the agents failed to return their results due to hitting rate limits. This "critical bug" highlights the risks of unconstrained agent autonomy. The solution for many has been to launch tools with a "no agents" flag to prevent the model from spawning expensive, parallel processes that can lead to immediate budget exhaustion and service unavailability.

[![Slide 5](/podcast/slides/gvgK2wp_-UQ/youtube-gvgK2wp_-UQ/slide_0005_2080.24s.png)](https://youtu.be/gvgK2wp_-UQ?t=2080)
## Skills and task management in IDEs
The discussion moves to the integration of "skills" within development environments. Anthropic has introduced cross-platform skill support, allowing models to use specialized tools for web development or data processing. For example, a model might use a specific skill to read Excel sheets or CSV files directly. There is also a debate about the utility of "beads"—a tool for tracking tasks in a SQLite database.
While some developers find beads essential for staying organized when a model fails or a session resets, others find that the AI occasionally ignores the task-tracking instructions. Spec Kit is noted for having better integration with these task-management structures, often forcing the model to update the agent context and project plan consistently. In contrast, Gemini's performance in following these structured instructions is described as hit-or-miss, depending on the complexity of the task.

[![Slide 6](/podcast/slides/gvgK2wp_-UQ/youtube-gvgK2wp_-UQ/slide_0006_2604.28s.png)](https://youtu.be/gvgK2wp_-UQ?t=2604)
## The death of the CMS and module extension
The final segment covers Cursor's controversial claim that developers should never write a Content Management System (CMS) again. Cursor recently migrated their own blog away from a headless CMS (Sanity) to a file-system-based approach using Markdown and React components. The rationale is that LLMs need full access to the code and content to be effective; traditional CMS platforms can act as a silo that prevents the AI from "seeing" the data it needs to manipulate.
Sanity provided a mature response, acknowledging that while AI-driven "vibe coding" can create early MVPs quickly, professional platforms still offer essential features like version control, access management, and publishing workflows that are difficult to replicate in a simple file system. The conversation concludes with a technical challenge regarding Terraform modules: how to extend the behavior of a centralized module without forking it. While wrapping modules is a common attempt, the speakers suggest that true extension often requires moving toward a full programming language like Pulumi or the CDKTF to handle complex configuration changes.

*Model: google/gemini-3-flash-preview*
