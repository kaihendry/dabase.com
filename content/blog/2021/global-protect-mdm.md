---
title: Global Protect Man in the Middle
date: 2021-09-30T09:50:22+08:00
description: How mobile device management can work from a VPN client
---

I have `aur/globalprotect-openconnect` installed to access my employer's VPN.

However it's not clear that the MacOS version installs [Microsoft
Intune](https://docs.microsoft.com/en-us/mem/intune/fundamentals/what-is-intune),
which basically is able to do **anything on your system**.

Now you know that a **<abbr title="Virtual Private Network">VPN</abbr> is a
gateway** to <a href="https://en.wikipedia.org/wiki/Mobile_device_management"><abbr title="Mobile device management">MDM</abbr></a> aka remote administration, aka your computing environment effectively in the control of a third party.

Another two avenues of giving up control, is to install of "Anti-Virus
software" and an Enterprise **requiring you install a root certificate
authority** for <a href="https://youtu.be/GqZ7yPzWTaQ">"fixing internal
SSL"</a>. Unfortunately the way SSL currently works is that any root
certificate can facilitate <a
href="https://en.wikipedia.org/wiki/Man-in-the-middle_attack"><abbr title="Man
in the Middle">MitM</abbr> attack</a>.

Sidenote: DNSSEC probably won't fix this issue as now you would have to trust
DNS responses. What is needed is some system cross referencing with
[Certificate
Transparency](https://en.wikipedia.org/wiki/Certificate_Transparency) services
to catch nefariously issued certificates and then black list that Certificate
Authority!

Currently it's rather painful to [track nefarious third party <abbr title="Certificate Authority">CA</abbr>s once they are in your trusted store](https://www.reddit.com/r/MacOS/comments/pk79ak/how_do_i_know_if_an_additional_ca_was_added_to_my/).

{{< youtube XI72ZAFv7os  >}}
