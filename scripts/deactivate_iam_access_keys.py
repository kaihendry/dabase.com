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
