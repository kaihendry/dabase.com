---
title: "Apex Up Logs"
date: 2023-01-29T16:34:05+08:00
description: Awesome structured log querying
---

[tjholowaychuk](https://twitter.com/tjholowaychuk)'s logging **developer experience** was the best I've ever seen!

# Commands

Source: https://apex.sh/docs/up/commands/#logs

Show logs from the past day.

    $ up logs

Show logs from the past 45 minutes.

    $ up -S 45m logs

Show logs from the past 12 hours.

    $ up -S 12h logs

Show live log output.

    $ up logs -f

Show live logs from production only.

    $ up logs -f production

Show live error logs from production only.

    $ up logs -f 'production error'

Show error logs, which include 5xx responses.

    $ up logs error

Show error and warning logs, which include 4xx and 5xx responses.

    $ up logs 'warn or error'

Show logs with a specific message.

    $ up logs 'message = "user login" method = "GET"'

Show logs with a specific message with implicit =:

    $ up logs '"user login" method = "GET"'

Show responses with latency above 15ms.

    $ up logs 'duration > 15'

Show 4xx and 5xx responses in production

    $ up logs 'production (warn or error)'

Show production 5xx responses with a POST, PUT, or DELETE method.

    $ up logs 'production error method in ("POST", "PUT", "DELETE")

Show 200 responses with latency above 1500ms.

    $ up logs 'status = 200 duration > 1.5s'

Show responses with bodies larger than 100kb.

    $ up logs 'size > 100kb'

Show 4xx and 5xx responses.

    $ up logs 'status >= 400'

Show emails containing @apex.sh.

    $ up logs 'user.email contains "@apex.sh"'

Show emails ending with @apex.sh.

    $ up logs 'user.email = "*@apex.sh"'

Show emails starting with tj@.

    $ up logs 'user.email = "tj@*"'

Show logs with a more complex query.

    $ up logs 'method in ("POST", "PUT") ip = "207.*" status = 200 duration >= 50'

# The source of the structured logs

Retrieved via Cloudwatch.

The request:

    {
    	"fields": {
    		"app": "count",
    		"commit": "cae48d1",
    		"id": "3a9b4760-036a-4a53-952e-d284877d1c3c",
    		"ip": "185.191.171.38",
    		"method": "GET",
    		"path": "/sitemap.xml",
    		"plugin": "logs",
    		"query": "",
    		"region": "ap-southeast-1",
    		"stage": "staging",
    		"version": "27"
    	},
    	"level": "info",
    	"timestamp": "2023-01-22T15:11:52.789537324Z",
    	"message": "request"
    }

The response:

    {
    	"fields": {
    		"app": "count",
    		"commit": "cae48d1",
    		"duration": 1,
    		"id": "3a9b4760-036a-4a53-952e-d284877d1c3c",
    		"ip": "185.191.171.38",
    		"method": "GET",
    		"path": "/sitemap.xml",
    		"plugin": "logs",
    		"query": "",
    		"region": "ap-southeast-1",
    		"size": 1777,
    		"stage": "staging",
    		"status": 200,
    		"version": "27"
    	},
    	"level": "info",
    	"timestamp": "2023-01-22T15:11:52.791299457Z",
    	"message": "response"
    }
