---
date: 2021-07-06
title: Adding a trusted certificate
description: How to add your employer's CA to the trusted list of certificate authorities
---

These examples are the system wide commands to trust `enterprise-ca.pem`.

# Archlinux

	sudo trust anchor --store enterprise-ca.pem


# MacOS

	sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" enterprise-ca.pem

