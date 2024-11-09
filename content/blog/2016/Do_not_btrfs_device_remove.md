---
date: 2016-06-08 13:42:05 +0800
---

Do NOT `btrfs device delete` which is the synonymous with `btrfs device remove`
when removing a disk from a [btrfs](https://en.wikipedia.org/wiki/Btrfs) RAID
array.

# Why?

**Deleting the device from the array removes the data from it (as 
mentioned above), and wipes all BTRFS specific signatures as well.**

The device {remove, delete} command is for shrinking arrays, removing failing
disks, or for re-purposing individual drives.

Here's the [start of my
thread](http://www.spinics.net/lists/linux-btrfs/msg55937.html) on
[linux-btrfs](http://vger.kernel.org/vger-lists.html#linux-btrfs), which has
all the details.

# So how do I split an RAID1 array?

Well, the experts agree that this shouldn't be done. If you want to take out a
mirrored copy, instead `btrfs send` a snapshot to create another copy
somewhere.

However if you _really_ want to do this, you would have physically remove the
disk once unmounted. Then it should be mounted next time in a degraded state.
And add a new drive and **need to be certain to run a balance with
-dconvert=raid1 -mconvert=raid1 to clean up anything that got allocated before
the new disk was added.**

Ideally, it shouldn't be needed at all, it's just needed due to a deficiency in
the high-level allocator in BTRFS.
