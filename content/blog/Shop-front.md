---
title: Shop Front
description: Proposal for a static product page generator aimed at Influencers and small business vendors without online presences
date: 2020-08-10T08:57:36+08:00
---

{{< youtube KtHz5JO7QS4 >}}

Update: Initial project repo <abbr title="Work in Progress">WIP</abbr> <https://github.com/kaihendry/shopfront>

Problem: Small businesses (**vendors**) can't be expected to run their own online
store selling their own products, despite Shopify/Woocommerce being fairly good
solutions.

Problem: Influencers / Content creators who care about the products are limited
to Affiliate (referral) programs run by big companies like Amazon or Lazada.
Small vendors do not have a convenient way of rewarding content creators for
opening new accounts with their effective marketing work.

Solution: My opensource software is for _influencers_ to download and make
{build,deploy} on their **own example.com site**. You (the influencer) describe
/ market the product with videos, images and text using a fixed JSON schema,
and my MIT licensed "Shop front" software generates the product pages as static
pages.  These static pages can then be uploaded to a domain like
https://shop.example.com or https://example.com/shop

The consumer experience:

1. Finds content about product from (you) the Influencer
2. Follows link to Influencer's https://example.com/shop
3. Buys the product
4. Order confirmation

The vendor's experience:

1. Email of order, effectively that resembles a paid invoice
2. Vendor proceeds to fulfil order

If product is out of stock (no inventory) or cannot be satisfied for the price,
vendor is expected to **refund** / cancel the order. This is done via a Stripe
dashboard.

## How "Shop Front" works

Vendor needs to opt in to a [Stripe Connect](https://stripe.com/en-sg/connect)
account on your deployment.

When a purchase is made from https://example.com/shop, the order goes through
Stripe connect. Say the item is for 100 USD (a price you set!), an expected
breakdown _could_ be:

1. 5USD going to Stripe (this includes Visa costs et al)
2. 5USD going to you, the Influencer (hopefully you can adjust this)
3. 90USD going to the product Vendor (who delivers the product)

Sidenote: Where is my cut as the developer of "Shop front"? I do not intend to have one!

# FAQ

## Who owns the customer?

This is not black and white. Essentially the vendor will only have the
consumer's delivery address (maintain privacy) for fulfill the order. Though I
suspect the consumer will turn to the **Influencer for support**.

## What about inventory?

For version 1, there will be no inventory query.

If the product is not in stock, the vendor needs to ideally cancel the order.
The influencer is ideally involved, to ensure the product page is updated.

## What about price?

The influencer needs to set the price with the above projected (5/5/90) break
down in price.

If the vendor cannot fulfil the order for the price, the vendor should refuse /
cancel the order. Again, the influencer is ideally involved, to ensure the
product page is updated.

## What about crypto?

Shrinking the 5% or so that goes to Stripe (and Visa) would be nice, but at
what cost? I'm keeping mainstream for my sanity. Stripe's APIs and dashboard
offers a lot of value.

## The product listed is more expensive than the vendor's page

A vendor might have a Website nonetheless, or some account at Amazon, or the
same product listed on another "Shop Front" deployment, where prices are
probably not going to be aligned.

Hopefully consumers can recognise and reward who put the effort in.

## Dude, you have just described a [Drop shipping](https://en.wikipedia.org/wiki/Drop_shipping) solution... are you running a scam?

Stripe connect makes sure the money goes to the vendor. You (the "influencer")
are not a "middle man", the solution does not hide the vendor.

The vendor must opt-in (via Stripe Connect) to this arrangement.

This opensource software does not intend to get a commission or kick back. My
motives are to empower small business and reward influencers by allowing them
to create content on products they recommend on their own site.

I hope you and myself will deploy the resulting static "Shop Front" product
pages on your homepage.

## How do you account for delivery costs and estimations?

The version 1 / <abbr title="Minimum Viable Product">MVP</abbr> won't. Perhaps
later like inventory et al. <abbr title="Keep it simple stupid">KISS</abbr> 😘
