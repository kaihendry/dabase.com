---
title: Documenting APIs
date: 2021-11-08
description: Swagger = Openapi 2.0
---

[AWS supports](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-import-api.html):

* https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md
* https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.1.md

The majority of mature tooling is around <a href="https://en.wikipedia.org/wiki/Swagger_(software)">"Swagger"</a> aka OpenAPI 2.0.

https://github.com/stoplightio/spectral is able to perform validation / linting for either.

# The case against OpenAPI

A lighter weight approach of defining APIs without YAML. For example:

* Using [Postman collections](https://www.postman.com/)
* Providing curl examples / language specific examples e.g. https://stripe.com/docs/api?lang=go or https://stripe.com/docs/api?lang=curl

