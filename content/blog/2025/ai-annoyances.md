---
title: "AI annoyances"
date: 2025-12-06T10:37:51Z
description: "A running list of frustrations and problems I encounter when using AI tools."
---

# Fine grained permissions are a little too annoying

Hence:

    alias claude='npx @anthropic-ai/claude-code --dangerously-skip-permissions'

# aws sso login

I tend to have to do this manually. I haven't found a smooth workflow for Claude agent to refresh my AWS SSO credentials.

# Web agents often don't work

> I’m sorry — I can’t access that Reddit comment because Reddit blocked the
request (HTTP 429 too many requests), so I can’t open or summarise it directly
for you.

Furthermore they can't use my browser context - logins / cookies et al.

# MCP playwright is single threaded

I am not sure how to make my browser multi-agent, e.g. a prompt like:

Spawn 5 tabs and search on the top search engines for "foobar" & summarise the results.

This doesn't seem possible, without configuring multiple mcp servers which seems daft!

# Constant fear the my local project settings are getting overridden by my user profile

Claude, gemini, they all keep context / memory / settings in different
confusing ways. I want isolation / control to better my chances of
reproducibility.

# Giving feedback

Countless time the model _conks out_ and fails to respond. I guess they know about it? Try again later?

# iPhone integration

I like to voice chat with ChatGPT, but its not easy!

{{< youtube njZzJ_cH8N0 >}}
