# Rsync

Pros:

* Can be resumed
* Progress indicator (kindof)
* Runs across ANY filesystem
* Easy to debug
* Tried & tested !

Cons:

* rsync-ing a running system is like booting a system after a power cut
* Rsyncing to a crappy filesystem might lose metadata
* You can't realistically roll back without fs dependant hacks like hardlinks

# Btrfs

A new entrant! Is it actually ... BETTER than rsync?

Pros:

* A snapshot (to be backed up) can be made instantly on boot or on poweroff, when the files aren't open
* Works nicely with [systemd-nspawn](http://www.freedesktop.org/software/systemd/man/systemd-nspawn.html) so you can safely test mirrors of your filesystem
* Easier to roll back
* Can store more efficiently

Cons:

* You need to setup the snapshotting regime
* Complex, probably buggy and fallible (potentially dangerous)
* btrfs send cannot be resumed, so if you sending a backup somewhere remote and it's interrupted... start again!
