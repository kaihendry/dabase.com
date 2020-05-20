<a href="http://www.flickr.com/photos/hendry/5456901310/" title="Sdcard by Kai Hendry, on Flickr"><img src="http://farm6.static.flickr.com/5251/5456901310_a74bcb7e52.jpg" width="500" height="375" alt="Sdcard" /></a>

The "side loading" use case on Androids is a bit difficult to say the least.

LG Optimus with an sdcard mounted:

	/dev/block/vold/179:17 /mnt/sdcard vfat rw,dirsync,nosuid,nodev,noexec,relatime,uid=1000,gid=1015,fmask=0702,dmask=0702,allow_utime=0020,codepage=cp437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro 0 0
	tmpfs /mnt/sdcard/.android_secure tmpfs ro,relatime,size=0k,mode=000 0 0

With it unmounted or removed `/mnt/sdcard` or `/sdcard` exist, but obviously
not mounted. This can actually be a problem as some apps assume /sdcard are
mounted and there to write on. Doh.

On a Galaxy S, where there is an empty sdcard slot we can see:

	/dev/block/vold/179:1 /mnt/sdcard vfat rw,dirsync,nosuid,nodev,noexec,noatime,nodiratime,uid=1000,gid=1015,fmask=0002,dmask=0002,allow_utime=0020,codepage=cp437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro 0 0

With an sdcard inserted and mounted:

	/dev/block/vold/179:1 /mnt/sdcard vfat rw,dirsync,nosuid,nodev,noexec,noatime,nodiratime,uid=1000,gid=1015,fmask=0002,dmask=0002,allow_utime=0020,codepage=cp437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro 0 0
	/dev/block/vold/179:9 /mnt/sdcard/external_sd vfat rw,dirsync,nosuid,nodev,noexec,noatime,nodiratime,uid=1000,gid=1015,fmask=0002,dmask=0002,allow_utime=0020,codepage=cp437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro 0 0
	tmpfs /mnt/sdcard/external_sd/.android_secure tmpfs ro,relatime,size=0k,mode=000 0 0

Notice the weird **external_sd** bit. The Galaxy S mounts the physical sdcard
on `/mnt/sdcard/external_sd/` which is a bit daft unless they are trying to
work around a problem.

The [Nexus S from Samsung doesn't have an
sdcard](http://www.google.co.uk/search?sourceid=chrome&ie=UTF-8&q=sdcard+nexus+s),
yet it still is mounted there:

	/dev/block/vold/179:3 /mnt/sdcard vfat rw,dirsync,nosuid,nodev,noexec,relatime,uid=1000,gid=1015,fmask=0702,dmask=0702,allow_utime=0020,codepage=cp437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro 0 0
	tmpfs /mnt/sdcard/.android_secure tmpfs ro,relatime,size=0k,mode=000 0 0

In the menus, it's called "USB storage".


To conclude we can learn here that the physical sdcard has been deprecated
really.  I noticed a WRT that refused to install widgets from anywhere except
`/sdcard/`, so when you didn't have a physical sdcard installed, you're kinda
screwed. So now I guess Android has **deprecated the sdcard**, but
unfortunately has kept the moint point name for historical reasons.

Without the physical sdcard, I must say it gets really hard to "side load".
For example I have **never** managed to "side load" with other non-internet
technologies like **bluetooth**, which is a bit depressing. USB I gather won't
work because of the master slave model, though I don't have a physical USB male
to male to try.
