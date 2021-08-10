---
title: Atlassian tips
date: 2021-08-10T17:22:15+08:00
description: Tips whilst working with Atlassian's JIRA and Confluence
---

If you are unfortunate enough to work with Atlassian products I recommend:

# Learning JIRA shortcuts

<img src="https://s.natalian.org/2021-08-10/shotcuts.png" alt="Hit ? in Jira to see shortcuts">

Navigating between issues quickly and hitting O to Open the specific issue is my favourite party trick.

Another way to make accessing issues easier is to create a "search engine" in Chrome upon chrome://settings/searchEngines

<img src="https://s.natalian.org/2021-08-10/search-engine.png" alt="Other search engines">

# Jira reports

[JQL cheat sheet](https://3kllhk1ibq34qk6sp3bhtox1-wpengine.netdna-ssl.com/wp-content/uploads/2017/12/atlassian-jql-cheat-sheet-2.pdf)

It's common in Agile processes to report on what has been marked "Done" in an
iteration. An iteration is usually a week, but it can be several.

	e.g. project = "<project name>" AND status changed to "Done" during (2021-07-26, 2021-07-30) AND (any other filters you are using for your project)
You can replace the dates with e.g. startOfWeek("-6d") for last Monday

In Confluence you can add a Jira query and it will generate the list of issues
for you. You need to save the page for the table to show up!
