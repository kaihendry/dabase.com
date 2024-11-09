---
title: Diagrams for documentation
date: 2021-04-07T11:20:54+08:00
description: How to create Diagrams for Documentation
---

# Use https://excalidraw.com/

[MIT licensed OSS at its finest](https://github.com/excalidraw/excalidraw) 🍷

E.g. how I develop this blog before git committing:

<svg xmlns="http://www.w3.org/2000/svg" width="806" height="550"><defs><style>@font-face{font-family:&quot;Virgil&quot;;src:url(https://excalidraw.com/Virgil.woff2)}@font-face{font-family:&quot;Cascadia&quot;;src:url(https://excalidraw.com/Cascadia.woff2)}</style></defs><path fill="#fff" d="M0 0h806v550H0z"/><path d="M10.022 45.193c93.68 1.09 187.98.975 405.894.407m-406.434.592c128.384 1.286 256.65 1.246 406.357-.369m1.045-.411c.548 60.61-2.408 125.853-.19 174.742m-.089-174.712c1.35 68.54.478 138.428-.438 174.09m.302-1.137c-132.574.856-264.82 1.002-406.095-.409m405.361 1.164c-89.477.242-178.457-.098-406.197.092m.192.279c-.214-53.91.495-106.222-.32-174.509m.807 173.537c-1.341-61.313-2.759-124.103.485-172.533" stroke="#000" fill="none"/><text y="18" font-family="Virgil, Segoe UI Emoji" font-size="20" style="white-space:pre" transform="translate(45 119.5)">hugo new content/blog/diagrams.md</text><path d="M682.31 11.522c31.378 31.321 62.759 61.998 112.85 117.135M681.561 9.019c22.64 25.343 46.758 49.11 113.607 117.041m.503-.986c-39.824 44.463-82.11 86.254-112.997 116.93m112.485-114.79c-29.894 29.522-59.944 58.888-112.393 116.246m.44-1.815c-46.73-41.058-88.494-87.42-118.45-114.135M682.52 242.046c-27.135-26.24-55.207-53.909-117.417-115.042m1.003 1.323c23.9-28.248 50.447-50.735 116.303-116.875M565.34 126.92c31.503-30.718 62.51-62.739 116.128-116.914" stroke="#000" fill="none"/><text y="18" font-family="Virgil, Segoe UI Emoji" font-size="20" style="white-space:pre" transform="translate(629 113.5)">hugo serve</text><path d="M232.651 349.069c110.945-1.49 222.334-1.397 522.847-.409m-523.114.341c203.967-.85 408.33-.935 523.506.378m1.384-.146c-.621 46.432.942 95.529-.568 164.397m.178-163.724c.324 49.733-.813 99.346-.768 163.04m.454-.14c-109.016.362-216.447 1.059-524.62.256m524.08-.093c-176.25-.873-352.738-.77-524.392.32m-.557-.996c1.137-32.242 1.26-66.23-.015-165.099m1.764 166.17c-.42-54.661-.583-108.583-1.28-164.867" stroke="#000" fill="none"/><text y="18" font-family="Virgil, Segoe UI Emoji" font-size="20" style="white-space:pre" transform="translate(396.5 418)">http://localhost:1313</text><path d="M422.886 127.93c24.339-1.473 120.581-7.895 145.036-9.26m-146.555 8.268c24.807-1.281 124.135-5.442 148.783-6.978M542.686 130.097c4.803.425 12.326-1.518 28.11-8.436m-27.912 10c10.028-3.62 21.025-9.487 26.411-10.764" stroke="#000" fill="none"/><path d="M541.647 109.602c4.964 4.677 12.702 6.985 29.15 12.06m-28.952-10.495c10.565 4.516 21.975 6.782 27.45 9.73" stroke="#000" fill="none"/><g><path d="M677.453 242.328C645.63 258.282 517.9 322.282 486.101 338.13m193.234-96.385c-31.366 15.564-158.745 79.265-191.02 94.855" stroke="#000" fill="none"/><path d="M510.536 313.357c-3.88 5.488-9.54 11.629-21.788 23.46m21.197-22.388c-5.366 5.051-9.396 9.044-21.877 21.884" stroke="#000" fill="none"/><path d="M519.607 331.765c-5.98 1.48-13.593 3.657-30.86 5.051m30.268-3.979c-7.259 1.074-13.255 1.075-30.947 3.476" stroke="#000" fill="none"/></g><g><text x="168" y="15" font-family="Virgil, Segoe UI Emoji" font-size="16" fill="#adb5bd" text-anchor="end" style="white-space:pre" transform="translate(628 529)">Made with Excalidraw</text></g></svg>

# Embedding into markdown

<img src="https://s.natalian.org/2021-04-07/svg-export.png">

And just inline into your markdown, for example using `vim content/blog/diagrams.md`:

	:r diagram.svg

# Where and when?

Consider using in <a href="https://www.thoughtworks.com/radar/techniques/lightweight-architecture-decision-records"><abbr title="Lightweight Architecture Decision Records">ADRs</abbr></a>.

{{< youtube MLojBHurMyk >}}
