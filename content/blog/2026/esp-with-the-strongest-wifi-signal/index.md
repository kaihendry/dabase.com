---
title: "ESP With the Strongest WiFi Signal"
description: "I compared WiFi RSSI across three ESP boards I had lying around: an ESP8266 with a PCB trace antenna, an ESP32-D0WDQ6 with a folded PCB antenna sticking up off the module, and an ESP32-D0WD-V3 with a flush trace antenna. The one with the antenna folded up off the module won by ~10-20dB."
date: 2026-09-07T16:59:54+01:00
---

I had three random ESP boards on my desk, so I plugged each into a laptop with `esptool` to
find out exactly what they were, and logged the WiFi RSSI each one reported to the same access
point.

<a href="fronts.avif"><img src="fronts.avif" alt="Three ESP boards side by side next to a ruler: left an ESP8266 with a PCB zigzag trace antenna, middle an ESP32 with its antenna folded up above the module, right an ESP32 with its antenna flush against the module" style="max-width:100%"></a>

<a href="backs.avif"><img src="backs.avif" alt="The same three ESP boards flipped over showing their pin headers and PCB backs, next to a ruler" style="max-width:100%"></a>

| Board (left to right) | Chip (via `esptool chip-id`) | Antenna | RSSI |
|---|---|---|---|
| HiLetgo NodeMCU | ESP8266EX | PCB trace | -80 to -9x dBm |
| ESP32 DevKitC V4 | ESP32-D0WDQ6 rev v1.0 | Inbuilt, folded up off the module | **-7x dBm** |
| Generic ESP32 board ([AliExpress](https://www.aliexpress.com/item/1005008723399881.html)) | ESP32-D0WD-V3 rev v3.1 | Inbuilt, flush with the module | -80 to -9x dBm |

The middle board — the ESP32-D0WDQ6 with its antenna folded up and away from the module rather
than lying flat against it — was consistently 10-20dB stronger than the other two. All three
boards have a non-detachable, built-in antenna; there's no U.FL connector or separate rod antenna
on any of them. The generic AliExpress board on the right, despite being the newer chip revision
(V3.1 vs V1.0), had its antenna trace flush with the module and was one of the weakest performers.
I won't be buying that one again.

Lesson: it's not about "built-in vs external" — all three boards had a fixed, inbuilt antenna.
What mattered was the antenna's layout and how well it was clear of the ground plane. Cheap
unbranded clone boards vary wildly here, so it's worth checking photos closely (or just measuring
RSSI yourself) rather than assuming any ESP32 board's antenna is as good as any other's.
