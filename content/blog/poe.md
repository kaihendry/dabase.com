---
title: Passive versus Active Power over Ethernet
date: 2020-10-07T10:22:38+08:00
description: Passive != Active Power over Ethernet
---


My [hAP ac2](https://mikrotik.com/product/hap_ac2) aka **RBD52G-5HacD2HnD-TC** has an ability to power it through Ethernet:

<table>
<thead>
<tr>
<th colspan="2">Details</th>
</tr>
</thead>
<tbody>

<tr>
<td>PoE in</td>
<td>Passive PoE   </td>
</tr>

<tr>
<td>PoE in input Voltage</td>
<td>18-28 V   </td>
</tr>

<tr>
<td>Number of DC inputs</td>
<td>2  (DC jack, PoE-IN) </td>
</tr>

<tr>
<td>DC jack input Voltage</td>
<td>12-30 V   </td>
</tr>

<tr>
<td>Max power consumption</td>
<td>21 W   </td>
</tr>

<tr>
<td>Max power consumption without attachments</td>
<td>16 W   </td>
</tr>

<tr>
<td>FAN count</td>
<td>Passive   </td>
</tr>
</tbody>
</table>


Now if if I connect it to my [UniFi Switch 8 POE-60W](https://www.ui.com/unifi-switching/unifi-switch-8/) aka US-8-60W, it's unable to power the device. **Why?**


# Passive != Active <abbr title="Power over Ethernet">PoE</abbr>

The **US-8-60W** only supports **802.3af which is Active POE and 48V**.

# Solutions

## Use a passive PoE injector

<a href="https://mikrotik.com/product/RBGPOE">
<img src="https://s.natalian.org/2020-10-12/RBGPOE.webp" alt="RBGPOE PoE injector">
</a>

## Use another switch that can do Passive as well as Active

For example the
[US-8-150W](https://www.ui.com/unifi-switching/unifi-switch-8-150w/) can do
**Passive** <abbr title="Power over Ethernet">PoE</abbr> as well as **Active**.

However do note the US-8-150W is 200USD versus the US-8-60W at ~109USD. Almost twice the price to get a switch that support both forms of <abbr title="Power over Ethernet">PoE</abbr>!!

Credit to [brwainer on Reddit](https://www.reddit.com/r/mikrotik/comments/gfu3b2/powering_a_hap_ac2_from_a_unifi_switch_8_poe60w/fpvn23f/).


