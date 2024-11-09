---
date: 2014-02-10 16:53:02 +0800
---

So I exchanged [my WD Passport Ultra with a poorly fitting USB
cable](http://youtu.be/StSIib6RmCw) for a Seagate Backup Plus (Slim) portable drive
which was roughly the same price at Sim Lim at Cybermind Computer on the 4th floor.

I wanted the Western Digital after reading
<http://blog.backblaze.com/2014/01/21/what-hard-drive-should-i-buy/> linked on
<https://news.ycombinator.com/>... oh well. The Seagate's cable fits nicely on
my X220 or my wife's MBP. Let's hope the Seagate's [3 year
warranty](http://s.natalian.org/2014-02-10/1392019102_1364x766.png) works out
too.

<iframe src="http://www.flickr.com/photos/hendry/12430622464/player/" width="500" height="375" frameborder="0" allowfullscreen webkitallowfullscreen mozallowfullscreen oallowfullscreen msallowfullscreen></iframe>

On my [aging X220](http://natalian.org/archives/2013/12/23/Thinkpad_X240/) I do
have one USB3 port. So I thought it would be prudent to measure USB3 against
USB2.

Here is my test script:

	# cat testusbseagate.sh
	set -e # something goes wrong, then exit!
	mp=/mnt/sd
	test -e $mp || exit
	lsusb -v | grep -A 5 Seagate # show we are using USB 2 or 3
	mount /dev/sdc1 $mp
	mount | grep $mp
	cd $mp
	#dd if=/dev/zero of=tempfile bs=1M count=1024 conv=fdatasync,notrunc
	dd if=tempfile of=/dev/null bs=1M count=1024
	echo 3 > /proc/sys/vm/drop_caches
	dd if=tempfile of=/dev/null bs=1M count=1024
	#rm tempfile
	cd /
	umount $mp

I wrote the tempfile beforehand on this disk. Measuring the write of the file
seemed to give to many false readings, so I went for measuring the read of the
file, after a fresh mount.

USB2 gave:

	# bash testusbseagate.sh
	Bus 001 Device 011: ID 0bc2:ab20 Seagate RSS LLC
	Device Descriptor:
	  bLength                18
	  bDescriptorType         1
	  bcdUSB               2.10

bcdUSB 2.10 indicates USB2.

	  bDeviceClass            0 (Defined at Interface level)
	--
	  idVendor           0x0bc2 Seagate RSS LLC
	  idProduct          0xab20
	  bcdDevice            1.00
	  iManufacturer           2 Seagate
	  iProduct                3 Backup+  BK
	  iSerial                 1 NA7573AM
	  bNumConfigurations      1
	  Configuration Descriptor:
		bLength                 9
	FUSE exfat 1.0.1
	/dev/sdc1 on /mnt/sd type fuseblk (rw,nosuid,nodev,relatime,user_id=0,group_id=0,allow_other,blksize=4096)
	1024+0 records in
	1024+0 records out
	1073741824 bytes (1.1 GB) copied, 37.6769 s, 28.5 MB/s
	1024+0 records in
	1024+0 records out
	1073741824 bytes (1.1 GB) copied, 37.6217 s, 28.5 MB/s

So **28.5 MB/s** read for USB2. Let's test my only USB3 port on my X220:

	# bash testusbseagate.sh
	Bus 003 Device 007: ID 0bc2:ab20 Seagate RSS LLC
	Device Descriptor:
	  bLength                18
	  bDescriptorType         1
	  bcdUSB               3.00

bcdUSB 3.00 indicates USB3.

	  bDeviceClass            0 (Defined at Interface level)
	--
	  idVendor           0x0bc2 Seagate RSS LLC
	  idProduct          0xab20
	  bcdDevice            1.00
	  iManufacturer           2 Seagate
	  iProduct                3 Backup+  BK
	  iSerial                 1 NA7573AM
	  bNumConfigurations      1
	  Configuration Descriptor:
		bLength                 9
	FUSE exfat 1.0.1
	/dev/sdc1 on /mnt/sd type fuseblk (rw,nosuid,nodev,relatime,user_id=0,group_id=0,allow_other,blksize=4096)
	1024+0 records in
	1024+0 records out
	1073741824 bytes (1.1 GB) copied, 9.38842 s, 114 MB/s
	1024+0 records in
	1024+0 records out
	1073741824 bytes (1.1 GB) copied, 9.27814 s, 116 MB/s

So USB3 seems 3x the speed of USB2 on this read test. Nice.

I ran Xbench on my wife's MBP on the Seagate and it produced:

	Results	34.89	
		System Info		
			Xbench Version		1.3
			System Version		10.9.1 (13B3116)
			Physical RAM		8192 MB
			Model		MacBookPro11,1
			Drive Type		Seagate Backup+ BK
		Disk Test	34.89	
			Sequential	146.62	
				Uncached Write	95.17	58.44 MB/sec [4K blocks]
				Uncached Write	186.69	105.63 MB/sec [256K blocks]
				Uncached Read	149.12	43.64 MB/sec [4K blocks]
				Uncached Read	212.26	106.68 MB/sec [256K blocks]
			Random	19.80	
				Uncached Write	6.05	0.64 MB/sec [4K blocks]
				Uncached Write	66.35	21.24 MB/sec [256K blocks]
				Uncached Read	70.32	0.50 MB/sec [4K blocks]
				Uncached Read	133.45	24.76 MB/sec [256K blocks]

I don't have a USB2 drive to compare it with.

I wonder if **Gigabit ethernet** between two Archlinux machines with SSD would beat
USB3? USB3's **114 MB/s** is about 900Mbps...
