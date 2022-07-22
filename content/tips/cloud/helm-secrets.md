---
title: Helm secrets
date: 2022-07-22
description: Where are secrets set in values.yaml in Kubernetes?
---

Take a `values.yaml` file like:

```yaml
gitlabUrl: https://gitlab.example.com/
runnerRegistrationToken: "FOOBAR"
rbac:
  create: true
```

To reproduce my Kubernetes environment, setup minikube and then run:

1. helm repo add gitlab https://charts.gitlab.io
2. helm install gitlab-runner -f values.yaml gitlab/gitlab-runner

# Where is the secret FOOBAR?

	kubectl describe pods

Gives the clue...

To see the "secret" runnerRegistrationToken:


	$ kubectl get secret gitlab-runner -o go-template='{{range $k,$v := .data}}{{"### "}}{{$k}}{{"\n"}}{{$v|base64decode}}{{"\n\n"}}{{end}}'
	### runner-registration-token
	FOOBAR

