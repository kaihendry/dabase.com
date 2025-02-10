---
title: Debugging methods
date: 2021-04-11T10:24:37+08:00
description: Why programmers reach for printf more frequently than debuggers
---

{{< x user="amasad" id="1380559800598077440" >}}

# printf

- [easier to show your changes](https://twitter.com/DNAutics/status/1380895991025442817)
- [can allow you to look back in time](https://twitter.com/rogpeppe/status/1381029406530011136)
- [fast and reliable](https://twitter.com/paulg/status/1380582811145547777)
- [available everywhere](https://twitter.com/devan2_0/status/1380596255093485568)
- [printfs don't disappear like breakpoints](https://twitter.com/rogpeppe/status/1381030729946177537)
- [proactive](https://twitter.com/Acemad_/status/1381000419221123077)
- [smallest complexity cost](https://twitter.com/gnomon/status/1380999230681145351)
- (structured) logging mindset can help with understanding - e.g. messages with some story telling, gives better context
- [made it here!](https://twitter.com/r2r/status/1374546234602627072) - "hello world" sanity testing

# debugger

- [reverse debugging is rare](https://twitter.com/Azumanga/status/1380956187580055557)
- examine program execution without making changes to the code
- tracepoints are quicker and easier than adding printfs, when they work
- can be a security nightmare in production
- [requires setup](https://twitter.com/nickaczel/status/1380586741170630658)
- shows more state than your printfs might have missed
- lots of [<abbr title="repetitive strain injury">rsi</abbr> inducing button pushing](https://twitter.com/devingunay/status/1381003562809892866)
- can be [non-trivial to attach a debugger](https://twitter.com/ashtonshudson/status/1380561236622970880)
- better when you are unfamiliar with the code since [multiple stack levels are shown](https://twitter.com/CheapSteak/status/1380745599868399617)
- some debuggers allow you to [edit code whilst running](https://twitter.com/treylorswift/status/1380671990181343232) which can help improve iteration speed
- some debuggers are fragile, breakpoints missed etc
- debuggers changes timing behaviour, so you may [never hit a timing bug](https://twitter.com/x1jdb/status/1380862290975670275)
- debuggers are like magic and you don't know why it worked
- debuggers can be [difficult in asynchronous environments](https://twitter.com/natessilva/status/1380591190848892931)
