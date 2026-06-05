---
title: "The Klinik NHS Access Form Is Failing Patients"
date: 2026-06-05T09:13:12+01:00
description: "Documenting my complaint about the broken UX of the Klinik Access form used by Bosvena Health — opaque closures, broken proxy login, same-day expiry, and feedback that never reaches the practice."
draft: true
---

On 5 May 2026 I tried to book a same-day GP appointment for my sick son using [Klinik Access](https://access.klinik.co.uk/), the online triage form at my surgery [Bosvena Health](https://www.bosvenahealth.co.uk/). Here is what is broken.

**The form goes "snooze" without explanation.** Outside opening hours — or once daily slots are full — Klinik shows a snooze page. Most patients will never have encountered this concept. The message essentially says "come back tomorrow" with no explanation of whether slots are full, whether it is out of hours, or what to do if the need is urgent.

**The form loops.** My son's symptoms had to be re-entered multiple times as the form circled back on itself. By the third pass I nearly gave up. Each extra step is another dropout, especially for patients on a phone under stress.

**Do not use NHS login if booking for someone else — but good luck knowing that.** When I logged in with my NHS account, my details were locked in as the patient. There is no way to correct this mid-form. The workaround is to ignore the NHS login button and hit Continue instead:

<figure style="text-align:center">
  <img src="klinik-login.png" alt="Klinik login screen showing Continue button and NHS login option" style="border:1px solid #999; max-width:480px; width:100%; display:block; margin:0 auto">
</figure>

The instruction is there, but at 8am with a sick child it is easy to miss. Klinik's response was "you should have read the note." That is not UX design — if NHS login breaks the most common proxy scenario (parent booking for child), fix the flow.

**Submissions expire at the end of the day.** My son was on a school trip when I submitted a follow-up request. The practice would not act on it — he had to be available that day. I had to resubmit everything from scratch the next time he was unwell. Every day is day one, regardless of what you already submitted.

**In-form feedback never reaches the practice.** I submitted feedback through the Klinik form several times and never received a response. It turns out this feedback goes directly to Klinik — Bosvena Health never sees it. Klinik's response? They will review whether the wording can be amended to make that clearer. Not fix it — just maybe reword it.

## The complaint

I emailed [bosvena.letters@nhs.net](mailto:bosvena.letters@nhs.net) on 5 May. Bosvena Health's admin team responded promptly, obtained my consent to share a recording of the session with Klinik, and followed up. After chasing two weeks later, Klinik's written response arrived on 1 June.

Klinik acknowledged several issues — snooze page wording, the Pharmacy First loop, the feedback module confusion — and said they had raised others with developers. Address fields do not support browser autofill, forcing tedious manual entry. Klinik attributed this to cookie settings — missing the point entirely. The NHS login problem was attributed to me not reading the note.

Some responses are fair. But the core issue — that feedback submitted through their own form produces no visible improvement and never reaches the GP practice — was not addressed.

## The real problem

Bosvena Health do not own this form. Klinik do. When something goes wrong, the practice must relay complaints to a third party, wait for a response, and pass it back. That is the process I went through — and it took a month.

Meanwhile, every piece of patient feedback submitted through the form goes straight to Klinik. Bosvena never sees it. Patients assume they are giving feedback to their GP surgery. They are not. It vanishes into a vendor's inbox.

No single party feels fully responsible. Klinik can say the practice configures the form. The practice can say they do not own it. Patients are left navigating a broken experience with no clear owner and no way to make their voice heard where it might actually change something.

That is the structural failure here — not any one bug, but a procurement model that separates accountability from experience.
