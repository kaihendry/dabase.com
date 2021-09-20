---
title: eSIM sucks when your phone dies
date: 2021-09-19T17:42:21+08:00
description: eSIM appears to make life more difficult
---

On the morning of 26 August I found my phone inoperable. A black brick. Would
not respond. Could not reset.

I quickly arranged for the soonest **Genius Bar Work Confirmation** at Apple
Jewel Changi Airport, about five hours later from discovering my dead phone.

Not having a working phone is pretty disorientating, especially when I am
reliant on [Authy](https://apps.apple.com/us/app/twilio-authy/id494168017)
which doesn't have a Desktop equivalent unlike https://1password.com/. TODO: Figure out how to move my 2FA to 1password!

# Entry in Jewel Airport

I had trouble entering the Airport since my phone was obviously not working, so
[TraceTogether](https://apps.apple.com/sg/app/tracetogether/id1498276074) was
not working. The security guard after a 10 minute wait managed to call his
supervisor over and sanity prevailed. Still I'm a little shocked having your
Identity Card is not enough to enter a building. You must have TraceTogether or
a Token! I subsequently went to my local community centre to get one, just in
case.

# Apple repair

I'm always surprised how long the repair process takes at Apple. You would
think it would be smoother, right?  Having no phone (or token) at the Airport
meant that I couldn't lunch or do anything practically. I basically sat and
stared at the Rain Vortex for three hours.

## Problem Description/Diagnosis

	Issue: customer presented iPhone with no power. Discovered in the morning that the phone will not power on

	Steps to Reproduce: Ran ICC DEVICE will not power on
	Ran SNR no issue

	Cosmetic Condition: No physical damage 
	LCI not triggered

	Proposed Resolution: Adv customer on on rear system replacement. Everything will be replaced except for the display and cameras.

	Advise customer screen protector may be removed to facilitate the repair.

	Customer ack.

	Please assist to loan customer a phone to contact Telco to see how he can get his ESim set up again. As he does not have a SIM card 

## Repair Estimate

	Item Number 	Description 	Price 	Amount Due 	Customer KBB 
	S9217Z/A 	IPHONE 12 PRO MAX, FLAT RATE,RETAIL 	S$ 830.84 	S$ 0.00 	
	ZP661-18659 	iPhone Rear System, Gold, 128GB, iPhone 12 Pro Max, ROW 	S$ 0.00 	S$ 0.00 	
	GST 		S$ 0.00 
	Total 	S$ 830.84 	S$ 0.00 

	I acknowledge that I agree to use REFURBISHED part(s)/unit(s)

Tbh I am surprised to see I agreed to used parts for the in warranty repair.

## Lost data

It would appear my last back up was from two days ago. I wish Apple were
somehow able to separate out the 128GB storage, because I believe the logic
board was dead. Storage was probably fine!!

And now the worst part. Despite having my phone "repaired", I had two issues:

1. It would take an entire day to conduct the restore process from iCloud
2. I had no mobile connectivity

# Reprovisioing eSIM to a bricked device

Neither Apple staff, nor M1 Singapore seemed to know how to get my repaired
phone connected again. This was the worst part.

<img src="https://s.natalian.org/2021-09-20/esim.png" alt="eSIM currently in use">

After painstakingly (restore process does not make this easy) managing to login
to my M1 account on the mobile, it said my "eSIM mobile line is ready to use",
which was a lie. Btw you cannot log into the Desktop M1 app without an OTP
challenge to your phone, so I am not sure how you're supposed to get support
over that medium if your line is not working!!

After hours of chatting, tweeting, calling
[MobileOne](https://en.wikipedia.org/wiki/M1_(Singaporean_company))... finally a
member of M1 seemed to know how to get the eSIM working.  At first the operator
said I should have first removed the eSIM profile of my failed device. I said I
didn't have the opportunity to do that!!!

Secondly the operator said in order to get connected again, I would need to get
a new eSIM at a 37.45SGD "one time" fee. 🤦‍♂️

# Conclusion

I can't recommend eSIM when M1 are pretty clueless about it and charge almost
40SGD to flick a software switch.
