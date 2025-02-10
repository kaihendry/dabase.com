---
title: Go's Dockerfile journey
date: 2023-08-11T15:51:34+01:00
description: Creeping complexity in packaging Go with Docker
---


Once upon a time all you needed to Dockerize an app was the [2016 deprecated](https://github.com/microsoft/vscode-docker/issues/176) [onbuild](https://go.dev/blog/docker):

    FROM golang:onbuild
    EXPOSE 8080

Then we went multistage:

    FROM alpine:latest
    RUN apk --no-cache add ca-certificates
    COPY --from=builder /go/bin/app /app
    ENTRYPOINT ./app


{{< x user="MattJamesBoyle" id="1689536391087034368" >}}

Now [distroless](https://github.com/GoogleContainerTools/distroless) is said to be 50% smaller than Alpine, since it doesn't have a shell, [though distroless has](https://blog.baeke.info/2021/03/28/distroless-or-scratch-for-go-apps/):

* CA certs: no need to copy them from stage 1
* /etc/passwd: contains users and groups such as nonroot
* /tmp
* tzdata: in case you want to set the timezone other than UTC

https://github.com/GoogleContainerTools/distroless/blob/main/examples/go/Dockerfile

https://gist.github.com/MatthewJamesBoyle/598538dd1c8d38f9dc70575b1be5958a

Then often you need [curl to run health checks](https://github.com/thoughtworks/maeve-csms/blob/main/manager/Dockerfile).
