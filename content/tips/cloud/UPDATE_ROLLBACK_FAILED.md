---
title: UPDATE_ROLLBACK_FAILED
date: 2021-10-18
description: Stuck with UPDATE_ROLLBACK_FAILED
---

Cloudformation is trying to roll back but cannot do as some underlying resource is missing. E.g. a layer is removed.


<img src="https://s.natalian.org/2021-10-18/actions.png" alt="AWS Stack Actions screenshot">

Retry the rollback and even give you an option to skip the resource that
won't roll back in Advanced.

Once you resolve that, then you can re-deploy.
