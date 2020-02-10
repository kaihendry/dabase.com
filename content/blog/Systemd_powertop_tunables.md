---
date: 2013-01-31 13:35:55 +0800
---

Putting Powertop tunables in a systemd format will probably be [blogged by
Lennart](http://lists.freedesktop.org/archives/systemd-devel/2012-November/007445.html),
though here goes. Prompted by the legendary [Power regressions
thread](https://bbs.archlinux.org/viewtopic.php?pid=1220617#p1220617).

Using PowerTOP version v2.7:

	sudo powertop -r powertop.html

You should get a report like <http://s.natalian.org/2015-07-08/powertop.html>

Use the `td:first-child { display: none; }` trick to be able to copy and paste the second column.

You will get something like:

	iw dev wlan0 set power_save off
	echo 'min_power' > '/sys/class/scsi_host/host0/link_power_management_policy';
	echo '0' > '/proc/sys/kernel/nmi_watchdog';
	echo '1500' > '/proc/sys/vm/dirty_writeback_centisecs';
	echo '1' > '/sys/module/snd_hda_intel/parameters/power_save';
	echo 'auto' > '/sys/bus/usb/devices/3-1/power/control';
	echo 'auto' > '/sys/bus/pci/devices/0000:0e:00.0/power/control';
	ethtool -s net0 wol d;

Which I save into a tunables.txt, this is [mine for example](http://s.natalian.org/2015-07-08/tunables.txt).

Which you need to convert like so in systemd's `/etc/tmpfiles.d/power-savings.conf`:

	w /sys/class/scsi_host/host0/link_power_management_policy - - - - min_power
	w /proc/sys/kernel/nmi_watchdog - - - - 0
	w /proc/sys/vm/dirty_writeback_centisecs - - - - 1500
	w /sys/module/snd_hda_intel/parameters/power_save - - - - 1
	w /sys/bus/usb/devices/3-1/power/control - - - - auto
	w /sys/bus/pci/devices/0000:0e:00.0/power/control - - - - auto

I wrote a shell script to help me do it called <http://s.natalian.org/2015-07-08/rewrite.sh>:

	cleanup() {
		echo $1 | tr -d "';"
	}
	while read _ arg _ dev
	do
		echo w $(cleanup $dev) - - - - $(cleanup $arg)
	done < tunables.txt

Which I move into the right place like so:

	x220:~/tmp/powertop$ bash rewrite.sh > /tmp/power-savings.conf
	x220:~/tmp/powertop$ sudo mv /tmp/power-savings.conf /etc/tmpfiles.d/power-savings.conf

For `ethtool` and `iw` have a look at [Vodik's
/etc/rules.d/50-network-powersave.rules](https://github.com/vodik/powersave/blob/master/rules.d/50-network-powersave.rules).
