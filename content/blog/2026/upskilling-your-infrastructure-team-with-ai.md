---
title: "Upskilling Your Infrastructure Team with AI"
description: Bring Claude to the table for making AWS Infrastructure decisions with the best information
date: 2026-01-07T11:02:08Z
---

Setup appropriate MCP servers:

    claude mcp add -s project aws-docs uvx awslabs.aws-documentation-mcp-server@latest
    claude mcp add -s project aws-iac-mcp-server uvx awslabs.aws-iac-mcp-server@latest

Ask Claude questions.

Share the conversation:

    uvx claude-code-transcripts --gist

E.g. https://gisthost.github.io/?ace03fd0d84e5ddf765d0c8d5d4cea64/index.html
