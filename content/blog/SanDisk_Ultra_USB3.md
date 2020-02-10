---
date: 2015-08-31 16:12:24 +0800
---

SanDisk Ultra USB3 speed from my Broadwell laptop is:

	$ sudo dd if=live-image-i386.hybrid.iso of=/dev/sdb status=progress
	420512256 bytes (421 MB) copied, 23.002299 s, 18.3 MB/s
	823296+0 records in
	823296+0 records out
	421527552 bytes (422 MB) copied, 47.5528 s, 8.9 MB/s


Seems a bit crap, no?

# bs=1M

Adjusting the block size does make it go faster, but it's still a LOT LESS than what USB3 is capable of.

	$ sudo dd if=live-image-i386.hybrid.iso of=/dev/sdb bs=1M status=progress
	402+0 records in
	402+0 records out
	421527552 bytes (422 MB) copied, 22.2003 s, 19.0 MB/s

