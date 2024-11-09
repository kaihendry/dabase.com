---
title: NixOS Intrigue
date: 2023-01-24T12:19:30+08:00
description: Day 3 of playing with NixOS
toc: true
---

Continuing from [First NixOS](/blog/2023/first-nixos/) and again many thanks to [Matthew Croughan](https://twitter.com/MatthewCroughan) and to anyone who tunes into my live impromptu NixOS streams upon https://www.youtube.com/@kaihendry/streams

# Questions

- [ ] How do know if your config has drifted? `nixos-rebuild test` is slow when.. nothing has changed! (at least five seconds)
- [ ] Test roll back
- [X] How is data managed? Is it comparable to Docker volumes?

## Different configurations = profiles?

    ls /nix/var/nix/profiles

I don't know how to tell which profile equates to my [configuration.nix](https://github.com/kaihendry/NixOS-smokeping/blob/main/configuration.nix)

# TODO profiles

    system.copySystemConfiguration

## Data is in /var

NixOS does use the FHS in this case.

I am not sure if I can expect NixOS to manage the variable (mutable state) directory at all.

## How to find configuration of a service

Not easy!

    systemctl cat smokeping | grep config
    ExecStart=/nix/store/mx8dxnbbgw7zhg4fr0fkd8d1bg985qfg-smokeping-2.8.2/bin/smokeping --config=/nix/store/j7njc6iiq1x13kd9i52dm46g856gzxkq-smokeping.conf --nodaemon

The configuration is:

    /nix/store/j7njc6iiq1x13kd9i52dm46g856gzxkq-smokeping.conf


## TODO secrets

https://github.com/Kranzes/nix-config/tree/master/secrets


