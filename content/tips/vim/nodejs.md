---
date: 2021-10-31
title: Editing Javascript in vim in Docker
description: Can neovim + plugins actually functionally beat Visual Studio code?
---

I'm spoilt by [vim-go](https://github.com/fatih/vim-go), goformat, goimports, a
[vim IDE](https://github.com/kaihendry/goide) that works productively for
programming Golang.

Now since I code in Javascript for work, especially for the [AWS Cloud
Development Kit](https://youtu.be/Du0l6z3dMVc) I want the same features in vim!

# The test

UPDATE: This test assumes Javascript, and for proper completion [typescript types](https://github.com/kaihendry/dabase.com/commit/7173d4ece54a6cfc76b30cfb8b8db8945d45cbaa#commitcomment-58991530) is more pragmatic.

	git clone https://github.com/kaihendry/sam-cdk-app-demo.git

Open lib/aws-sam-cli-cdk-hello-world-stack.js

## Formatting

Add a poorly formatted console.log, will it get reformatted on save?

## Intellisense

Remove **runtime:** from the `lambda.Function` constructor. Is the editor (or
integrated language server) [smart enough to auto complete](https://s.natalian.org/2021-10-28/link-to-doc.mp4) / suggest that
**runtime** is mandatory and needs to put back?

Next test: Setup a dynamodb table. Can the editor automatically import
"@aws-cdk/aws-dynamodb"?

# Dockerized neovim

In order to reproduce issues with my own setup and others, I'm going to
evaluate different neovim configurations with the help of Docker containers.

I wouldn't realistically edit using Docker because it's far too slow to startup!!

## Spacevim

	docker run -it --rm spacevim/spacevim

<img src="https://s.natalian.org/2021-10-31/spacevim.png">

A whole bunch of text errors on startup. Er next!

## [Sh1d0w/nvim-ide](https://github.com/Sh1d0w/nvim-ide#features)

<img src="https://s.natalian.org/2021-10-31/1635639280_1918x1047.png" alt="console.constuctor">

`console.` completion sucks, no autoformatting. Docs are nice though:

<img src="https://s.natalian.org/2021-10-31/docs.png">

Removing runtime, then correctly suggests I need **runtime back**:

<img src="https://s.natalian.org/2021-10-31/runtime-suggestion.png">

If I save the file without runtime, there is no warning that my program will fail. Tbh VScode doesn't seem to show my program will fail either missing **runtime**!

Now adding:

	const atable = new dynamodb.Table(this, "hello-world-table", {

<img src="https://s.natalian.org/2021-10-31/chokes.png">
<img src="https://s.natalian.org/2021-10-31/chokes2.png">

I give it 2/5 rating. It's probably coc-tsserver mostly at fault or probably me.

## [iimuz/nvim-code](https://github.com/iimuz/dockerfile/blob/master/nvim-node/Dockerfile)

Seems to be hinged on neovim 0.4x. Moving on..

## [jcirizar/vim](https://github.com/jcirizar/vim)

First to warn me:

	[coc.nvim] No ESLint configuration (e.g .eslintrc) found for file: /app/lib/aws-sam-cli-cdk-hello-world-stack.js

Completion seems useless:

<img src="https://s.natalian.org/2021-10-31/1635649250_1918x1047.png">

Is <abbr title="Conquer of Completion">CoC</abbr> even working??

# [leny/docker-neovim](https://github.com/leny/docker-neovim/tree/master)

Fails to build:

<img src="https://s.natalian.org/2021-10-31/1635649547_1918x1047.png" alt="/bin/sh: pip3: not found">

## [thled/docker-vim-ts](https://github.com/thled/docker-vim-ts)

A different sort of python build error!

<img src="https://s.natalian.org/2021-10-31/1635649757_1918x1047.png" alt="gcc: fatal error: cannot execute 'cc1plus': execvp: No such file or directory">

## [protometa/editor](https://github.com/protometa/editor)

Could not get it to open `lib/aws-sam-cli-cdk-hello-world-stack.js`

## [quay.io/nvim-lsp/try.nvim:nightly-typescript](https://github.com/kaihendry/dabase.com/commit/7173d4ece54a6cfc76b30cfb8b8db8945d45cbaa#commitcomment-58995093)

[mjlbach](https://github.com/mjlbach) put me onto his LUA based neovim configuration: <https://github.com/nvim-lsp/try.nvim/blob/master/typescript/init.lua>

I will probably switch to using https://github.com/nvim-lua/kickstart.nvim without a Docker image.

**hrsh7th/nvim-cmp** is the Autocompletion plugin, not "nvim-compe" which is deprecated.

## [hendry/js-nvim](https://github.com/kaihendry/js-nvim)

UPDATE: Complete rewrite in https://github.com/kaihendry/nvim

This is my project for my own sanity checking with <abbr title="Conquer of Completion">CoC</abbr>!

Auto complete on `console.` is sensible:

<img src="https://s.natalian.org/2021-10-31/1635659600_1918x1047.png">

Docs are OK

<img src="https://s.natalian.org/2021-10-31/docs.png">

But it doesn't seem to work on <abbr title="Cloud Development Kit">CDK</abbr>. No docs.

* Doesn't show runtime: is missing, if I [remove it from `new lambda.Function`](https://github.com/kaihendry/sam-cdk-app-demo/blob/8f27ea12a30c0a8b13f7eedd49b065b8c8478a58/lib/aws-sam-cli-cdk-hello-world-stack.js#L12)
* No auto imports -- do I need a [jsconfig.json](https://code.visualstudio.com/docs/languages/jsconfig) ??
* Don't actually understand how I should get format on save working. Do I need a eslintrc in https://github.com/kaihendry/sam-cdk-app-demo ??

😩

# Conclusion

I learned two things about editing Javascript with vim.

First, for a experience comparable to the exemplary
[vim-go](https://github.com/fatih/vim-go) you need to ensure you're actually
working with **TypeScript Types**. This is actually non-trivial for smaller
packages where [type definitions are
contributed](https://github.com/DefinitelyTyped/DefinitelyTyped) by the community.

Neovim departs from vim with its LUA language integration and its inbuilt
language server `:LspInfo`. I think I will give it a try. I encourage you to
try too:

	docker run --rm -it --entrypoint=sh -v $(pwd):/src quay.io/nvim-lsp/try.nvim:nightly-typescript

That said, don't get <abbr title="Fear of missing out">FOMO</abbr>. Editing vim
without this crazy configuration is actually the better place to be!
