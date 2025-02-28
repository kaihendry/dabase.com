---
title: "Gitlab Enterprise"
date: 2025-02-19T11:23:55Z
description: Tested on GitLab Enterprise Edition 17.9.0-pre

---

When you use Gitlab Enterprise, your access control should be around CI_JOB_TOKEN, not Personal Access Tokens!

# Docker

## Building & Publishing Docker Images to Repo's container_registry

```yaml
publish-container:
  image: docker:27.3
  services:
    - docker:27.3-dind
  script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    - docker build -t $CI_REGISTRY_IMAGE .
    - docker push $CI_REGISTRY_IMAGE
```
## Retrieving Docker Images from Repo's container_registry

```yaml
image: registry.gitlab.com/$enterprise/$team/$repo:latest
```

You will see a:

```
ERROR: Job failed: failed to pull image "$enterprise/$team/$repo:latest" with specified policies [if-not-present]: Error response from daemon: pull access denied for $enterprise/$team/$repo, repository does not exist or may require 'docker login': denied: requested access to the resource is denied (manager.go:251:0s)
```
If you do not use **registry.gitlab.com**!

# Go binary

.goreleaser.yml:
``` yaml
version: 2

builds:
  - env:
      - CGO_ENABLED=0
    goos:
      - linux

gitlab_urls:
  use_package_registry: true
  use_job_token: true
```

With the job:
```yaml
release:
  stage: deploy
  only:
    refs:
      - tags
  image:
    name: goreleaser/goreleaser
    entrypoint: [""]
  variables:
    GIT_DEPTH: 0
    GITLAB_TOKEN: $CI_JOB_TOKEN
  script:
    - goreleaser release
```

# ERROR: Job failed: failed to pull image

> Error response from daemon: pull access denied for registry.gitlab.com/...repository does not exist or may require 'docker login': denied: requested access to the resource is denied (manager.go:251:0s)

<img src="https://s.natalian.org/2025-02-25/gitlab-job-token.png" alt="CICD Job tokens">

To retrieve artifacts one repo to another you need to explicitly allow the repo to pull artifacts from the `/settings/ci_cd#js-token-access`.