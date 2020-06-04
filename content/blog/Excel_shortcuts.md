---
title: Excel shortcuts for Lusers
description: Excel shortcuts from a long time Linux user
date: 2020-06-04T14:12:58+08:00
---

<style>
/* https://shkspr.mobi/blog/2020/05/better-keyboard-buttons-in-html/ */
kbd {
    border: .1em solid #aaa;
    border-radius: 15%;
    display: inline-block;
    padding: .1em .5em;
    background: linear-gradient(180deg, #fff, #fff, #fff, #ddd);
    user-select: none;
    cursor: pointer;
    color: #000;
    font-weight: bold;
}
kbd:hover {
    background: linear-gradient(0deg, #fff, #fff, #fff, #ddd);
}
</style>

Inspired by [@edent's blog](https://shkspr.mobi/blog/2020/05/better-keyboard-buttons-in-html/) and ... a [Tiktok series by @acouplecents](https://www.tiktok.com/@acouplecents):

1. https://www.tiktok.com/@acouplecents/video/6819380884333006086
2. https://www.tiktok.com/@acouplecents/video/6821158756852813062
3. https://www.tiktok.com/@acouplecents/video/6827655218629463301
4. https://www.tiktok.com/@acouplecents/video/6827903955343887622

* <kbd>Ctrl</kbd>+<kbd>&larr;</kbd>/<kbd>&rarr;</kbd> move around a spread sheet quickly
* <kbd>Esc</kbd> / <kbd>F2</kbd> -- Toggle between editing, like <kbd>Esc</kbd> works in [vim](https://www.vim.org/)
* <kbd>⇪</kbd>+<kbd>Space</kbd> -- Highlight row
* <kbd>Ctrl</kbd>+<kbd>Space</kbd> -- Highlight column
* <kbd>Ctrl</kbd>+<kbd>⇪</kbd>+<kbd>+</kbd> -- Inserts row or column depending on context
* <kbd>Ctrl</kbd>+<kbd>-</kbd> -- Deletes row or column
* <kbd>Ctrl</kbd>+<kbd>PgUp</kbd>/ <kbd>PgDn</kbd> -- Move between sheets
* <kbd>Ctrl</kbd>+<kbd>r</kbd> -- when highlighting cells to right, copy to right
* <kbd>Ctrl</kbd>+<kbd>d</kbd> -- copy down
* <kbd>Alt</kbd>+<kbd>=</kbd> -- Sum up something

Here is the authoritative [list of shortcuts for Microsoft Excel](https://support.office.com/en-us/article/keyboard-shortcuts-in-excel-1798d9d5-842a-42b8-9c99-9b7213f0040f), but they don't highlight the productive ones.

# Filtering

For me, working with **EC2InstanceRecommendations-DirectMatch** exports from [AWS
Migration Hub](https://aws.amazon.com/migration-hub/), I need to be able to
filter machines that are designated to migrate to the cloud.

A great tip I've found is to use [COUNTIF](https://www.extendoffice.com/documents/excel/3694-excel-filter-based-on-another-sheet.html) for advanced filtering based on other cells. When filtering I've found two issues:

1. It's not clear what is filtered out
2. Totals are not recalculated properly

I don't know how to solve 1., but for 2. I've found using [SUBTOTAL](https://support.office.com/en-us/article/subtotal-function-7b027003-f060-4ade-9040-e478765b9939) instead of [SUM](https://support.microsoft.com/en-us/office/sum-function-043e1c7d-7726-4e80-8f32-07b23e057f89). I'm not sure why tbh.

# Excel support

Via [Twitter they referred me](https://twitter.com/msexcel/status/1268209786987974661) to a [TechNet forum](https://social.technet.microsoft.com/Forums/en-US/home?category=&forum=&filter=&sort=relevancedesc&brandIgnore=true&searchTerm=excel+filtering) which looks like a train wreck to me.
