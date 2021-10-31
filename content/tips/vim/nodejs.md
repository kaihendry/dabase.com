---
date: 2021-10-31
title: Editing Javascript in vim in Docker
description: Can vim + myriad of plugins actually functionally beat code?
---

I'm spoilt by [vim-go](https://github.com/fatih/vim-go), goformat, goimports, a
[vim IDE](https://github.com/kaihendry/goide) that works productively for
programming Golang.

Now since I code in Javascript for work, especially for the [AWS Cloud
Development Kit](https://youtu.be/Du0l6z3dMVc) I want the same features in vim!

# The test

	git clone https://github.com/kaihendry/sam-cdk-app-demo.git

Open lib/aws-sam-cli-cdk-hello-world-stack.js

## Formatting

Add a poorly formatted console.log, will it get reformatted on save?

## Intellisense

Remove **runtime:** from the `lambda.Function` constructor. Is the editor (or
integrated language server) smart enough to auto complete / suggest that
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

# [iimuz/nvim-code](https://github.com/iimuz/dockerfile/blob/master/nvim-node/Dockerfile)

Seems to be hinged on neovim 0.4x. Moving on..

# [jcirizar/vim](https://github.com/jcirizar/vim)

First to warn me:

	[coc.nvim] No ESLint configuration (e.g .eslintrc) found for file: /app/lib/aws-sam-cli-cdk-hello-world-stack.js

Completion seems useless:

<img src="https://s.natalian.org/2021-10-31/1635649250_1918x1047.png">

Is <abbr title="Conquer of Completion">CoC</abbr> even working??

# [leny/docker-neovim](https://github.com/leny/docker-neovim/tree/master)

Fails to build:

<img src="https://s.natalian.org/2021-10-31/1635649547_1918x1047.png" alt="/bin/sh: pip3: not found">

# [thled/docker-vim-ts](https://github.com/thled/docker-vim-ts)

A different sort of python build error!

<img src="https://s.natalian.org/2021-10-31/1635649757_1918x1047.png" alt="gcc: fatal error: cannot execute 'cc1plus': execvp: No such file or directory">

# [protometa/editor](https://github.com/protometa/editor)

Could not get it to open `lib/aws-sam-cli-cdk-hello-world-stack.js`
