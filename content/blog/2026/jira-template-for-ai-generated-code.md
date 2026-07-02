---
title: "A Ticket Template for AI-Generated Code"
date: 2026-07-02T16:47:06+01:00
description: "A trimmed JIRA/issue template — story, scope, acceptance criteria, plus an AI verification section — inspired by Dave Farley and Matteo Vaccari's talks on keeping AI-generated code honest."
---

Two talks worth watching if AI is writing code and tests for you:

- Dave Farley, [A Harness for Behaviour](https://www.youtube.com/watch?v=libNzUdL9eM) — natural language alone isn't a good enough spec; treat behaviour as versioned, executable examples and verify against inputs the AI never saw.
- Matteo Vaccari, [Ensuring AI-generated Code Does What We Want](https://www.youtube.com/watch?v=3tdmoj35HG0) — AI-written tests tend to check implementation details rather than behaviour; keep specs as data, assert only observable outcomes, and simulate rather than mock external systems.

Both point at the same failure mode: a green test suite that's lying to you. Here's a ticket template that tries to bake the fix in, rather than relying on remembering to ask for it.

## Vaccari's core idea

From [his talk](https://www.youtube.com/watch?v=3tdmoj35HG0), Matteo Vaccari boils it down to four rules, each with a reason:

1. Tests should express what you care about — so that you can understand them.
2. Tests should be tabular — so that it's easy to add tests.
3. Tests should be data, not code — so that I can easily spot when AI is changing them.
4. Black box testing — so that the tests are not coupled to the implementation.

The template below is one way to apply that in a ticket, so the "tests as data" habit starts at the point the work is described, not as an afterthought once the AI starts generating code.

## Template

```markdown
## Context

## Story

* AS A <role>
* I WANT <observable change>
* SO THAT <valuable outcome>

## Scope

* IN
* OUT

## Acceptance Criteria

Scenario: <name>

* GIVEN $context
* WHEN $event
* THEN $outcome

| context | event | outcome |
|---|---|---|
| ... | ... | ... |

## AI Verification

* Held-out case (not shown to the AI): ...
* Simulate, don't mock: ...
* [ ] Fault-injection: broke the behaviour on purpose, confirmed the test failed
```

The only addition to a standard story template is **AI Verification** — three cheap checks that catch the specific ways AI-generated tests go wrong: overfitting to what it saw, coupling to a mocked call instead of real behaviour, and tests that pass no matter what.

## Example

> Customers currently have to email support to cancel an order, which is generating ~40 tickets a week and delaying refunds.

## Context

Customers can't cancel an order themselves — every request goes through support, who cancel manually and trigger the refund by hand.

## Story

* AS A customer with a pending order
* I WANT to cancel it myself before it ships
* SO THAT I get my refund immediately without contacting support

## Scope

* IN: cancel action on the order page, automatic refund, blocking cancellation once shipped
* OUT: cancelling individual items within an order, cancelling after delivery (that's the returns flow)

## Acceptance Criteria

Scenario: Cancel an order

* GIVEN an order in a given status
* WHEN the customer requests cancellation
* THEN the order is cancelled and refunded, or the request is rejected, depending on status

| order_status | action | outcome |
|---|---|---|
| pending | cancel | cancelled + refunded |
| processing | cancel | cancelled + refunded |
| shipped | cancel | rejected: "already shipped" |
| delivered | cancel | rejected: "already shipped" |

## AI Verification

* Held-out case: order status "backordered" (item awaiting restock, never reached "processing") — withheld from the AI to check it generalized the status rule instead of pattern-matching the four rows above
* Simulate, don't mock: run against a fake warehouse/payment gateway that tracks real state transitions, not a mock hardcoded to return `shipped: false`
* [ ] Fault-injection: allow cancellation regardless of status, confirm the shipped and delivered rows fail

That last checkbox is the one that matters most. If you can't break the behaviour and watch the test catch it, the test isn't testing anything.
