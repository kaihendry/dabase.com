---
title: Parsing JSON Web Tokens
date: 2021-04-13T10:39:14+08:00
description: Decoding a JWT with JQ
---

Using the example Bearer token from https://jwt.io/

	Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c

## Header

	(ins)[hendry@t14s tmp]$ cat token2 | jq -R 'split(".") | .[0] | @base64d | fromjson'
	{
	  "alg": "HS256",
	  "typ": "JWT"
	}

## Payload

	(ins)[hendry@t14s tmp]$ cat token2 | jq -R 'split(".") | .[1] | @base64d | fromjson'
	{
	  "sub": "1234567890",
	  "name": "John Doe",
	  "iat": 1516239022
	}

