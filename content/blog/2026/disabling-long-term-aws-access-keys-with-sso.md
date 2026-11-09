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

Save the following as `deactivate_iam_access_keys.py`. It requires Python 3 and
AWS CLI v2.

```python
#!/usr/bin/env python3
"""Audit IAM user access keys; deactivate them only with --apply and an SSO role."""

import argparse
from datetime import datetime, timezone
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import time


def now():
    return datetime.now(timezone.utc).isoformat()


class Aws:
    def __init__(self, profile, region):
        self.profile = profile
        self.region = region

    def call(self, *args):
        # AWS CLI automatically paginates list-users and list-access-keys.
        result = subprocess.run(
            ["aws", "--profile", self.profile, "--region", self.region,
             "--output", "json", "--no-cli-pager", *args],
            capture_output=True, text=True, timeout=180,
            env={**os.environ, "AWS_PAGER": "", "AWS_CLI_AUTO_PROMPT": "off"},
        )
        if result.returncode:
            raise RuntimeError(result.stderr.strip() or "AWS CLI failed")
        return json.loads(result.stdout) if result.stdout.strip() else {}


class Evidence:
    def __init__(self, directory):
        self.directory = Path(directory).expanduser()
        # Require a fresh directory so a previous run cannot be overwritten.
        self.directory.mkdir(mode=0o700)

    def save(self, name, value):
        fd = os.open(self.directory / name, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
        with os.fdopen(fd, "w") as handle:
            json.dump(value, handle, indent=2, sort_keys=True)
            handle.write("\n")
            handle.flush()
            os.fsync(handle.fileno())

    def record(self, value):
        fd = os.open(self.directory / "actions.jsonl",
                     os.O_WRONLY | os.O_CREAT | os.O_APPEND, 0o600)
        with os.fdopen(fd, "a") as handle:
            handle.write(json.dumps({"recorded_at": now(), **value}) + "\n")
            handle.flush()
            os.fsync(handle.fileno())


def check_identity(aws, account):
    identity = aws.call("sts", "get-caller-identity")
    if identity.get("Account") != account:
        raise RuntimeError("Wrong AWS account; no keys will be changed")
    pattern = rf"arn:[^:]+:sts::{account}:assumed-role/AWSReservedSSO_[^/]+/[^/]+"
    if not re.fullmatch(pattern, identity.get("Arn", "")):
        raise RuntimeError("An IAM Identity Center (AWSReservedSSO) role session is required")
    return identity


def inventory(aws, account, include_usage=True):
    identity = check_identity(aws, account)
    root_keys = aws.call("iam", "get-account-summary")["SummaryMap"]["AccountAccessKeysPresent"]
    users = aws.call("iam", "list-users")["Users"]
    keys = []
    for user in sorted(users, key=lambda user: user["UserName"]):
        name = user["UserName"]
        for key in aws.call("iam", "list-access-keys", "--user-name", name)["AccessKeyMetadata"]:
            entry = {**key, "UserName": name}
            if include_usage:
                entry["LastUsed"] = aws.call(
                    "iam", "get-access-key-last-used", "--access-key-id", key["AccessKeyId"]
                ).get("AccessKeyLastUsed", {})
            keys.append(entry)
    return {"recorded_at": now(), "account": account, "caller": identity,
            "root_access_keys_present": root_keys, "user_count": len(users), "keys": keys}


def active_keys(snapshot):
    return [key for key in snapshot["keys"] if key["Status"] == "Active"]


def run(aws, account, evidence, apply=False):
    before = inventory(aws, account)
    evidence.save("before.json", before)
    planned = active_keys(before)
    print(f"Account {account}: {before['user_count']} IAM users, "
          f"{len(before['keys'])} keys, {len(planned)} active")
    for key in planned:
        print(f"  {key['UserName']}: …{key['AccessKeyId'][-4:]}")
    if before["root_access_keys_present"]:
        print("Root access keys exist: this script cannot deactivate them.", file=sys.stderr)
    if not apply:
        print("Audit only. Nothing changed. Use --apply with a NEW evidence directory to deactivate.")
        return 0

    # Recheck immediately before the first change; never switch accounts or assume another role.
    check_identity(aws, account)
    failures = []
    for key in planned:
        action = {"user": key["UserName"], "key_id": key["AccessKeyId"], "status": "Inactive"}
        # Persist intent before making a request, including requests interrupted mid-flight.
        evidence.record({**action, "outcome": "requested"})
        try:
            aws.call("iam", "update-access-key", "--user-name", key["UserName"],
                     "--access-key-id", key["AccessKeyId"], "--status", "Inactive")
        except (RuntimeError, subprocess.TimeoutExpired, OSError, ValueError) as error:
            failures.append({**action, "error": str(error)})
            evidence.record({**action, "outcome": "failed", "error": str(error)})
            print(f"FAILED: {key['UserName']} …{key['AccessKeyId'][-4:]}", file=sys.stderr)
        else:
            evidence.record({**action, "outcome": "succeeded"})
            print(f"Deactivated: {key['UserName']} …{key['AccessKeyId'][-4:]}")

    # Re-enumerate every user, including users created since the initial inventory.
    # Retry reads briefly for IAM propagation; do not mutate keys absent from the saved plan.
    for attempt in range(3):
        after = inventory(aws, account, include_usage=False)
        if not active_keys(after) or attempt == 2:
            break
        time.sleep(2)
    evidence.save("after.json", after)
    summary = {"completed_at": now(), "account": account, "planned": len(planned),
               "successful_updates": len(planned) - len(failures), "failures": failures,
               "active_iam_keys_remaining": len(active_keys(after)),
               "root_access_keys_present": after["root_access_keys_present"],
               "sso_verified_after_changes": True}
    evidence.save("summary.json", summary)
    print(f"Verification: {summary['active_iam_keys_remaining']} active IAM keys; SSO works.")
    return int(bool(failures or active_keys(after) or after["root_access_keys_present"]))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--profile", required=True, help="AWS CLI SSO profile")
    parser.add_argument("--account", required=True, help="Expected 12-digit account ID")
    parser.add_argument("--region", default="us-east-1")
    parser.add_argument("--evidence-dir", required=True,
                        help="New private directory, outside any public repository; parent must exist")
    parser.add_argument("--apply", action="store_true", help="Deactivate all active IAM user keys")
    args = parser.parse_args()
    if not re.fullmatch(r"[0-9]{12}", args.account):
        parser.error("--account must be a 12-digit AWS account ID")
    try:
        aws = Aws(args.profile, args.region)
        check_identity(aws, args.account)
        evidence = Evidence(args.evidence_dir)
        return run(aws, args.account, evidence, args.apply)
    except (RuntimeError, subprocess.TimeoutExpired, OSError, ValueError, KeyError) as error:
        print(f"Stopped: {error}\nInspect saved evidence before retrying; changes may be partial.",
              file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
```

