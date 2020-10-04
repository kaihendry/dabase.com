---
title: Account Security
date: 2020-10-04T23:17:07+08:00
description: How I secure my online life
---
<table>
<thead>
<tr>
<th>Security feature</th>
<th>IOS</th>
<th>Archlinux Laptop</th>
<th>Web</th>
</tr>
</thead>
<tbody>
<tr>
<td>Something you know</td>
<td>Apple password<sup>1</sup></td>
<td>LUKS cryptsetup password<sup>4</sup></td>
<td>Use Firefox/Google accounts with 2FA</td>
</tr>
<tr>
<td>Something you have</td>
<td>Apple device<sup>2</sup></td>
<td>Physical thinkpad<sup>4</sup></td>
<td>2FA by Authy<sup>5</sup></td>
</tr>
<tr>
<td>Something you are</td>
<td>Apple device's face recognition<sup>3</sup></td>
<td>Do not trust the fingerprint reader</td>
<td>Nothing biometric</td>
</tr>
</tbody>
</table>

<sup>1</sup> [Apple can read your backups](https://www.youtube.com/watch?v=OwbFlUldZ0U)

<sup>2</sup> You can just replace your device by restoring your backup, so moot

<sup>3</sup> Bypassed trivially with the 6 digit PIN password

<sup>4</sup> If lost (forgotten), I basically lose my private data. No chance of recovery. Private data includes my accounts file and various recovery codes.

<sup>5</sup> Authy IIUC can be completely recovered by knowing my Authy **password**. I could enable Face ID protection, but again IIUC it could be trivially bypassed with PIN. I think the keys are stored in my Apple account, tbh I am not sure.
