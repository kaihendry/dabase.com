---
title: Postman collection to Swagger
date: 2022-04-28
description: How to create Swagger documentation using Postman
---

Using https://joolfe.github.io/postman-to-openapi

    ../example.yaml:
    	p2o ~/Documents/example.postman_collection-2022-03-21.json -f $@ -o options.json

    clean:
    	rm -f ../example.yaml

options.json has a structure like so:

    [
      "auth",
      "externalDocs",
      "info",
      "responseHeaders",
      "servers"
    ]
