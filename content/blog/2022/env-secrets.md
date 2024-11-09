---
title: Don't put secrets in your ENV
date: 2022-03-25T13:23:06+08:00
description: Secrets as environment variables is a bad idea
---

If you see something like:

     MainFunction:
    	Type: AWS::Serverless::Function
    	Properties:
    	  Environment:
    		Variables:
    		  SECRET_KEY: "{{resolve:ssm:/my/secretkey:1}}"

or perhaps in a `serverless.yml`:

    MyFunction:
        environment:
            PRIVATE_KEY: ${ssm:/my/private_key}

A secret stored as an Environment variable can easily leak!

# Leaked how?

## Accidental disclosure

If your app gets compromised, it's trivial to `printenv` and steal secrets.

Your debug or logging code will likely leak the environment!

Do not store secrets in your `process.env`!

## Operationally

<img src="https://s.natalian.org/2022-03-25/environment-variable-secret.png" alt="AWS lambda console">

More likely your secret will leak to your operations team via the AWS console.

# Workaround

## Retreive secrets in the App

Best practice is for applications to retrieve secrets, for example in a Lambda
context you would use
[middy-ssm](https://github.com/middyjs/middy/tree/main/packages/ssm) to
retrieve the secrets from the AWS Parameter Store.

That application alone will have the role to retrieve the secret with the
appropriate `ssm:GetParameter` permission.

Of course you need to be careful not to log those secret variables.
