So I bought a "SanDisk SDSSDHP-128G-G25 128GB Ultra Plus SATA 3.0 6GB/s 7mm
Internal SSD" aka "sandisk" to complement my existing "OCZ 120GB Nocti SSD -
mSATA SATA-II - Read 280MB/s Write 260MB/s" aka "nocti" disk connected to my
Mini-SATA port.

I primarily thought I would **experiment with cloning** nocti to the sandisk, so
that if nocti failed I could use sandisk. Or I could see performance
differences running the same system. Or I could do fun things like upgrade one,
but not the other and see if I could measure or debug something.

# Straight up dd

Note: In hindsight you are almost always better off `mkfs.ext4` and `rsync -a` files over instead off `dd`!

I first tried, whilst running and mounted on /dev/sdb (nocti):

	dd if=/dev/sdb | pv | dd of=/dev/sda

`pv` supposed to "monitor the progress of data through a pipe", however it
didn't give me a proper progress bar. It only told me that I was copying at a
rate of about 10MB/sec, which I found a bit disappointing.

	# parted --list | grep .
	Model: ATA SanDisk SDSSDH21 (scsi)
	Disk /dev/sda: 128GB
	Sector size (logical/physical): 512B/512B
	Partition Table: msdos
	Disk Flags:
	Number  Start   End    Size   Type     File system  Flags
	 1      32.3kB  120GB  120GB  primary  ext4         boot
	Model: ATA OCZ-NOCTI (scsi)
	Disk /dev/sdb: 120GB
	Sector size (logical/physical): 512B/512B
	Partition Table: msdos
	Disk Flags:
	Number  Start   End    Size   Type     File system  Flags
	 1      32.3kB  120GB  120GB  primary  ext4         boot

First problem is that I'm wasting 8GB. Second problem is that I'm dd-ing from a running system. Lets try boot into sandisk!

