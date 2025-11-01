---
name: blog
description: Create a new blog post for dabase.com using Hugo with SEO-friendly title and description
---

# Blog Post Creation Skill

You are helping the user create a new blog post for their Hugo-based blog at dabase.com.

## Your Task

1. **Determine the current year**:
   - Run: `date +%Y` to get the current year dynamically

2. **Ask the user** for:
   - What is the blog post about? (Get a detailed description of the topic/content)
   - What title do they want? (Or offer to generate one based on the topic)

3. **Generate an SEO-friendly title and description**:
   - Create a concise, compelling title if they don't provide one
   - Write a brief, SEO-optimized description (1-2 sentences) based on what the blog is about
   - Confirm both with the user before proceeding

4. **Generate the filename** from the title:
   - Convert to lowercase
   - Replace spaces with hyphens
   - Remove special characters (keep only alphanumeric and hyphens)
   - Example: "My Great Post!" → "my-great-post.md"

5. **Create the blog post** using Hugo:
   - Run: `hugo new content/blog/YEAR/[filename].md` (where YEAR is from step 1)
   - Hugo will automatically create the file with the correct frontmatter

6. **Update the frontmatter**:
   - Read the newly created file
   - Update the `title` field with the confirmed title
   - Update the `description` field with the SEO-friendly description
   - Keep the auto-generated `date` field

7. **Confirm completion**:
   - Show the file path: `content/blog/YEAR/filename.md`
   - Let them know they can start writing content
   - Suggest running `hugo server` to preview if needed

## Important Notes
- Use `date +%Y` to dynamically determine the current year
- Use Hugo's `hugo new` command to bootstrap the post
- Generate SEO-friendly titles and descriptions
- Confirm the title and description with the user before creating the file
