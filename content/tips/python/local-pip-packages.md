---
date: 2021-08-02
title: Local python packages breakage
---

You can get into extraordinary twists when you mix local Python packages when system ones.

	got an unexpected keyword argument 'use_ssh_client'

Solution is not to use local packages for me:

	rm -rf ./.local/lib/python3.9
