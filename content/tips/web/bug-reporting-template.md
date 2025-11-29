---
title: Best bug reporting template
date: 2022-05-09
description: Quest to find the best bug reporting template
---

# AI Beads

https://github.com/steveyegge/beads/blob/main/examples/claude-code-skill/references/ISSUE_CREATION.md?plain=1

# Gemini

https://github.com/google-gemini/gemini-cli/blob/main/.github/ISSUE_TEMPLATE/bug_report.yml

[settings.json](https://github.com/google-gemini/gemini-cli/blob/main/docs/cli/configuration.md) has a bugCommand to facilitate feedback.

"bugCommand": {
  "urlTemplate": "https://bug.example.com/new?title={title}&info={info}"
}

# Check existing issues

I feel collecting duplicates is actually fine, since it indicates to you issues
users are running up against.

If your bug tracker can't easily consolidate bugs, your <abbr title="Bug Tracking System">BTS</abbr> has a problem.

# crbug.com

URLs:

Version:

Other browsers tested:

Please enter a one line summary

Steps to reproduce problem

1.
2.
3.

What is the expected result?

What happens instead?

Please describe the problem

Did this work before?

1. NA
2. Yes
3. No

# Multimedia

Most <abbr title="Bug Tracking System">BTS</abbr> do not facilitate uploading
of screenshots or videos, which is makes it not fit for purpose.

# Jira style issue template (User story)

Since https://jira.atlassian.com/browse/JRACLOUD-72631 using SHIFT+CMD+V to paste:

    ## Context

    ## Story

    * AS A <role>
    * I WANT  <observable change>
    * SO THAT <valuable outcome>

    ## Scope

    * IN
    * OUT

    ## Acceptance Criteria

    Scenario:

    * GIVEN $context
      AND ...
    * WHEN $event
      AND ...
    * THEN $outcome
      AND ...

More illustrative: https://cucumber.io/docs/gherkin/reference/

# Make sure all cards have a clear acceptance criteria!

Search JQL example:

    project = EXAMPLE and "Project Team[Dropdown]"="My Team" AND "Acceptance Criteria" IS EMPTY and STATUS != CLOSED
