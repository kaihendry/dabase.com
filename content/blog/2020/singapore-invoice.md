---
title: "Singapore Payment Requests could be a LOT better"
date: 2020-03-13T15:58:46+08:00
description: The average invoice in Singapore is still pretty painful to pay
---

This is not an atypical payment request from an enrichment class:

<img src="https://s.natalian.org/2020-03-13/invoice.png">

What could be better here?

1. Due date could be better advertised
2. No way to quickly pay the invoice via a link that includes a reference. [1]
3. Total includes late fee. Am I already late? Huh?
4. No way of me knowing if I have already paid this amount (assuming I forgot the next step)
5. Expects a reply telling them the date of the transfer

# [1] Paynow with a reference?!

Good for you and the vendor to have a hopefully unique way to identify what you
paid for.

This in an ideal world would be part of the Paynow QR code. I enquired about
getting a reference embedded in the payment and perhaps a Webhook (so the
vendor knows the invoice was paid) and this is the reply from DBS:

> For API solution, as this is a premium solutioning there will be an initial
> implementation setup fees starting at $25K payable to DBS.  There will also
> be tech cost to be incurred for customer’s own system to be integrated with
> the API solution.  Transaction cost via API will be advised further by the
> relevant team as it differs from product to product.

# DBS UX is abysmal

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">The <a href="https://twitter.com/digibank?ref_src=twsrc%5Etfw">@digibank</a> by <a href="https://twitter.com/dbsbank?ref_src=twsrc%5Etfw">@dbsbank</a> is so frustrating <a href="https://twitter.com/hashtag/paynow?src=hash&amp;ref_src=twsrc%5Etfw">#paynow</a> 😖 <a href="https://t.co/RNfpneooGh">pic.twitter.com/RNfpneooGh</a></p>&mdash; Kai Hendry 🇸🇬 (@kaihendry) <a href="https://twitter.com/kaihendry/status/1266550701011820545?ref_src=twsrc%5Etfw">May 30, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

I have publicly complained about the [DBS UX showing your balance as you pay](https://www.reddit.com/r/singapore/comments/gipq19/pay_by_uen_ux_shows_my_balance/).

It's too easy to [accidentally make mistakes](https://www.reddit.com/r/singapore/comments/e0xdkj/spore_lady_wrongly_paynows_s500_to_spore_man_both/) as most vendors do not have a way creating a preset for you.

There are some systems that create a QR code on the POS, but I am not sure how much they cost:

<img src="https://s.natalian.org/2020-06-04/paynow-prompt.jpeg" alt="Paynow QR code generation">
