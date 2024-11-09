---
date: 2015-06-16 08:56:16 +0100
---

Update: 2015-06-17 Since I blogged this, I have been told I have 7 days to
leave the service whilst on holiday. A SaaS horror story. :(

I logged my migration anguish over at [[7_days_to_leave_Hiveage]].


First, can I just say that Curdbee/Hiveage service has been good over the
years. I like the product and I want to see it improve.

After complaining several times about [Hiveage](https://www.hiveage.com/), I
get this from support in Oct 2014:

<blockquote>On a somewhat related note, are you happy with using Hiveage? It seems you
haven't had the most pleasant experience with it. There won't be many changes
in the way we continue to develop the service, so if it isn't the right fit for
your requirements, we would encourage you to find a service that does. A happy
client is way more important to us than the subscription they pay us!</blockquote>

Unfortunately my feedback doesn't seem welcome and my requests aren't logged.

Here are some of Hiveage's shortcomings for me:

# Expects me to fill in client's address customers, without prompting the customer to fill in their details.

This results in a LOT of copying and pasting on my behalf

And their inline modal UI for adding a new contact whilst creating an invoice is really silly: <http://s.natalian.org/2015-06-16/1434440623_1918x1058.png>

# Broken invoice search

Can't lookup my customers invoice based on the description I place on the invoices

# No automatic reminders for invoices raised as drafts

Leading to all sorts of potential annoyances for customers

# Missing one step method to mark invoice as paid

Requires 5 steps currently

<s><h1>No bitcoin support</h1></s>

I think they have support via [coinbase](https://www.hiveage.com/blog/accept-bitcoin-payments-with-coinbase/) now

# No sane way to toggle options on a Web application

Their menu system is byzantine. Prepare to go through several layers of menus.

Good URL design would have helped here.

# No way to add additional email addresses on a contact

Yes, sometimes a customer can have several email addresses that need to be notified when an invoice is issued.

# No way to set defaults

You need to roll with their defaults, like for frequency of new invoices

# Doesn't remember updates to invoices

So if the quantity goes up, you have to change it in the recurring invoice, not
the draft one...

# Can't have order number counters specific to customer

If I am billing a company called Acme&Acme, I like to set the order number as
AA-1. It's a strange requirement maybe. So the next I bill Acme&Acme it
becomes, AA-2. However Hiveage cannot cope with this and any invoice will
appear as AA-2 as the next invoice. Until I change it manually. E.g. I change
it to ZZ-1 and then Hiveage naively goes to ZZ-2 for the next invoice.

# No contacts API

So I have two disperate contact lists I have to maintain. One on Hiveage and
one on Fastmail. Very annoying.
