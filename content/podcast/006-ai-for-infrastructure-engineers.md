---
title: "AI for Infrastructure Engineers"
date: 2025-11-21T12:00:00Z
description: "https://youtu.be/cMSprbJ95jg?t=3675

If you're using an IDE you're a bad engineer!"
image: "https://img.youtube.com/vi/54Z4HlO_sW8/hqdefault.jpg"
draft: false

podcast:
  episode: 6
  season: 1
  episodeType: "full"
  duration: 3715
  audioUrl: "/podcast/audio/006-ai-for-infrastructure-engineers.mp3"
  audioSize: 89170604
  youtubeId: "54Z4HlO_sW8"
  youtubeUrl: "https://www.youtube.com/watch?v=54Z4HlO_sW8"
---

https://youtu.be/cMSprbJ95jg?t=3675

If you're using an IDE you're a bad engineer!

[Watch on YouTube](https://www.youtube.com/watch?v=54Z4HlO_sW8)

## `summarize "https://youtu.be/54Z4HlO_sW8" --timestamps --slides`

Two infrastructure engineers discuss the rapid evolution of Artificial Intelligence tools and their profound impact on DevOps and software development workflows. The conversation centers on the release of Gemini 3 Pro, the ongoing competition with Claude 4.5, and the shifting expectations for modern engineers. They explore practical applications, such as refactoring legacy codebases and managing token budgets, while addressing the cultural and security challenges of integrating AI into enterprise environments.

[![Slide 1](/podcast/slides/54Z4HlO_sW8/youtube-54Z4HlO_sW8/slide_0001_1.54s.png)](https://youtu.be/54Z4HlO_sW8?t=1)
## The end of the IDE era
The discussion opens with a provocative "hot take" from a recent AI summit suggesting that traditional Integrated Development Environments (IDEs) may soon be obsolete for high-performing engineers. The core argument is that the developer's role is shifting from manual code editing to a high-level review process. Instead of writing every line, engineers are increasingly using tools like anti-gravity and cloud code to review AI-generated diffs and proposals. This "plan mode" allows the AI to ask clarifying questions before executing complex tasks, which significantly improves the accuracy of the output.
*“You're a bad engineer if you use an IDE by the end of the year.”*
The speakers note that while some developers still prefer the speed and control of the Command Line Interface (CLI), the integration of AI into the development environment is becoming seamless. New features allow for instant file rewrites and PR-style reviews within the editor, making the traditional process of watching an LLM slowly output code feel antiquated. The focus is now on providing feedback to the model's assumptions rather than manual syntax correction.

[![Slide 2](/podcast/slides/54Z4HlO_sW8/youtube-54Z4HlO_sW8/slide_0002_611.24s.png)](https://youtu.be/54Z4HlO_sW8?t=611)
## Comparing Gemini 3 and Claude 4.5
The engineers evaluate the current landscape of Large Language Models, specifically comparing Google's Gemini 3 and Anthropic's Claude 4.5. While Gemini has improved its terminal experience and scrolling stability, Claude remains a favorite for complex engineering tasks due to its consistency. In contrast, OpenAI's Codex is described as being "off the map" because it lacks essential features like project-based configuration and shell command support. The competition between these providers is seen as a "golden age" for developers, though it requires careful model selection.
Frustrations often arise when models default to "Flash" versions, which are faster but significantly less capable for deep technical work. The speakers emphasize that choosing the right model often comes down to "feel" and real-world performance rather than public benchmarks, which are frequently perceived as manipulated or unrepresentative of actual engineering challenges. They highlight the importance of having access to the most advanced models, such as Claude 4.5, to ensure the AI can handle large codebases without losing context.

[![Slide 3](/podcast/slides/54Z4HlO_sW8/youtube-54Z4HlO_sW8/slide_0003_1230.48s.png)](https://youtu.be/54Z4HlO_sW8?t=1230)
## Token economics and prompt optimization
Managing the cost and limits of AI usage is a critical skill for modern engineers. Most providers now implement weekly token budgets in addition to session-based limits to prevent account sharing and manage API costs. One engineer describes the experience of monitoring his "supply" of tokens like a drug, carefully choosing which tasks to delegate to the AI and which to perform manually to avoid running out of credits before a deadline. This involves a strategic balance between using the model for heavy troubleshooting across hundreds of files versus simple tasks like renaming directories.
To improve efficiency, developers are beginning to analyze their own usage logs. By parsing JSON files that store AI conversations and screenshots, engineers can identify where commands fail—such as the AI looking in the wrong directory—and update their instructions to focus on specific areas. This level of meta-analysis is seen as a key skill for future AI consultancies. The discussion also touches on the "Pelican on a bicycle" test, an unofficial benchmark used to gauge a model's reasoning and creative capabilities, where Gemini 3 reportedly performed exceptionally well.

[![Slide 4](/podcast/slides/54Z4HlO_sW8/youtube-54Z4HlO_sW8/slide_0004_1849.72s.png)](https://youtu.be/54Z4HlO_sW8?t=1849)
## Refactoring legacy code with AI
A practical case study involves refactoring a seven-year-old Go monorepo using Gemini 3. The AI was tasked with separating CLI binaries and creating a shared interface, a task it performed surprisingly well despite the "messy" nature of the legacy code. The process relied heavily on "golden files" or snapshot testing, where the AI's output is compared against known good states. This approach allowed the engineer to validate the AI's refactoring efforts quickly, though it also revealed the model's tendency to miss certain edge cases during cleanup.
*“I'm just staging files until I'm happy and I know that things work and then I want to do commit because I like my commits to work.”*
Despite the AI's speed, the engineers express caution regarding automated commits. The preferred workflow involves letting the AI stage changes, which the human then reviews and manually commits via tools like LazyGit. This maintains a "human-in-the-loop" safety check, preventing the AI from introducing "spaghetti code" or edge-case errors that could lead to long-term maintenance problems. The tension between AI-driven speed and long-term code quality remains a central concern for senior engineers.

[![Slide 5](/podcast/slides/54Z4HlO_sW8/youtube-54Z4HlO_sW8/slide_0005_2468.92s.png)](https://youtu.be/54Z4HlO_sW8?t=2468)
## Cultural shifts and team adoption
The adoption of AI tools within engineering teams is uneven, creating a divide between those who embrace the new workflow and those who resist it. While some engineers see massive productivity gains, others—often senior staff—remain reluctant to change their established habits. This can lead to situations where a few individuals perform manual reviews on a flood of AI-generated code, creating a bottleneck. The speakers suggest that organizations should encourage adoption through "brown bag" sessions and shared prompt databases to bridge this gap.
The integration of AI "skills" or agents into tools like VS Code is seen as the next step in making these workflows more accessible. However, teaching the AI how to use specific CLI tools, such as the GitHub CLI (GH), remains a complex task. The engineers discuss the "progressive disclosure" of AI skills, where the model starts with basic flows and gradually learns more complex commands. This approach helps junior developers become more productive while allowing senior engineers to focus on high-level architecture and system reliability.

[![Slide 6](/podcast/slides/54Z4HlO_sW8/youtube-54Z4HlO_sW8/slide_0006_3088.17s.png)](https://youtu.be/54Z4HlO_sW8?t=3088)
## Enterprise security and the future of AI
Enterprise adoption of AI is complicated by concerns over proprietary data and copyright. Microsoft and GitHub have addressed this by offering legal indemnification for Copilot users, promising to support customers in lawsuits if the AI generates copyrighted code. They also implement filters to prevent the output of known licensed snippets. However, many corporate AI policies remain unclear, creating "FUD" (Fear, Uncertainty, and Doubt) that can hinder innovation. Some workplaces use GitHub CodeSpaces to ensure that proprietary code remains in a controlled environment rather than on local machines.
Looking forward, there is a debate about whether AI progress will plateau due to a limited supply of high-quality training data. While some believe the technology will continue to expand indefinitely, others suggest we are hitting a surge that may eventually level off. Regardless, the current ability of companies like Google to use their own advanced models internally gives them a massive edge in accelerating product development. The conversation concludes by emphasizing that despite the uncertainty and the potential for a plateau, it is an incredibly exciting time to be working in infrastructure and DevOps.

*Model: google/gemini-3-flash-preview*
