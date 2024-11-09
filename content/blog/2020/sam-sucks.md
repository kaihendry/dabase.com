---
title: AWS SAM's HTTP interface sucks
date: 2020-09-12T17:20:21+08:00
description: The API for AWS Serverless Application Model (AWS SAM) is non-standard and non-portable
---

A hello world http API implemented with AWS SAM looks like:

	func handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
			return events.APIGatewayProxyResponse{
					StatusCode: 200,
					Headers: map[string]string{
							"Content-Type": "text/plain",
					},
					Body: "Hello World",
			}, nil
	}

	func main() {
			lambda.Start(handler)
	}

[Source](https://github.com/aws/aws-sam-cli-app-templates/blob/master/go1.x/cookiecutter-aws-sam-hello-golang/%7B%7Bcookiecutter.project_name%7D%7D/hello-world/main.go)

Why didn't they simply abstract this insane interface with the **standard**,
**portable** and beautiful HTTP request response model?

	func main() {
		addr := ":" + os.Getenv("PORT")
		http.HandleFunc("/", hello)
		log.Fatal(http.ListenAndServe(addr, nil))
	}

	func hello(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, "Hello World")
	}

[Source](https://github.com/apex/up-examples/blob/master/oss/golang-basic/main.go)

SAM's events.APIGatewayProxyRequest is just awful to use. You have to test it
within a Docker environment which is ~5s
[slow](https://github.com/aws/serverless-application-model/issues/1710). If you
use the standard interface, you can simply use [the gin
reloader](https://github.com/codegangsta/gin) and you have a very fast
iterative workflow.

This is why I still use [Apex Up](https://apex.sh/docs/up/) to develop my Go
HTTP functions. Allows me to use a standard sane interface and allows for a
sane local workflow for fast, joyful development iterations.

# What happens if Apex up is no more?

I recommend using Apex Up, but what happens if it falls away?

Apex Up author and savant [@tjholowaychuk](https://twitter.com/tjholowaychuk)
published his critical <https://github.com/apex/gateway> mapping and you can
recreate Apex Up functionality labouriously with AWS SAM like so:
https://github.com/kaihendry/aws-sam-gateway-example
