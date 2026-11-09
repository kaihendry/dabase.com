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
