---
date: 2015-03-24 15:29:51 +0800
---

Using `sudo ifuse /mnt/iphone/` you can mount your Iphone6 as I do and archive
the contents of **DCIM** your hard drive. Make sure you have _Personal Hotspot_
enabled else it might not work.

	rsync -Part /mnt/iphone/DCIM ~/media/iphone6

<img src=http://s.natalian.org/2015-03-23/1427077158_854x530.png>

However you may find the Photos app has not detected the images have been moved, and it's not recreating the database.

The workaround is to:

	rm /mnt/iphone/PhotoData/Photos.sqlite

And then reboot the iPhone to fix it.

Here is a complete script I use to archive my photos: <http://s.natalian.org/2016-01-28/datemove.sh>


Oh btw, this is how I am currently using ffprobe to YYYY-MM-DD prefix by **creation time** my video backups:
<http://s.natalian.org/2016-01-29/moviemove.sh>
