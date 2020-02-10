When resetting an OpenWRT router into failsafe mode, it usually comes up as
192.168.1.1 with no DHCPD. So you need to manually set your machine 192.168.1.1
and telnet to it.

This is non-trivial in Linux. For example my wired network interface's name is
`enp0s20u2`:

	ip addr add 192.168.1.2/24 broadcast 192.168.1.255 dev enp0s20u2
	route add default gw 192.168.1.1 dev enp0s20u2

You need the route to make sure you direct traffic to `192.168.1.1`.
