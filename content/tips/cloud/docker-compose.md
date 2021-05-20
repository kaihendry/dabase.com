---
title: Docker compose environment
date: 2021-05-20
description: direnv or your env?
---

	export FOO=bar
	echo FOO=hello > .env

Use a text editor and save this YAML to `docker-compose.yml`

    version: '3'
    services:
      test:
        image: busybox
        environment:
          FOO: ${FOO}
        command: echo $FOO

What do you think gets printed on `docker-compose up`?