Uh oh, [lots of errors](http://www.flickr.com/photos/hendry/sets/72157636140014884/). `dd` simply didn't work, even after running a `fsck` upon it. Also scarily, the "sandisk" was referring to itself as "nocti" when I was using it. That's because when I dd-ed it, the label came across:

	x220:~$ sudo e2label /dev/sda1
	nocti
	x220:~$ sudo e2label /dev/sdb1
	nocti

Sadly one can't do a top level label, you have to do it on a partition:

	sudo e2label /dev/sda sandisk
	e2label: Bad magic number in super-block while trying to open /dev/sdb
	Couldn't find valid filesystem superblock.

# Lets try a dd from a live USB like Webconverger

<img src="http://s.natalian.org/2013-10-03/dd-from-webc.png">

In 20 minutes I successfully managed to clone "nocti" to "sandisk" using 4M as
the block size. I ran `e2label /dev/sda1 sandisk` and now we have:

	$ lsblk -f
	NAME   FSTYPE LABEL   UUID                                 MOUNTPOINT
	sda
	└─sda1 ext4   sandisk 5d40f591-086f-407a-9b6c-fb3fec1dc046 /
	sdb
	└─sdb1 ext4   nocti   5d40f591-086f-407a-9b6c-fb3fec1dc046

Notice they have the exact same UUID.

# hdparm to compare disk speed

So the sandisk shows:

	# hdparm -tT /dev/sda
	/dev/sda:
	 Timing cached reads:   6672 MB in  2.00 seconds = 3336.70 MB/sec
	 Timing buffered disk reads: 1466 MB in  3.00 seconds = 488.37 MB/sec

And nocti is:

	[root@x220 ~]# hdparm -tT /dev/sdb
	/dev/sdb:
	 Timing cached reads:   10298 MB in  2.00 seconds = 5152.28 MB/sec
	 Timing buffered disk reads: 338 MB in  3.01 seconds = 112.21 MB/sec

I added "noatime,discard" to my mount options and sda seems faster or hdparm is just variable?

	[root@x220 ~]# hdparm -tT /dev/sda
	/dev/sda:
	 Timing cached reads:   10688 MB in  2.00 seconds = 5347.33 MB/sec
	 Timing buffered disk reads: 1368 MB in  3.00 seconds = 455.69 MB/sec
	[root@x220 ~]# hdparm -tT /dev/sdb
	/dev/sdb:
	 Timing cached reads:   10156 MB in  2.00 seconds = 5081.24 MB/sec
	 Timing buffered disk reads: 338 MB in  3.01 seconds = 112.13 MB/sec


# Next, expanding the sandisk to take all the space by recreating the partition (BAD IDEA)

Parted seems unable to detect the dimensions of the disk for partition creation, hence I used `fdisk`.

	# fdisk /dev/sda
	Welcome to fdisk (util-linux 2.23.2).

	Command (m for help): n
	Partition type:
	   p   primary (0 primary, 0 extended, 4 free)
	   e   extended
	Select (default p): p
	Partition number (1-4, default 1):
	First sector (2048-250069679, default 2048):
	Using default value 2048
	Last sector, +sectors or +size{K,M,G} (2048-250069679, default 250069679):
	Using default value 250069679
	Partition 1 of type Linux and of size 119.2 GiB is set

	Command (m for help): p

	Disk /dev/sda: 128.0 GB, 128035676160 bytes, 250069680 sectors
	Units = sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disk label type: dos
	Disk identifier: 0xba6fb7fd

	   Device Boot      Start         End      Blocks   Id  System
	/dev/sda1            2048   250069679   125033816   83  Linux

	Command (m for help): w
	The partition table has been altered!

	Calling ioctl() to re-read partition table.
	Syncing disks.
	# resize2fs /dev/sda1
	resize2fs 1.42.8 (20-Jun-2013)
	resize2fs: Bad magic number in super-block while trying to open /dev/sda1
	Couldn't find valid filesystem superblock.

I think the problem is that fdisk seems to think the start is at **default
2048**, when looking back to original `parted` output after the dd, it's in fact
**32.3kB**. I do not know how to specify **32.3kB** as the start for fdisk.

WARNING: <http://askubuntu.com/a/115337/676> is bad advice, since `fdisk` will forcibly start at 2048 (default since fdisk 2.17.2), and will not allow to start at a lower sector!

# SATA speeds

On my X220 system, I have a number of SATA ports:

	# ls /sys/class/ata_port/
	ata1  ata2  ata3  ata4  ata5  ata6

To determine the speed:

	# dmesg | grep -i sata | grep 'link up'
	ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
	ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
	ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

IIUC, [sandisk](http://ix.io/8mQ) is on ata1:

	# journalctl -b | grep -i sandisk | grep ata
	Oct 07 15:26:41 x220 kernel: ata1.00: ATA-8: SanDisk SDSSDH2128G, X211200, max UDMA/133

And [nocti](http://ix.io/8mR) is on ata3:

	# journalctl -b | grep -i nocti | grep at
	Oct 07 15:26:41 x220 kernel: ata3.00: ATA-8: OCZ-NOCTI, 2.15, max UDMA/133

# Finally, the right way to clone a disk

The best approach I've found is to boot Archlinux install disk. Assuming your
destination is sandisk at /dev/sda and source is nocti at /dev/sdb.

	lsblk -f
	fdisk /dev/sda
	n, p, enter, enter # Create partition
	mkfs.ext4 /dev/sda1
	e2label /dev/sda1 sandisk
	mkdir /mnt/{nocti,sandisk}
	mount /dev/sdb1 /mnt/nocti
	mount /dev/sda1 /mnt/sandisk -o noatime,rw,discard
	rsync -a /dev/nocti/ /mnt/sandisk
	vim /mnt/sandisk/etc/fstab # update LABEL=sandisk
	vim /mnt/sandisk/boot/syslinux/syslinux.cfg # update root=LABEL=sandisk
	syslinux-install_update.sh -i -a -m -c /mnt/sandisk
