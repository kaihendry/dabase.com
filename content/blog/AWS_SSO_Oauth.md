---
title: AWS SSO versus Oauth
date: 2020-06-22T14:38:33+08:00
description: SSO and Oauth2 are same same... but different
---

> This is a reproduction of an AWS Support response. I use [AWS support in my
> own
personal account for ~29USD a
month](https://aws.amazon.com/premiumsupport/pricing/). They're awesome and I
did get permission to reproduce their response to my SSO versus Oauth2
questions below:

From your correspondence you mentioned that you would like to create a Web
Application that authenticates against https://webc.awsapps.com/start . You
state that you are not sure of how it fits with Cognito or OAuth2. You shared
the link
https://www.reddit.com/r/aws/comments/h01n75/single_sign_on_start_questions/ftqpnpi
to provide a context to your query. You are also seeking clarification as to
why Amazon Cognito is not supported as in this link
https://docs.aws.amazon.com/singlesignon/latest/userguide/supported-idps.html

There are several issues that are parked into your query. To address the issues
you have raised, I will first define [Single
Sign-On](https://en.wikipedia.org/wiki/Single_sign-on) as a concept followed
brief definitions of OAuth and SAML. I will then give a brief overview of AWS
<abbr title="Single sign-on">SSO</abbr> and AWS Cognito and lastly give a
recommendation on the application that you would like to create.

## What is SSO?

Single sign-on (SSO) provides the procedures needed to guarantee that a user,
after performing a single authentication, can access multiple systems. For this
to take place, the SSO system must communicate with every external app to tell
them that the user is signed in — which is where <abbr title="Security
Assertion Markup Language">SAML</abbr> comes into play.

<a href="https://en.wikipedia.org/wiki/SAML_2.0"><abbr title="Security
Assertion Markup Language">SAML</abbr> 2.0</a> is a standard for exchanging
authentication and authorization identities between security domains. SAML 2.0
uses security tokens containing assertions to pass information about a
principal (usually an end user) between a SAML authority, named an Identity
Provider, and a SAML consumer, named a Service Provider. SAML 2.0 enables
web-based, cross-domain <abbr title="Single sign-on">SSO</abbr>, which helps
reduce the administrative overhead of distributing multiple authentication
tokens to the user.

## <abbr title="Security Assertion Markup Language">SAML</abbr> 2.0 Use Cases

* If your use case involves <abbr title="Single sign-on">SSO</abbr> (when at
  least one actor or partner is an enterprise)
* If your use case involves providing access to a partner or customer application to your portal
* If your use case requires a centralized identity source

## OAuth 2.0

In the traditional client-server authentication model, the client requests an
access-restricted resource (protected resource) on the server by authenticating
with the server using the resource owner's credentials.  In order to provide
third-party applications access to restricted resources, the resource owner
shares its credentials with the third party[3].  This creates several problems
and limitations:

*  Third-party applications are required to store the resource owner's
   credentials for future use, typically a password in clear-text.
*  Servers are required to support password authentication, despite the
   security weaknesses inherent in passwords.
*  Third-party applications gain overly broad access to the resource owner's
   protected resources, leaving resource owners without any ability to restrict
   duration or access to a limited subset of resources.
*  Resource owners cannot revoke access to an individual third party without
   revoking access to all third parties, and must do so by changing the third
   party's password
*  Compromise of any third-party application results in compromise of the
   end-user's password and all of the data protected by that password

The OAuth 2.0 authorization framework enables a third-party application to
obtain limited access to an HTTP service, either on behalf of a resource owner
by orchestrating an approval interaction between the resource owner and the
HTTP service, or by allowing the third-party application to obtain access on
its own behalf[4]. In OAuth, the client requests access to resources controlled
by the resource owner and hosted by the resource server, and is issued a
different set of credentials than those of the resource owner. Instead of using
the resource owner's credentials to access protected resources, the client
obtains an access token -- a string denoting a specific scope, lifetime, and
other access attributes.  Access tokens are issued to third-party clients by an
authorization server with the approval of the resource owner.  The client uses
the access token to access the protected resources hosted by the resource
server.

## OAuth 2.0 Use Cases

*  If your use case involves providing access(temporarily or permanent) to resources (such as accounts, pictures, files etc.)
*  If your use case involves mobile devices– then use OAuth (with some form of bearer tokens).

## SAML with OAuth

Since OAuth is only an authoritarian framework, its possible to;
*  Use SAML for authentication.
*  Use SAML token/assertion as the OAuth bearer token in the HTTP bearer header to access protected resources.

## What is AWS SSO?

AWS Single Sign-On is a cloud-based single sign-on (SSO) service that makes it
easy to centrally manage SSO access to all of your AWS accounts and cloud
applications. Specifically, it helps you manage SSO access and user permissions
across all your AWS accounts in AWS Organizations. AWS SSO also helps you
manage access and permissions to commonly used third-party software as a
service (SaaS) applications, AWS SSO-integrated applications as well as custom
applications that support Security Assertion Markup Language (SAML) 2.0. AWS
SSO includes a user portal where your end-users can find and access all their
assigned AWS accounts, cloud applications, and custom applications in one
place[6].

For an overview of Amazon SSO showing the key features of the, the usage
scenarios, authentication process please see this slide[7]

## What is Amazon Cognito?

Amazon Cognito provides authentication, authorization, and user management for
your web and mobile apps. Your users can sign in directly with a user name and
password, or through a third party such as Facebook, Amazon, Google or Apple.
The two main components of Amazon Cognito are user pools and identity pools.
You can use identity pools and user pools separately or together. Amazon
Cognito user pools also support the OAuth 2.0 authorization framework for
authenticating users.

For an overview of Amazon Cognito showing the key features of the, the usage
scenarios, authentication process please see this [Cognito
slide](https://www.slideshare.net/AmazonWebServices/amazon-cognito-deep-dive).

You asked about the <a
href="https://docs.aws.amazon.com/singlesignon/latest/userguide/supported-idps.html">AWS
SSO not supporting Amazon Cognito as an Identity provider</a>. This is because
**AWS Cognito is not a SAML 2.0 Identity provider**.

Your other request was on how create an app that users will access by
authenticating through https://webc.awsapps.com/start . To use this URL means
that you will be using AWS SSO. AWS SSO will be acting as an Identity provider
while your custom application will acting as a service provider.

If this is your use case, to achieve this you will first need to create your
SAML 2.0 compliant application in your language of choice. AWS does not have
any guide for creating SAML 2.0 applications.  After some research I found
Passport-SAML[9] which is an authentication provider for Passport-the Node.js
authentication library. Please note that AWS does not endorse nor provide
support for content on third party links and that you will use them at your own
discretion.

After you have created the SAML 2.0 compliant application you can then follow
the [instructions on integration with AWS
SSO](https://docs.aws.amazon.com/singlesignon/latest/userguide/samlapps.html).

If your use case is to create a Web application for users outside (authenticate
by self registration,Facebook or Google) your organisation without need for
interaction with AWS resources, I highly recommend that you use Amazon Cognito
instead of AWS SSO. Amazon Cognito lets you add user sign-up, sign-in, and
access control to your web and mobile apps quickly and easily. Amazon Cognito
scales to millions of users and supports sign-in with social identity
providers, such as Facebook, Google, and Amazon, and enterprise identity
providers via SAML 2.0.

To integrate Amazon Cognito with your web or mobile app, use the SDKs and
libraries that the AWS Amplify framework provides[11].

I hope this information answers your question and is helpful. Otherwise, please
provide me with your specific use case in order for me to be able to help
further.

References
==========

* [1] Single sign-on https://en.wikipedia.org/wiki/Single_sign-on
* [2] SAML 2.0  https://en.wikipedia.org/wiki/SAML_2.0
* [3] The OAuth 2.0 Authorization Protocol https://tools.ietf.org/id/draft-ietf-oauth-v2-12.xml
* [4] OAuth and Federation Overview https://docs.amplify.aws/lib/auth/social/q/platform/js
* [5] Introducing AWS Single Sign-On https://aws.amazon.com/blogs/security/introducing-aws-single-sign-on/
* [6] Deep Dive on AWS Single Sign-On - AWS Online Tech Talks https://www.slideshare.net/AmazonWebServices/deep-dive-on-aws-single-signon-aws-online-tech-talks
* [7] Understanding Amazon Cognito user pool OAuth 2.0 grants https://aws.amazon.com/blogs/mobile/understanding-amazon-cognito-user-pool-oauth-2-0-grants/
* [8] Amazon Cognito Deep Dive https://www.slideshare.net/AmazonWebServices/amazon-cognito-deep-dive
* [9] Passport-SAML http://www.passportjs.org/packages/passport-saml/
* [10] Custom SAML 2.0 Applications https://docs.aws.amazon.com/singlesignon/latest/userguide/samlapps.html
* [11] Integrating Amazon Cognito With Web and Mobile Apps https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-integrate-apps.html
