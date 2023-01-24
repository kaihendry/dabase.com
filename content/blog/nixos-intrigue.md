---
title: NixOS Intrigue
date: 2023-01-24T12:19:30+08:00
description: Day 3 of playing with NixOS
toc: true
---

Continuing from [First NixOS](/blog/2023/first-nixos/) and again many thanks to [Matthew Croughan](https://twitter.com/MatthewCroughan) and to anyone who tunes into my live impromptu NixOS streams upon https://www.youtube.com/@kaihendry/streams

# Questions

- [ ] How do know if your config has drifted? `nixos-rebuild test` is slow when.. nothing has changed! (at least five seconds)
- [ ] How is data managed? Is it comparable to Docker volumes?
- [ ] Test roll back