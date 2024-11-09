---
title: VScode Regex
date: 2023-12-06T12:41:23Z
description: Mastering search and replace regex in Visual Studio Code
---

Imagine a file with comments that you needed to remove:

    "Remove this silly comment please"
    keepme()

To match content between the quote and remove it, you could use this regex:

    "(.*)"\n

<img src="https://i.imgur.com/hLH163k.png">

But what if the comment was multiline?

    keepme()
    """
    Remove this silly comment please
    and this one too
    """
    alsokeepme()

You could use this regex:

    """(.|\n)*"""\n   

You can do a lot more with regex in VS Code, like [reusing what's matched](https://code.visualstudio.com/docs/getstarted/tips-and-tricks#_search-and-modify) and [changing case](https://code.visualstudio.com/docs/editor/codebasics#_case-changing-in-regex-replace).

VS Code also has [Multiline search input](https://code.visualstudio.com/updates/v1_30#_multiline-search-input), which is useful for matching content across multiple lines.

Visual Studio Code uses the PCRE2 regex engine and you can [test your regex here](https://regex101.com/r/jn6A0B/1). However for [workspace searches ripgrep/rust regex engine](https://github.com/microsoft/vscode/wiki/Search-Issues#notes-on-regular-expression-support) is used, and if the regex fails it will fall back to PCRE2.