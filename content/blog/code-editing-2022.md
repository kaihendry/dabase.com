---
title: Code Editing in 2022
date: 2022-03-13T09:12:07+08:00
description: Use a linter, formatter, and LSP
---

When you code you need at **least two helpers** active on your buffer to assist
you:

1. **Code Formatter**, e.g. gofmt or [prettier](https://copilot.github.com/) that rewrites your file on save to a "standard" format
2. **Code Diagnostics** aka a "code linter", e.g. golint or jshint that warns you of problems in your code like unused variables

Setting up these helpers is non-trivial!

Ideally your chosen programming language has a well supported "Language Server
Protocol" (LSP) which can do the above and more like **completions** and
(refactor) **actions**. The neovim "LSP" injection tool
[null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) and its
[BUILTINS](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md)
can give some hints to what helpers you can set up.

## Copilot is really nice to have

<abbr title="To be honest">Tbh</abbr> I find [Github Copilot](https://copilot.github.com/) useful, to
the point where I can't live without it. I use [copilot.vim](https://github.com/github/copilot.vim) from the wonderful [tpope](https://github.com/tpope).

Copilot alleviates the need to look up
[Stackoverflow](https://stackoverflow.com/) or API documentation (can replace
<abbr title="Language Server Protocol">LSP</abbr> "completions" to some extent)
by describing what you are trying to achieve in comments, which saves time.
Boosting productivity.

Copilot effectiveness depends on what you code. If you do generic integration
work which is probably most use cases, it's great. If you do something a little
specialised, it can be annoying.

## Secure code

A **security** linter aka <abbr title="Static application security
testing">SAST</abbr> like [gosec](https://github.com/securego/gosec) and I
don't know of good one for NodeJS. <abbr title="In my opinion">Imo</abbr> a
<abbr title="Static application security testing">SAST</abbr> should ideally be
part of the <abbr title="Language Server Protocol">LSP</abbr>. Not some
security theatre or extra hoop jump.

Further security checks centre around [dependency
management](/blog/2021/nodejs-project-cd/), but they don't integrate
well into your editing session aka LSP currently.

# Conclusion

If you code and you don't have a formatter and diagnostics setup, you must
update your workflow to embrace new productivity standards.
