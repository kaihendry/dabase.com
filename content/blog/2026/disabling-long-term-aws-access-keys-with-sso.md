---
title: "Disabling long-term AWS access keys with SSO"
date: 2026-11-09T12:12:12Z
description: "An account-scoped AWS CLI script to audit and deactivate IAM access keys, verify SSO access, and explain why SCPs cannot protect an organization's management account."
tags: [security, ci-cd]
---

Amazon SES reported **45,226 emails sent in 24 hours**. I had not sent them.
An old IAM access key used for SES SMTP was the leading suspect. Its last-used
service and region matched the incident, but that alone could not attribute every
message to it.

The immediate job was to disable the management account's long-term access keys
while keeping access through IAM Identity Center (SSO). This did not require moving
any of the account's S3 buckets.

## Why the logs were unhelpful

[SES SMTP sending is not recorded in CloudTrail](https://docs.aws.amazon.com/ses/latest/dg/logging-using-cloudtrail.html).
Sending through the SES API can be recorded as data events, but those need to be
enabled and do not appear in CloudTrail's ordinary event history. An empty search
there was not evidence that nothing had happened.

[SES SMTP credentials are backed by IAM access keys](https://docs.aws.amazon.com/ses/latest/dg/smtp-credentials.html).
Disabling the backing key removes that credential's ability to authenticate. SES
SMTP does not support credentials derived from temporary AWS credentials. To send
without long-term keys, use the SES API from a role, such as a Lambda execution
role or an application role obtained through OIDC.

## Establish SSO access first

I used an existing SSO profile and checked its identity:

```bash
aws sso login --profile mine
aws sts get-caller-identity --profile mine
```

The account must be the intended account, and the ARN should identify the SSO
role, for example:

```text
arn:aws:sts::111122223333:assumed-role/AWSReservedSSO_AdministratorAccess_EXAMPLE/alice
```

The example account ID is a placeholder. The session needs permission to list
users and keys, read key usage and the account summary, and update key status.
An SSO role's temporary credentials are separate from IAM user access keys, so
deactivating those user keys does not disable the SSO session.

## A script that audits before changing anything

The reusable script and safety tests are in the
[dabase.com repository](https://github.com/kaihendry/dabase.com):

- `scripts/deactivate_iam_access_keys.py`
- `scripts/test_deactivate_iam_access_keys.py`

It requires Python 3 and AWS CLI v2. From a checkout of the repository, run an
audit first, replacing the account ID and profile:

```bash
python3 scripts/deactivate_iam_access_keys.py \
  --profile mine \
  --account 111122223333 \
  --evidence-dir /tmp/aws-key-audit
```

The script checks the account ID and requires an `AWSReservedSSO_` role session.
It lists every IAM user and their keys using the CLI's automatic pagination,
including each key's status and last-used metadata. It also checks whether root
access keys exist; it cannot deactivate root keys through this SSO session.

The default run makes no AWS changes. Its evidence directory must be new, and its
parent directory must already exist. The directory has permissions `0700` and
files have `0600`. They contain account and key identifiers, never secret access
keys. Keep them outside a public repository and move them to durable private
storage if using `/tmp`.

Review the inventory, then explicitly apply the change with a different evidence
directory:

```bash
python3 scripts/deactivate_iam_access_keys.py \
  --profile mine \
  --account 111122223333 \
  --evidence-dir /tmp/aws-key-deactivation \
  --apply
```

**Anything still using these keys will lose access**, including SMTP clients.
That is intentional containment during an incident. For a planned migration,
move those clients to roles before applying this account-wide change.

The apply run takes a fresh inventory, saves it, and rechecks the calling identity
before making changes. For each active key it performs the equivalent of:

```bash
aws iam update-access-key \
  --profile mine \
  --user-name USERNAME \
  --access-key-id ACCESS_KEY_ID \
  --status Inactive
```

[Deactivation changes the key's status](https://docs.aws.amazon.com/cli/latest/reference/iam/update-access-key.html);
it does not delete the key or the IAM user. Already inactive keys are left alone.
The script records each attempted update in `actions.jsonl`, then enumerates the
users and keys again and verifies SSO access. `before.json`, `after.json`, and
`summary.json` preserve the result. An update failure, remaining active key, or
root key makes the apply run exit unsuccessfully. Changes made before a failure
remain in effect; inspect the evidence before retrying.

## The result

In my management account, the script found 17 IAM users and 20 access keys:
18 active and two already inactive. All 18 updates succeeded. A fresh inventory
confirmed **zero active IAM access keys**, no root access keys, and working SSO
access. The keys were deactivated rather than deleted, preserving their metadata
for the investigation. The other accounts in the organization were outside this
change.

## Why an SCP does not solve this account

[Service control policies do not restrict an organization's management account](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html).
A policy denying IAM user activity or key creation can be useful for member
accounts, but attaching it to the organization root does not give the management
account the same protection.

Here, the immediate control is to deactivate the keys directly. Preventing their
return requires restricting key creation and reactivation in the management
account's IAM permissions, reducing who has administrative access, and monitoring
credential changes. An administrator who can remove those restrictions can still
undo them. Moving workloads out of the management account is a separate project.

## What this does not finish

Disabling keys is one containment step, not a declaration that the account is
secure. It does not remove IAM console passwords, other credential types, or role
trust relationships. It also does not automatically revoke
[temporary sessions already issued from compromised credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_disable-perms.html).
Those need separate investigation and, where necessary, explicit permission
changes or session revocation.

The target remains SSO for people, OIDC for CI, and service roles for workloads.
For GitHub Actions, [restrict the role trust](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html#id_roles_create_for-idp_oidc-github)
to the intended repositories and `refs/heads/main`, with the `sts.amazonaws.com`
audience. Workflows using GitHub environments need environment protection rules
to enforce the allowed branch. Replacing a permanent key with an overly broad
trust policy leaves a different route into the account.
