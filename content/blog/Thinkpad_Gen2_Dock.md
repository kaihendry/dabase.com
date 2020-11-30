---
title: Lenovo ThinkPad USB-C Dock Gen2 errors
date: 2020-11-02T09:45:35+08:00
description: ThinkPad USB-C Dock Gen 2 goes into a reboot loop
---

The [Generation 2 dock which I made a video
about](https://youtu.be/rFZ4QOLZG10) **Part number:  40AS0090UK** seems to
restart in recent kernels like 5.9.2-arch1-1


# ACPI error

	ACPI Error: No handler for Region [ECSI] (0000000067e9b69a) [EmbeddedControl] (20200717/evregion-127)
	ACPI Error: Region EmbeddedControl (ID=3) has no handler (20200717/exfldio-261)
	ACPI Error: Aborting method \_SB.UBTC.ECRD due to previous error (AE_NOT_EXIST) (20200717/psparse-529)
	ACPI Error: Aborting method \_SB.UBTC.NTFY due to previous error (AE_NOT_EXIST) (20200717/psparse-529)
	ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0._Q4F due to previous error (AE_NOT_EXIST) (20200717/psparse-529)
	ACPI Error: No handler for Region [ECSI] (0000000067e9b69a) [EmbeddedControl] (20200717/evregion-127)
	ACPI Error: Region EmbeddedControl (ID=3) has no handler (20200717/exfldio-261)
	ACPI Error: Aborting method \_SB.UBTC.ECRD due to previous error (AE_NOT_EXIST) (20200717/psparse-529)
	ACPI Error: Aborting method \_SB.UBTC.NTFY due to previous error (AE_NOT_EXIST) (20200717/psparse-529)
	ACPI Error: Aborting method \_SB.PCI0.LPC0.EC0._Q4F due to previous error (AE_NOT_EXIST) (20200717/psparse-529)


Full logs https://s.natalian.org/2020-11-02/dock-restarting.txt

# Any ideas how to fix?

Could be fixed in a firmware update! https://github.com/fwupd/fwupd/issues/2540

Please [contact me](https://hendry.iki.fi/)!
