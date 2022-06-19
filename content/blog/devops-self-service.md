---
title: "Self Service in Infrastructure"
date: 2022-06-19T21:33:41+08:00
description: Exploring the Devops idea of "self service" on the modern Cloud
---

# The problem: Ticket based systems for provisioning Infrastructure

Does a **Service team** need infrastructure to provide a service? Please follow
this XX step kafka-esque process to raise a ticket with the Infrastructure team
and **wait** for the infrastructure service to be provisioned.

Why does this suck?

1. **Slow**
2. Service team **detached from billing**
3. **Service team detached & disempowered** from underlying parameters of the Cloud resource
4. Communication costs between Infrastructure and the Service team; _oh I'm sorry the timeline of our team does not match your team's_

Why does this happen?

1. The process reflects the existing **change management** / organisational structure
2. **Legacy** reasons as this is the process how (on-premises) resources are allocated (aka not Cloud native)
3. **Lack of trust** between "gate keeper" Infrastructure Administrators, and the "resource hungry" Service teams
4. Strict policies that must be **compliant**, for example in a heavily regulated industry with a low risk appetite
5. Service teams don't have the skills to provision Infrastructure themselves, aka lack **Devops skilled** team members

# A better approach

Service teams provide all the resources they need in the accounts with AdministratorAccess themselves! They manage their own [Path to Production](/blog/2022/path-to-production/). 🙌

1. **Cross functional teams**, "devops" should be part of the service delivery team
1. External linting (e.g. AWS Config) enforcing policy
1. External budget alerts

In larger / highly regulated companies it's typical that the production account
is managed by a different team to the Service team to enforce the concept of
[Separation of Duties](https://en.wikipedia.org/wiki/Separation_of_duties).

<img src="https://s.natalian.org/2022-06-19/org-formation.png">

# Where things can go horribly wrong

Usual rhetoric is "lack of standards". "AdministratorAccess freedom" given to
Service team's accounts is deemed too heterogeneous, too difficult to maintain
and plan for. The consequence is that Service teams are limited to a set of
resources via a "gate keeper", aka the Infrastructure team.

"Self service" **with standards** inevitably becomes some proprietary **YAML
abstraction** on AWS resources, instead of empowering Service teams to directly
provision AWS resources themselves. 😢

Yes, it's non-ticketed, but it often has problems:

1. **Poor developer experience**, you want EKS and RDS? Please fill in these YAML templates and wait for the law of leaky abstractions to expose a bug
2. **Resorts back to a ticketed system** when the abstraction doesn't fit
3. Worst is when organisation tries to go **multi-cloud** and provides a lowest common denominator set of (unmanaged) services

# Conclusion

Cloud native technology can empower Service teams to provision their own
infrastructure **with guard rails**. ☑

Infrastructure teams instead focus on resources like Accounts (Org Units),
costs (budgets), applying policies (AWS Config), tags and supporting Operations
by following best practices like dedicated {security,logging,networking}
accounts.

Legacy infrastructure teams shed responsibilities, move from being ticket based
to advisory, like actively working with teams to leverage the Cloud, reduce
costs or better still, joining the Service delivery teams.
