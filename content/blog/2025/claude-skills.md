---
title: "Claude Skills"
date: 2025-11-01T19:48:18Z
description: How I made a Claude skill for Hugo
---

## Creating a Blogging Skill for Claude Code

I wanted to streamline my blogging workflow with Claude Code, so I created a custom skill that helps me create new blog posts using Hugo. Here's how I did it.

## Understanding Claude Skills

Claude Skills are reusable automation workflows that activate automatically when you make relevant requests. They live in `.claude/skills/` directories and consist of a `SKILL.md` file with frontmatter and instructions.

## The Challenge

My blog uses Hugo with a specific structure:
- Posts are organized by year: `content/blog/YEAR/filename.md`
- Each post needs YAML frontmatter with title, date, and description
- Filenames should be SEO-friendly (lowercase, hyphenated)

I wanted Claude to:
1. Dynamically determine the current year
2. Help me create SEO-friendly titles and descriptions
3. Use Hugo's `hugo new` command to bootstrap posts
4. Update the frontmatter automatically

## Creating the Skill

First, I learned that skills need a specific structure:
- A directory in `.claude/skills/`
- A `SKILL.md` file (uppercase!) with frontmatter
- The frontmatter needs a `name` and `description`

I created the skill at `.claude/skills/blog/SKILL.md`:

```yaml
---
name: blog
description: Create a new blog post for dabase.com using Hugo with SEO-friendly title and description
---
```

## The Key Insights

1. **Use `date +%Y`** - Instead of hardcoding the year, the skill runs this command to dynamically get the current year.

2. **Leverage Hugo's CLI** - Rather than manually creating files, use `hugo new content/blog/YEAR/filename.md` to bootstrap with proper frontmatter.

3. **SEO Focus** - The skill prompts for what the post is about and generates appropriate titles and descriptions.

4. **Filename Generation** - Converts titles to lowercase, replaces spaces with hyphens, and removes special characters.

## The Complete Workflow

When I ask Claude to create a blog post, it:
1. Runs `date +%Y` to get the year
2. Asks what the blog is about
3. Suggests an SEO-friendly title and description
4. Generates a clean filename from the title
5. Runs `hugo new content/blog/2025/filename.md`
6. Updates the frontmatter with the title and description
7. Confirms the file location

## Common Pitfall

Initially, I created a single `blog.md` file in `.claude/skills/`, but skills must be directories containing a `SKILL.md` file (uppercase). Once I fixed that structure, everything worked perfectly.

## The Result

Now I can simply tell Claude "I want to write a blog post about X" and it handles all the boilerplate, letting me focus on writing content. The skill is version-controlled with my blog repository, so it's available across machines.

Skills are a powerful way to encode your project-specific workflows directly into Claude Code, making repetitive tasks automatic and consistent.
