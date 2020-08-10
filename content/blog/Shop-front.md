---
title: Shop Front
description: Proposal for a static product page generator aimed at Influencers and small business vendors without online presences
date: 2020-08-10T08:57:36+08:00
---

{{< youtube KtHz5JO7QS4 >}}

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
http://shop.example.com or https://example.com/shop

The consumer experience:

1. Finds content about product from Influencer
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
account on my deployment.

When a purchase is made from https://example.com/shop, the order goes through
Stripe connect. Say the item is for 100 USD, an expected breakdown would be:

1. 5USD going to Stripe (this includes Visa costs)
2. 5USD going to Influencer
3. 90USD going to Vendor

Sidenote: Where is my cut as the developer of "Shop front"? I do not intend to have one!

# FAQ

## Who owns the customer?

This is not black and white. Essentially only the vendor will only have the
consumer's delivery address for fulfill the order. Though I suspect the
consumer will turn to the **Influencer for support**.

## What about inventory?

For version 1, there will be no inventory query.

## What about price?

The influencer needs to set the price with the above break down in price.

If the vendor cannot fulfil the order for the price, the vendor should refuse /
cancel the order. This could be problematic, but ultimately the problem should
escalate to the influencer.
