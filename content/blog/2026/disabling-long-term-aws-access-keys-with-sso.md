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
users and keys, read the account summary, and update key status.
An SSO role's temporary credentials are separate from IAM user access keys, so
deactivating those user keys does not disable the SSO session.

## Audit and deactivate with the AWS CLI

Save this as `deactivate_iam_access_keys.sh`. It uses Bash, AWS CLI v2, and the
standard `awk` command. The default run only lists keys; `--apply` deactivates
them.

```bash
#!/usr/bin/env bash
set -euo pipefail
umask 077

profile=${1:?Usage: $0 PROFILE ACCOUNT [--apply]}
account=${2:?Supply the expected AWS account ID}
mode=${3:---audit}
[[ $# -le 3 && ( $mode == --audit || $mode == --apply ) ]] || exit 1
awscli() { aws --profile "$profile" --no-cli-pager --no-cli-auto-prompt "$@"; }

identity=$(awscli sts get-caller-identity --query '[Account,Arn]' --output text)
IFS=$'\t' read -r actual arn <<< "$identity"
[[ $actual == "$account" && $arn == arn:*:sts::"$account":assumed-role/AWSReservedSSO_*/* ]] || {
  echo "Use an SSO session for account $account." >&2; exit 1;
}
root_keys=$(awscli iam get-account-summary --query SummaryMap.AccountAccessKeysPresent --output text)
[[ $root_keys == 0 ]] || {
  echo "Root access keys exist; handle them separately first." >&2; exit 1;
}

inventory() {
  local users user
  users=$(awscli iam list-users --query 'Users[].UserName' --output text)
  # IAM usernames contain neither whitespace nor wildcard characters.
  for user in $users; do
    awscli iam list-access-keys --user-name "$user" \
      --query 'AccessKeyMetadata[].[UserName,AccessKeyId,Status]' --output text
  done
}

evidence=$(mktemp -d "${TMPDIR:-/tmp}/iam-keys.XXXXXX")
inventory > "$evidence/before.tsv"
printf 'USER\tKEY\tSTATUS\n'
cat "$evidence/before.tsv"
printf 'Inventory saved in %s\n' "$evidence"
[[ $mode == --apply ]] || exit 0

while IFS=$'\t' read -r user key status; do
  if [[ $status == Active ]]; then
    awscli iam update-access-key --user-name "$user" --access-key-id "$key" --status Inactive
    printf '%s\t%s\tInactive\n' "$user" "$key" >> "$evidence/changed.tsv"
  fi
done < "$evidence/before.tsv"

inventory > "$evidence/after.tsv"
awk '$3 == "Active" { exit 1 }' "$evidence/after.tsv" || {
  echo "Active keys remain; inspect $evidence/after.tsv." >&2; exit 1;
}
awscli sts get-caller-identity --output json
printf 'No active IAM user keys remain. Evidence: %s\n' "$evidence"
```

First audit the intended account, replacing the example ID:

```bash
bash deactivate_iam_access_keys.sh mine 111122223333
```

Review the inventory, then apply:

```bash
bash deactivate_iam_access_keys.sh mine 111122223333 --apply
```

The script requires an SSO session in the expected account and stops if root
access keys exist. It inventories all IAM users before changing anything and
only deactivates keys marked `Active`. AWS CLI pagination is left enabled.

[IAM is global within the account](https://docs.aws.amazon.com/IAM/latest/UserGuide/disaster-recovery-resiliency.html),
so there is no region loop: these changes apply across all enabled regions.
Other AWS accounts need separate runs.

**Clients still using these keys will lose access**, including SMTP clients.
[Deactivation changes key status](https://docs.aws.amazon.com/cli/latest/reference/iam/update-access-key.html);
it does not delete keys or users.

Each run creates a private temporary directory. `before.tsv` records the initial
inventory; an apply run also writes successful updates to `changed.tsv` and a
fresh inventory to `after.tsv`. Keep this directory somewhere durable if you
need the evidence. It contains identifiers and statuses, never secret keys.

Any failed AWS command stops the script. Earlier deactivations remain in effect;
inspect the saved files before retrying. The final check fails if active keys
remain. After confirming none remain, it checks the SSO caller again. IAM changes can take a little time to
propagate, so inspect a failed verification before assuming an update failed.

## The result

The management-account cleanup found 17 IAM users and 20 access keys:
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

## Allow every repository, but only main

The old trust allowed any branch in any of my repositories. Both GitHub OIDC
roles now allow all `kaihendry` repositories, including future ones, but require
the `sts.amazonaws.com` audience, `refs/heads/main`, and my immutable GitHub owner
ID. There is no per-repository allowlist to maintain.

Here is the policy. Replace the example AWS account ID, GitHub owner name, and
numeric owner ID with your own. You can find the owner ID with
`gh api users/kaihendry --jq .id`.

```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": {
      "Federated": "arn:aws:iam::111122223333:oidc-provider/token.actions.githubusercontent.com"
    },
    "Action": "sts:AssumeRoleWithWebIdentity",
    "Condition": {
      "StringEquals": {
        "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
        "token.actions.githubusercontent.com:ref": "refs/heads/main",
        "token.actions.githubusercontent.com:repository_owner_id": "765871"
      },
      "StringLike": {
        "token.actions.githubusercontent.com:sub": [
          "repo:kaihendry/*:ref:refs/heads/main",
          "repo:kaihendry/*:environment:*"
        ]
      }
    }
  }]
}
```

Save that as `trust.json`, then apply it to the intended role:

```bash
aws iam update-assume-role-policy \
  --profile mine \
  --role-name YOUR_GITHUB_ACTIONS_ROLE \
  --policy-document file://trust.json
```

[AWS documents these GitHub claim conditions](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_iam-condition-keys.html#condition-keys-wif).
The wildcard applies to repository and environment names. The separate `ref`
condition still requires `main`, including for jobs using GitHub environments.
A feature branch, tag, or pull-request merge ref cannot pass that condition.
The owner ID prevents a different account from gaining access by acquiring the
same username.

**This AWS policy also permits unprotected `main` branches.** Branch protection
is managed separately in GitHub; it is not a condition enforced by this trust.
I accepted that trade-off to keep the AWS configuration simple. Protect `main`
when setting up a repository, including private repositories whose GitHub plan
may limit the available protection features.

The 21 branches protected during this cleanup retain their protection against
force pushes and deletion, including for administrators. Direct pushes remain
allowed, which fits my trunk-based workflow without requiring pull requests or
reviews. The three existing deployment environments also retain their
protected-branch restriction. This site's deployment job additionally checks
the protection flag before starting:

```yaml
jobs:
  publish:
    if: github.ref == 'refs/heads/main' && github.ref_protected
```

GitHub rejected my attempt to include `ref_protected` in a custom OIDC subject,
so I did not use an unsupported condition or claim that AWS could enforce it
directly. For the role managed by CloudFormation, I also updated the stack's
stored template.

## What this does not finish

Disabling keys is one containment step, not a declaration that the account is
secure. It does not remove IAM console passwords or other credential types, and
the OIDC changes do not review every other role's trust or permissions. Neither
change automatically revokes
[temporary sessions already issued from compromised credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_disable-perms.html).
Those need separate investigation and, where necessary, explicit permission
changes or session revocation.

The target remains SSO for people, OIDC for CI, and service roles for workloads.
Those roles also need appropriately limited permissions: restricting who can
assume an administrator role does not reduce what its sessions can do.
