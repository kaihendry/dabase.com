<img src=http://s.natalian.org/2016-05-19/Data-Wipe-Failed.jpg alt="Data Wipe Failed">

My friend came to me with his **Xiaomi Mi Note** that he was planning to sell,
but was unable to reset through the menus. I managed to reset it with `fastboot
-w` whilst holding I think 'Volume down' and the 'Power button' from a cold
boot.

Using `android-sdk-platform-tools /opt/android-sdk/platform-tools/fastboot` on
Archlinux. Here's the log:

	~$ fastboot -w
	< waiting for any device >
	Creating filesystem with parameters:
		Size: 60121133056
		Block size: 4096
		Blocks per group: 32768
		Inodes per group: 8192
		Inode size: 256
		Journal blocks: 32768
		Label:
		Blocks: 14678011
		Block groups: 448
		Reserved block group size: 1024
	Created filesystem with 11/3670016 inodes and 276420/14678011 blocks
	target reported max download size of 1610612736 bytes
	Creating filesystem with parameters:
		Size: 402653184
		Block size: 4096
		Blocks per group: 32768
		Inodes per group: 8192
		Inode size: 256
		Journal blocks: 1536
		Label:
		Blocks: 98304
		Block groups: 3
		Reserved block group size: 23
	Created filesystem with 11/24576 inodes and 3131/98304 blocks
	erasing 'userdata'...
	OKAY [ 24.552s]
	sending 'userdata' (141083 KB)...
	OKAY [  4.419s]
	writing 'userdata'...
	OKAY [  2.585s]
	erasing 'cache'...
	OKAY [  0.040s]
	sending 'cache' (8336 KB)...
	OKAY [  0.263s]
	writing 'cache'...
	OKAY [  0.139s]
	finished. total time: 31.999s
	~$ fastboot continue
	resuming boot...
	OKAY [  0.000s]
	finished. total time: 0.000s
	~$
