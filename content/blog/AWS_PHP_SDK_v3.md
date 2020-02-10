---
date: 2016-08-27 14:40:59 +0800
---

Whilst "Dockerizing" a really simple [PHP project to send feedback
email](https://github.com/kaihendry/vanilla-php-feedback-form), I had the
unfortunate experience of tustling with the [AWS PHP
SDK](http://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-using-sdk-php.html)
in
<https://github.com/kaihendry/vanilla-php-feedback-form/blob/master/feedback/sesmail.php>


# Problem 1: Difficult to distinguish between SDK v2 and v3

The only way I've figured this out, is that examples with `SesClient::factory`
are v2. Otherwise I would expect `use Aws\Ses\SesClient;` to perhaps indicate
the version.

So this causes a lot of pain because I'm lazy and I'm looking for examples to
get this working quickly. Unfortunately most of Google results are for v2 and
don't work!

# Problem 2: The API is really hard to use

Ignoring the fact that the SDK weighs in at 8.2MB, I guess AWS must have some
automatic mapping to PHP and it really makes it HORRIBLE to use.

So what most people use in some API on top of the SDK or some other cut down
third party library. Both options are not great.

It almost brings me to years how we have come a simple 1 line invocation to the
[mail()](composer require aws/aws-sdk-php) 40 lines of code of
[sesmail.php](https://github.com/kaihendry/vanilla-php-feedback-form/blob/master/feedback/sesmail.php).

Sidenote: [[ssmtp|Mail_from_a_VPS]] is not an option since it's sadly synchronous and slow.

# Problem 3: The AWS PHP SDK documentation sucks

It's not crystal clear what required and what's optional in the [AWS SDK
documentation for sending an
email](http://docs.aws.amazon.com/aws-sdk-php/v3/api/api-email-2010-12-01.html#sendemail).
Where is a minimalistic example? Where is a slightly more realistic sample?

# Problem 4:

With `$result = $SesClient->sendEmail([` you inline an object. How do you
choose not to have **ReplyToAddresses** because the SDK moans if it's empty!


# Conclusion

Nightmare.
