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

# Things I'm struggling with

I've since delegated my [vimcrypt accounts
file](https://www.youtube.com/watch?v=WFcdan1UD-0) mostly to [Firefox
accounts](https://s.natalian.org/2020-10-04/1601824182_1920x1080.png), and over
time, my local passwords are becoming out of date, since they are being managed
by Firefox.

I struggle to maintain which accounts I have 2FA with. I struggle to keep track
of what App passwords are being used by my mobile for example and if they
should be rotated. RE 2FA I struggle to maintain the recovery codes.

I don't think I use biometric meaningfully anywhere. Face ID is just a
convenience functionality on Apple IOS to save typing in a password?

I think my setup is too complex for any trusted member of my family (or friend)
to recover my data with, in case of an accident.

As for my family's security practices. I think it's pretty bad and tbh I'm
struggling with my own issues, so I don't want to get too involved.

# Things I think I'm doing well with

I try not to use my Singapore number for anything, but some services esp like
banks in Singapore force me to use it.