Run an audit first, replacing the account ID and profile:

```bash
python3 deactivate_iam_access_keys.py \
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
python3 deactivate_iam_access_keys.py \
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

## Safety tests

Save these beside the script as `test_deactivate_iam_access_keys.py`. They use a
fake AWS client, so running them does not access or change an AWS account.

```python
"""Safety checks for the credential containment script; no live AWS calls."""

import contextlib
import copy
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import deactivate_iam_access_keys as script


ACCOUNT = "111122223333"


class FakeAws:
    def __init__(self):
        self.identity = {"Account": ACCOUNT,
                         "Arn": f"arn:aws:sts::{ACCOUNT}:assumed-role/AWSReservedSSO_Admin_123/alice"}
        self.keys = [{"UserName": "mailer", "AccessKeyId": "ACTIVE", "Status": "Active"},
                     {"UserName": "mailer", "AccessKeyId": "INACTIVE", "Status": "Inactive"}]
        self.root_keys = 0
        self.mutations = []
        self.fail_update = False
        self.fail_inventory = False
        self.add_key_during_update = False

    def call(self, *args):
        operation = args[1]
        if operation == "get-caller-identity":
            return copy.deepcopy(self.identity)
        if operation == "get-account-summary":
            return {"SummaryMap": {"AccountAccessKeysPresent": self.root_keys}}
        if operation == "list-users":
            return {"Users": [{"UserName": "mailer"}]}
        if operation == "list-access-keys":
            if self.fail_inventory:
                raise RuntimeError("Access denied")
            return {"AccessKeyMetadata": copy.deepcopy(self.keys)}
        if operation == "get-access-key-last-used":
            return {}
        if operation == "update-access-key":
            self.mutations.append(args)
            if self.fail_update:
                raise RuntimeError("Access denied")
            assert args[-2:] == ("--status", "Inactive")
            for key in self.keys:
                if key["AccessKeyId"] == args[5]:
                    key["Status"] = "Inactive"
            if self.add_key_during_update:
                self.keys.append({"UserName": "mailer", "AccessKeyId": "NEW", "Status": "Active"})
            return {}
        raise AssertionError(args)


class SafetyTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.path = Path(self.temp.name) / "evidence"
        self.evidence = script.Evidence(self.path)
        self.aws = FakeAws()

    def run_script(self, apply=False):
        with contextlib.redirect_stdout(io.StringIO()), contextlib.redirect_stderr(io.StringIO()), \
                patch.object(script.time, "sleep"):
            return script.run(self.aws, ACCOUNT, self.evidence, apply)

    def test_wrong_account_and_non_sso_refused_before_any_change(self):
        for field, value in [("Account", "999999999999"),
                             ("Arn", f"arn:aws:iam::{ACCOUNT}:user/admin")]:
            with self.subTest(field=field):
                self.aws = FakeAws()
                self.aws.identity[field] = value
                with self.assertRaises(RuntimeError):
                    self.run_script(apply=True)
                self.assertEqual(self.aws.mutations, [])

    def test_incomplete_inventory_cannot_apply(self):
        self.aws.fail_inventory = True
        with self.assertRaises(RuntimeError):
            self.run_script(apply=True)
        self.assertEqual(self.aws.mutations, [])

    def test_default_is_read_only_and_evidence_is_private(self):
        self.assertEqual(self.run_script(), 0)
        self.assertEqual(self.aws.mutations, [])
        self.assertEqual(self.path.stat().st_mode & 0o777, 0o700)
        self.assertEqual((self.path / "before.json").stat().st_mode & 0o777, 0o600)

    def test_only_active_key_changed_and_before_image_preserved(self):
        self.assertEqual(self.run_script(apply=True), 0)
        self.assertEqual(len(self.aws.mutations), 1)
        before = json.loads((self.path / "before.json").read_text())
        after = json.loads((self.path / "after.json").read_text())
        self.assertEqual(len(script.active_keys(before)), 1)
        self.assertEqual(script.active_keys(after), [])
        journal = [json.loads(line) for line in (self.path / "actions.jsonl").read_text().splitlines()]
        self.assertEqual([entry["outcome"] for entry in journal], ["requested", "succeeded"])

    def test_failed_update_is_recorded_and_returns_failure(self):
        self.aws.fail_update = True
        self.assertEqual(self.run_script(apply=True), 1)
        summary = json.loads((self.path / "summary.json").read_text())
        self.assertEqual(summary["successful_updates"], 0)
        self.assertEqual(summary["active_iam_keys_remaining"], 1)
        self.assertEqual(len(summary["failures"]), 1)

    def test_new_key_causes_verification_failure_without_unplanned_mutation(self):
        self.aws.add_key_during_update = True
        self.assertEqual(self.run_script(apply=True), 1)
        self.assertEqual(len(self.aws.mutations), 1)

    def test_existing_evidence_is_never_overwritten(self):
        with self.assertRaises(FileExistsError):
            script.Evidence(self.path)

    def test_root_keys_prevent_claiming_full_success(self):
        self.aws.root_keys = 1
        self.assertEqual(self.run_script(apply=True), 1)


if __name__ == "__main__":
    unittest.main()
```

```bash
python3 -m unittest test_deactivate_iam_access_keys -v
```

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

## Restrict GitHub OIDC to protected main branches

The old trust allowed any branch in any of my repositories. I replaced it with
an explicit list of repositories, each with a protected `main` branch. Both
GitHub OIDC roles now require the `sts.amazonaws.com` audience, `refs/heads/main`,
and matching repository and owner identifiers.

Here is the trust policy for a single repository. Replace the example account,
owner, repository, and numeric GitHub IDs with your own. For multiple
repositories, put their exact subjects and repository IDs in arrays.

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
        "token.actions.githubusercontent.com:sub": "repo:OWNER/REPOSITORY:ref:refs/heads/main",
        "token.actions.githubusercontent.com:ref": "refs/heads/main",
        "token.actions.githubusercontent.com:repository_owner_id": "OWNER_ID",
        "token.actions.githubusercontent.com:repository_id": "REPOSITORY_ID"
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
The branch-specific subject excludes pull-request, tag, and environment subjects.
If a workflow uses an environment, design its exact subject and branch condition
explicitly; do not restore a repository-wide wildcard to make it work.

Two existing deployments used environments. I allowed their exact environment
subjects, retained the separate `ref` condition requiring `main`, and configured
those GitHub environments to accept only protected branches. Their environment
name alone cannot authorize a deployment from another branch.

Branch protection is a separate GitHub control. I enabled protection against
force pushes and deletion, including for administrators, while retaining direct
pushes to `main`. This is compatible with my trunk-based workflow; it does not
require pull requests or reviews. The deployment job also checks the protection
flag before starting:

```yaml
jobs:
  publish:
    if: github.ref == 'refs/heads/main' && github.ref_protected
```

The AWS policy checks the repository and branch, not GitHub's current protection
settings. Keep the allowlist and those settings aligned. GitHub rejected my
attempt to include `ref_protected` in a custom OIDC subject, so I did not use an
unsupported condition or claim that AWS could enforce it directly. For the role
managed by CloudFormation, I also updated the stack's stored template.

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
