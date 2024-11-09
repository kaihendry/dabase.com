---
date: 2015-06-24 10:02:42 +0100
---

Update: [Wrote my own billing platform](https://www.youtube.com/watch?v=PPL1C5TmGvY)

I'm on holiday, but I need to leave Hiveage since I'm been told to leave the
service in this [email exchange](http://s.natalian.org/2015-06-17/7days.pdf),
after posting [[Hiveage_grievances]]. :(

# Day 1 (Tuesday)

The export options are not encouraging:

<img src=http://s.natalian.org/2015-06-16/1434473307_1918x1058.png alt="Hiveage Export UI">

I have three things to worry about. Fact that I can only export 1000 records at
a time, the time period & last but not least the 10 different types of data I
need to export.

	Exporting data. This could take a while. We will send an email upon completion.

Judging by this [SSL
message](http://s.natalian.org/2015-06-16/1434473501_1918x1058.png), I don't
think this code path is tested much.

Anyway, I put in 104 connections/contacts and I got 104 contacts out. Now I
want to import them to Fastmail. Been meaning to do this tbh, since I want my
addressbook in one place ideally.

## Obstacle 1: migrating contacts

I can import my contacts, but not to a separate list. Also my carddav account
isn't working. Update: Fastmail have not got back to me about **carddav** which
is in BETA

## billing.webconverger.com/invs/secrethash aren't in the exported data

So my customers get a URL which they click on and then they view the invoice
and pay. The secrethash isn't in the exported data AFAICT.

# Day 2 (Wednesday)

Fastmail confirmed I can't import contacts to a separate list. I have thought
of a workaround: Create new business user. Import contacts to that contact.
Share contacts. Delete user.

So I've decided to write my own billing system. I will try to make it opensource,
though it will built for just me and my business: <https://webconverger.com/>

I'm breaking the problem in my mind into 3:

1. Dashboard showing recurring profiles, showing when invoices are coming up
* Generating a URL e.g. <billing.webconverger.com/invs/secrethash> to send to customers that gives them all the information they need to pay. Use [prince](http://princexml.com/) to generate PDF
* Integration to Paypal/Braintree, so customers can click "Make Payment" and I get notified when they get paid

Another issue with the contacts. The imported CSV details like State Name, Zip
code etc. are being imported into the NOTES field of the vcard(vcf). I'm
inclined to blame Fastmail's inflexible importer here.

TODO: Make a simple UI (contenteditable?) where customers can update their
contact information.

# Day 3/4 (Thurs/Fri)

I got Payment working with Braintree's sandbox. I used the PHP Braintree API
with V.Zero aka Dropin. It's a bit slow for my liking and it honestly took me
the whole day to integrate because some things were confusing.

Custom values for example need to be declared. The Paypal API actually doesn't
work yet in Singapore. Anyway, late on Friday afternoon I think, I toggled it
into Production and noticed a big problem. The production account is fixed to
only accepting SGD!! This was a total surprise to me.

I tried currencyIsoCode/currency_iso_code in `Braintree_Transaction::sale`. No dice:

	PHP Fatal error:  Uncaught exception 'InvalidArgumentException' with message 'invalid keys: currencyIsoCode'
	PHP Fatal error:  Uncaught exception 'InvalidArgumentException' with message 'invalid keys: currency_iso_code'

Braintree who took 3 months to setup the account seem to think it will take
between 7 to 10 days to be able to settle in USD. Ok, I must go back to
Paypal's infamous `paypal.com/cgi-bin/webscr` API then!!

Update: Oh btw, this is what my [production test 5SGD looked like from Barclays
online](http://s.natalian.org/2015-06-24/barclays-braintree-sg.png)! No [CVV](https://en.wikipedia.org/wiki/Card_security_code) used !

# Day 5/6 (weekend)

Fastmail did get back to me saying that I can import the contacts into a
separate list if I downgrade to their classic UI, and filter by contacts not in
a group. This doesn't help me because my 1000s of contacts (mixed with personal,
exported from Gmail) are all not in a group! _Sigh_

My sister and brother in law came down and since this is a family holiday and
left the laptop and instead was a mostly in a snappy stressful mood. Thinking
of all the things I need to do still in order to take payment from customers
and not piss off any customers.

# Day 7 (Monday)

I need to create a billing.webconverger.com to redirect important outstanding
invoices to an invoice to be paid on my new system.

Secondly I need to double make sure, I have exported recurring profiles from
Hiveage. If I lose this data, then I lose my business revenue from subscribers.

I need to implement **Make payment** with Paypal. Tbh I've done this before a
couple of times so I am not too worried. What I am worried about is customers
not wanting to pay through it.

Today is going to be a stressful day!

Prabath at Hiveage got back to me:

	The account deactivation is set for June 24, 00:00 UTC.
	Sorry, I'm afraid there's no direct way to export the invoice URL hashes.

I enquired about Stripe in Singapore via twitter and I heard back
<https://twitter.com/stripe/status/612997244774653952>, which was cool!

# Day 8 (Tuesday)

I'm beyond stressed. Last day with family on my holiday in the UK. I'm a little
numb.

I've triple checked I've got the exports. I'm using Firefox's dev function take
screenshots of various views in case the export was missing it, or I didn't
figure out how to reconstruct it.

I was hoping Braintree would be coming through for me, so I could accept
payments in USD, but it looks not. So I have to
integrate Paypal tonight... or since I'm chilled out about this... tomorrow.


Bit disappointed Fastmail hasn't got back to me about the BETA, or provided a
good solution for CardDAV yet. So right now I've using badly converted VCF
contacts to create the invoices with. I'm downloading and linking them manually
which is very cumbersome, I'm praying that a CardDAV API will make it this much
easier.

Late last night I updated billing.webconverger.com CNAME on AWS Route53 to
point to my own server (previously it was pointing to webc.hiveage.com) and
give customers a message. I'm only redirecting the latest batch of outstanding
invoices. I have a couple of days to build out some recurring billing logic.

# Day 9 (Wednesday)

Tried logging on and got "Invalid email or password.". Guess I am now properly
booted off!

<img src=http://s.natalian.org/2015-06-24/1435136433_1054x1058.png>

I'm determined to make paying invoices a better experience for customers. I'm
determined to create a better billing system than Hiveage ever could. For
example I didn't have a good way to cross reference how many machines were
payed for by an individual customer, with the amount of machines that customer
had on their Webconverger control panels. This will now be possible, so I am
thinking the future looks good.

Nonetheless my invoicing today is in tatters. There is a lot of work to do. :/

Today I noticed the exported data is missing descriptions, rate and quantity. I
don't believe it!!! :( :( Wrote a desperate email to Prabath.

## Retrieving the hash information

I probably could do this with Fastmail's JSON API somehow, but since Gmail gets
a copy of my Hiveage email I:

1. Created a [filter for Hiveage](http://s.natalian.org/2015-06-24/filter-hiveage.png)
* Create an [App password for gmail](https://security.google.com/settings/security/apppasswords)
* Created an isync configuration [~/.mbsyncrc](http://s.natalian.org/2015-06-24/mbsyncrc.txt)
* `mbsync gmail`
* `hiveage$ grep -roh "http://billing.webconverger.com/invs/\w*" . | sort | uniq > ~/.mail/hashes.txt`

Once I've basenamed the hashes.txt to a h.txt I then retrieve the PDF versions of the invoice like so:

	while read hash
	do
			if ! test -f $hash.pdf
			then
					wget https://webc.hiveage.com/invs/$hash/download.pdf -O $hash.pdf
			fi
	done < h.txt

If there was an easier way to retrieve the "http://billing.webconverger.com/invs/XXXXXXXXXXXXXX" URLs from my mailbox in
Gmail/Fastmail interface, I would love to know.

## Lost description, quantity & rate information

I mentioned earlier that I noticed missing fields in the invoice CSV. [Prabath
got back to me saying the data has been
deleted](http://s.natalian.org/2015-06-24/gone.pdf). I honestly didn't think it
would be worse than losing functionality at this point. Looks like I've lost my
own data too. :( :(

I am reeling emotionally. This is my livelihood getting screwed over. My only
solace after calming down a bit is that the current state, I know that people
have paid up for the most part. So I should be able to work backwards and
hopefully my customers can fill in the blanks.

I seriously cannot believe this.
