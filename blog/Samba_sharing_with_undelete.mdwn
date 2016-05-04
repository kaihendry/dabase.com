<iframe width="560" height="315" src="https://www.youtube.com/embed/GwhtoeMx1I8" frameborder="0" allowfullscreen></iframe>

# /etc/samba/smb.conf

	[global]
	   workgroup = 888
	   server string = nuc
	   security = user
	   syslog only = no
	   dns proxy = no
	   log level = 3
	   force directory mode = 0777
	   force create mode = 0777
	   guest ok = no
	   force user = root
	   force group = root
	   read only = no
	   valid users = rufie hendry
	   vfs object = recycle
	   recycle:repository = DELETED
	   recycle:keeptree = yes
	   recycle:directory_mode=777
	   veto files = /._*/.DS_Store/
	   delete veto files = yes

	[raid1]
	   comment = Raided store
	   path = /mnt/raid1

	[ext2tb]
	   comment = Nonresilent
	   path = /mnt/2tb

On [Arch's Samba](https://wiki.archlinux.org/index.php/Samba) I found that I
had to set the password on an existing user like so `smbpasswd -a rufie`. I
have no idea where the password is actually stored. I found this would no work
unless the existing user was in PAM. You will get a `Could not find user BLAH
and no add script defined` otherwise.

# client /etc/fstab

	//nuc.local/raid1 /mnt/raid1 cifs username=hendry,uid=1000,gid=100,noauto,nofail,user

# RAID1 configuration with USB drives

Btw I am actually RAID1 two external USB drives. It's **EXPERIMENTAL** at this
stage & I wouldn't recommend doing this.

* [btrfs fi show /dev/sdc1](http://s.natalian.org/2016-05-02/show.txt)
* [btrfs filesystem usage /mnt/raid1/](http://s.natalian.org/2016-05-02/usage.txt)

Btw I [asked the samba
list](https://lists.samba.org/archive/samba/2016-May/199652.html) for some
clarity regarding the PAM/passwd integration.
