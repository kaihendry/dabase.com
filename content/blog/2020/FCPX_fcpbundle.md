---
title: Understanding FCPX bundles
date: 2020-11-05T22:43:38+08:00
description: Final Cut Pro X backups have gone wrong for me
---

<img width="30%" src="https://s.natalian.org/2020-11-05/fcpx.png">

	sanity.fcpbundle/
	├── 5-11-20
	│   ├── Original\ Media
	│   └── Render\ Files
	│       ├── Peaks\ Data
	│       │   ├── 13ACF6D20AE1862D8849D9FFBCA5167F
	│       │   └── 46D5B8EC3FF83A69FF564815F04692AC
	│       └── Thumbnail\ Media
	│           └── 8BD72B58ADE11B3D95E2CD6BAC5DD6EA
	├── Motion\ Templates.localized
	└── __Temp

	10 directories

When something has gone seriously weird:

	Charlie-5th-birthday.fcpbundle/
	├── .fcpcache
	│   └── 17-10-20
	│       ├── Original\ Media
	│       ├── Shared\ Items
	│       │   └── +O2MjDm3TaCq8AMoBpCVMg
	│       └── Untitled\ Project
	└── .lock-dir

	7 directories

Moving the y-m-d folder down a level fixed it `mv .fcpcache/17-10-20/ .`, but **why** did it happen in the first place?!

For the record, this is how I [backup my FCPX bundle libraries](https://github.com/kaihendry/media-organisation/blob/master/v2/2_sync-mysrctree.sh).

https://gist.github.com/kaihendry/7e52c334c02c7d20a75dd8919c811140
