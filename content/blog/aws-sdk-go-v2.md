---
title: AWS SDK Go V2
date: 2021-08-18T09:11:44+08:00
description: A very awkward to use version two SDK by Amazon Web Services
---

<img style="width: 40%; vertical-align: top" src="https://s.natalian.org/2021-08-18/Amazon_Web_Services_Logo.svg" alt="AWS logo">
<img style="width: 40%; vertical-align: top" src="https://s.natalian.org/2021-08-18/Go_Logo_Blue.svg" alt="Go logo">

Yesterday I introduced my colleague to
[aws-sdk-go-v2](https://aws.github.io/aws-sdk-go-v2/) and I must say it was one
of the most frustrating experiences of my life!

tl;dr I don't recommend aws-sdk-go-v2 despite shilling it in http://talks.webconverger.com/2018-01-25/

# the IDE experience

VScode with Copilot actually is a hindrance because most Golang/AWS code is written for
version one of the AWS GO SDK. It keeps suggesting code that will not work with
github.com/aws/aws-sdk-go-v2/service!

If you are new to an API, you are relying on the IDE discover types and such in
order to get work done. VScode could not second guess I needed for example
**github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs/types** to able to roll
up the log Groups I was pulling down. Incredibly frustrating. Furthermore EVEN
IF I KNOW WHAT I AM DOING, VS code is always asking me to manually *go get*
something? WHY MAKE ME JUMP HOOPS?

Furthermore, I don't know why, may times it just couldn't tell me information
about structs I was interested in. Instead I had to use the broken experience
of the [API docs](https://pkg.go.dev/github.com/aws/aws-sdk-go-v2).

# Searching the API docs developer experience is terrible

If you are careless you can easily search or follow a link and simple be
looking at the WRONG API docs: https://pkg.go.dev/search?q=cloudwatch, i.e. not version 2.

I somehow managed to use some weird fork for a while whilst developing.

If you use https://github.com/search as I do, you will find Github's search
syntax seems to choke on hyphens and slashes.

# The SDK is non-idiomatic

> The use of pointers (string pointers, integer pointers, etc) all over the SDK
> really goes against how Golang is supposed to be written.

https://github.com/aws/aws-sdk-go-v2/issues/205

The API is generated and you can tell. No examples inline in the API docs. Lots
of confusing paradigms like aws.String("what the hell").

Worst is in many cases, like for example adjusting Limit: aws.Int64(51) as
opposed to the 50 API limit, will result in head scratching experiences like:

<img src="https://s.natalian.org/2021-08-17/out-of-mem-limit-describe-groups.png" alt="go nil pointer reference">

# The documentation is terrible

I generously gave more of my precious time to filing in this [bug
report](https://github.com/aws/aws-sdk-go-v2/issues/1382) about [their broken
developer
guide](https://aws.github.io/aws-sdk-go-v2/docs/code-examples/sts/assumerole/).

I usually think of using aws-sdk-go-v2 because it has better **cfg** structures
for complex credential handling. Fact is, it's a nightmare. Such a shame since I advocate both AWS & GO.
