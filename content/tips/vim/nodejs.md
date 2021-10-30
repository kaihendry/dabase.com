---
date: 2021-10-31
title: Editing Javascript in vim
description: Edit a JS project in vim as well as VS code
---

I'm spoilt by vim-go, goformat, goimports, a [vim
IDE](https://github.com/kaihendry/goide) that works really well.

Now since I code in Javascript for work, I want the same features in vim!

# The test

	git clone https://github.com/kaihendry/sam-cdk-app-demo.git

Open lib/aws-sam-cli-cdk-hello-world-stack.js

## Formatting

Add a poorly formatted console.log, will it get reformatted on save?

## Intellisense

Remove **runtime:** from the `lambda.Function` constructor. Is the editor (or
integrated language server) smart enough to auto complete / suggest that
runtime is manadatory and needs to put back?

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

## 
