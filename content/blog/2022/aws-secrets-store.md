---
title: AWS Secrets Manager or AWS Systems Manager Parameter Store?
date: 2022-03-25T14:22:21+08:00
description: AWS Secrets Manager is actually for databases
---

When choosing a secrets manager, AWS offers two products:

1. https://aws.amazon.com/secrets-manager/
2. https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html

It's easy to choose [Secrets Manager](https://aws.amazon.com/secrets-manager/)
with it's attractive features like "Rotate passwords automatically". Unless you are using **Secrets Manager
with a database, secrets manager is probably the wrong choice!**

# Secrets Manager is for databases

<img src="https://s.natalian.org/2022-03-25/database.png" alt="Secrets for database">

Secrets Manager is designed for facilitating secure access to databases, and you can see this
by their **Store a new secret** wizard.

# Secrets Manager collects more than one secret

Typically a **Secret name** `/dev/my/app` becomes a large JSON file of secret values when you **Retrieve secret value**.

You should create a **Secret name** for different secrets, but the AWS
console's user interface (mistakenly) encourages you to add secrets on `/dev/my/app`
values. This is because **Secrets Manager** is designed for databases!

    {
      "hostname": "db.example.com",
      "username": "larry",
      "password": "kensentme",
      "port": 3306
    }

**Secrets manager has an automatic history** that not many people realise!

    aws secretsmanager get-secret-value --secret-id secrets-for-func --version-stage AWSPREVIOUS

If you mistakenly put a secret in the **wrong Secret name**, it's painful to fix!!

Secrets Manager has features that set it apart from parameter store, like the
ability for secrets can be generated upon created (in Cloudformation), hence
not visible even for the creator. These random strings are typically used for
setting up <abbr title="Amazon Relational Database Service">RDS</abbr>.

Despite Secrets Manager being great with RDS, you probably should be using an [RDS IAM Role](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAM.html) (if your DB supports it) to access your database nonetheless!

# Use parameter store secure strings

1. This is best practice for storing secrets.
2. It can also keep public values, which is useful operationally.
3. Encourages granular access.
4. Use the description field to describe where that secret comes from! (Instead of stuffing the secret into a Secrets Manager JSON)
5. Strings are versioned / auditable.
6. Secrets cost money, parameters do not. But parameters are throttled.

Trivial to access from the CLI

    #!/bin/bash
    if test "$1"
    then
    	aws ssm get-parameters --names $1 --with-decryption --query Parameters[0].Value --output text
    else
    	aws ssm describe-parameters
    fi

# Conclusion

Secrets Manager has attractive features like cross region replication and the
ability to share secrets with other accounts, but it's most likely the wrong
choice for you.

Use parameter store secure strings for storing secrets. And [programmatically access them without using environment variables please!](/blog/2022/env-secrets/)
