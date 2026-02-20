---
title: "Adopting AI with steveyegge/beads"
date: 2025-12-10T12:00:00Z
description: "https://dabase.com/podcast/

https://github.com/steveyegge/beads/discussions/430

Goredo: http://www.goredo.cypherpunks.su/"
image: "https://img.youtube.com/vi/eSEg3wKBs-8/hqdefault.jpg"
draft: false

podcast:
  episode: 9
  season: 1
  episodeType: "full"
  duration: 2766
  audioUrl: "/podcast/audio/009-adopting-ai-with-steveyeggebeads.mp3"
  audioSize: 66381164
  youtubeId: "eSEg3wKBs-8"
  youtubeUrl: "https://www.youtube.com/watch?v=eSEg3wKBs-8"
---

https://dabase.com/podcast/

https://github.com/steveyegge/beads/discussions/430

Goredo: http://www.goredo.cypherpunks.su/

[Watch on YouTube](https://www.youtube.com/watch?v=eSEg3wKBs-8)

## `summarize "https://youtu.be/eSEg3wKBs-8" --timestamps --slides`

This technical discussion explores the evolving landscape of AI-driven development, specifically focusing on the Beads (BD) issue tracker and the integration of Large Language Models (LLMs) into daily coding workflows. The speakers examine how local, high-performance tools are replacing sluggish enterprise software and how "agentic" workflows are shifting from simple chat interfaces to structured, multi-step processes. By leveraging tools like Claude and Gemini alongside specialized utilities, developers are finding new ways to manage complexity in large monorepos while maintaining high velocity.

[![Slide 1](/podcast/slides/eSEg3wKBs-8/youtube-eSEg3wKBs-8/slide_0001_0.60s.png)](https://youtu.be/eSEg3wKBs-8?t=0)
## Solving the Jira Latency Problem
The conversation begins with a critique of traditional project management tools, specifically Jira, which is described as being as slow as molasses. To circumvent the latency and friction of web-based enterprise software, the developers discuss a "clever hack" involving Beads (BD), a local issue tracker powered by SQLite. This system allows for a fast, local-first experience that can automatically sync back to Jira, effectively acting as a high-performance cache for task management. By moving the issue-tracking workflow to a local environment, developers can use AI to analyze and organize sprints without the overhead of a browser-based UI. This approach saves hours of manual effort typically spent chasing colleagues for card updates or template compliance. The speakers emphasize that the primary goal is to reduce the friction between having an idea and documenting it as a trackable task.
*Jura is like molasses. So if I can if I can sync this down to BD and get AI to run over it, I've saved myself 3 hours.*

[![Slide 2](/podcast/slides/eSEg3wKBs-8/youtube-eSEg3wKBs-8/slide_0002_452.99s.png)](https://youtu.be/eSEg3wKBs-8?t=452)
## Modern Tooling and Ecosystem Shifts
The discussion shifts to the rapid evolution of development tools in the Python and JavaScript ecosystems. The speakers praise the Astral suite, particularly UV and Ruff, for making Python development significantly more tolerable. Ruff is highlighted for its extreme speed, replacing multiple legacy tools like Black, Flake8, and Bandit with a single Rust-based binary that runs in milliseconds. This mirrors trends in the JavaScript world where Biome is replacing ESLint and Vitest is replacing Jest. There is a shared appreciation for clean, readable code, with a nostalgic look back at the work of TJ Hollowaychuk and the original Express framework. The speakers also touch upon the influence of DHH (David Heinemeier Hansson) and the tension between technical excellence and the political or philosophical stances often attached to software projects. They conclude that while they may disagree with certain philosophies, the quality of the underlying technical work remains the primary draw.

[![Slide 3](/podcast/slides/eSEg3wKBs-8/youtube-eSEg3wKBs-8/slide_0003_913.95s.png)](https://youtu.be/eSEg3wKBs-8?t=913)
## Hardware Constraints and Terminal Performance
A segment of the conversation focuses on the physical hardware supporting these AI workflows. One speaker recounts purchasing a high-end Samsung NVMe SSD in Vietnam, noting a "sense of urgency" created by high demand for AI-related hardware in neighboring regions. This hardware upgrade is intended to support a transition back to Linux-based environments like Umari. On the software side, the Ghosty terminal is recommended for its speed and its ability to fix specific scrolling bugs encountered in other environments. The developers also troubleshoot performance issues within the Beads system itself, identifying leftover daemon sockets as a common cause of slowdowns. They note that because Beads is heavily AI-generated, it experiences a rapid release cycle—sometimes every two days—which leads to a slew of duplicate commands and occasional regressions or file corruption issues that require manual intervention in the underlying source files.

[![Slide 4](/podcast/slides/eSEg3wKBs-8/youtube-eSEg3wKBs-8/slide_0004_1374.92s.png)](https://youtu.be/eSEg3wKBs-8?t=1374)
## Advanced Issue Tracking with Pearls
The speakers dive into "Pearls" (or Perles), a Terminal User Interface (TUI) for Beads that offers a more robust experience than the standard web UI. Pearls allows for sophisticated navigation of deeply nested task trees and dependencies, which is essential for managing complex "epics." Unlike standard Kanban boards that struggle with cross-referencing, this TUI enables developers to visualize the full progress of an epic across dozens of sub-tasks. The system uses a specialized query language called BQL (Beads Query Language), which includes a lexer and parser to handle complex views. While there is some irony in a "simple" tool quickly adopting the complexity of the enterprise software it seeks to replace, the speakers argue that the local-first, terminal-based nature of Pearls makes it far more efficient for power users. They specifically highlight the utility of seeing "check-ins" from AI agents directly within the task tree.

[![Slide 5](/podcast/slides/eSEg3wKBs-8/youtube-eSEg3wKBs-8/slide_0005_1835.88s.png)](https://youtu.be/eSEg3wKBs-8?t=1835)
## The Rise of Resumable AI Agents
A major theme is the transition from static LLM prompts to dynamic, resumable agents. The speakers discuss Claude's new capabilities that allow agents to be sent to the background and resumed later, preserving context across sessions. This is seen as a critical step toward true agentic workflows where a "main" agent can spawn sub-agents to handle specific, parallelizable tasks. The conversation references Anthropic's recent emphasis on "skills" rather than just "agents," suggesting that the future of AI integration lies in attaching specific capabilities to models rather than treating them as general-purpose chat bots. They discuss the need for better package management for these skills, similar to how MCP (Model Context Protocol) or GPT-script attempts to bundle capabilities. The goal is to create a system where an agent can be given a highly detailed task—including specific files to modify—and execute it with minimal supervision.

[![Slide 6](/podcast/slides/eSEg3wKBs-8/youtube-eSEg3wKBs-8/slide_0006_2296.88s.png)](https://youtu.be/eSEg3wKBs-8?t=2296)
## Optimizing AI Workflows and Benchmarking
The final section details practical strategies for balancing cost, speed, and accuracy when using multiple AI models. One developer describes a workflow where Claude Opus is used for high-level planning and task generation due to its superior reasoning, while cheaper models like Gemini or Claude Sonnet are used for the actual implementation. This "spec-kit" approach involves breaking down a large project into a detailed to-do list where each task includes a description, design, and acceptance criteria. By providing agents with a narrow scope and specific file targets, developers can prevent "context drift" and ensure the AI remains focused. The speakers admit that while they want to automate everything, they still maintain a "human-in-the-loop" approach for commits to avoid accidental file deletions or poor-quality code. They emphasize the importance of a "retro" process to learn which prompts and task structures yield the best results.
*I'm very religiously asking the every time that a task was not correct I ask it to record the problems as comments on the task.*

*Model: google/gemini-3-flash-preview*
