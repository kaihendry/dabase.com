---
date: 2016-02-11 18:00:19 +0800
---

Companion [video on the issues I have with Docker](https://www.youtube.com/watch?v=tQZfCOpXJmE)

In an attempt to improve my previous [[Docker_container_update_workflow]], I
want to write my notes on how I develop Dockerfiles et al.

First I find the source repository of the Docker image I'm interested in.

For example https://hub.docker.com/r/abiosoft/caddy/ &rarr; https://github.com/abiosoft/caddy-docker

I then fork that into my repo and clone it, into for example ~/tmp/caddy-docker.

Typically I would make changes to the Dockerfile. Then:

1. Run a build `docker build -t WIP .`
* Run it `docker run -d --name caddy -p 2015:2015 -t WIP`
* See it running with `docker ps`
* Run a shell like so: `docker exec -i -t caddy sh`
* Stop it like so `docker kill caddy`
* To start it again `docker start caddy`
* Remove it like so `docker rm caddy`


Hopefully I then have a Dockerfile I like.

I then `docker login` and push my image to the Docker hub and perhaps test on
a production CoreOS machine.

When satisfied I commit the changes to my git repo and create a PR.

# Unsolved issues of my workflow

I would like to `git diff` changes in the running Docker filesystem.

I would like to examine files in the Docker images without shelling in.
