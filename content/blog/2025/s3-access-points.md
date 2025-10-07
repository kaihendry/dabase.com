---
title: AWS S3 Access Points
date: 2025-10-07T11:57:43+01:00
description: Beware of mistakes in Bucket policies
---

Many AWS infrastructure teams rely on S3 bucket policies to police access. Since Bucket policies can easily become complex, AWS offer Amazon S3
Access Points add a second layer of authorization that is easy to overlook.
When those Access Point policies are misconfigured, non-admin users can quietly bypass the
defenses you thought were in place.

This post walks through the controls we expect on an access point, the common
mistakes, and a repeatable way to audit every policy in
your estate.

## Why Access Points Exist

Access points give you named entryways into a bucket. Each access point has:

- Its own DNS alias (for applications and data pipelines)
- A dedicated policy document (separate from the bucket policy)
- Optional prefix-level restrictions

The defence-in-depth pattern we follow looks like this:

- Admins: continue to hit the bucket directly (`s3://bucket-name/`).
- Non-admins: blocked from the bucket, must use an access point.
- Access points: scoped to a single prefix (for example `s3accesslogs/`) and
  locked to a single IAM role.

In theory this cleanly separates admin and application traffic. In practice,
it only works when each access point policy enforces the correct denies.

## What a Compliant Policy Looks Like

Here is a minimal, *correct* deny list for an access point that should be
read-only and limited to the `s3accesslogs/` prefix for a single "audit" role:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Deny everyone except the audit role",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:REGION:ACCOUNT:accesspoint/logs-ap",
        "arn:aws:s3:REGION:ACCOUNT:accesspoint/logs-ap/object/*"
      ],
      "Condition": {
        "StringNotEquals": {
          "aws:PrincipalArn": "arn:aws:iam::ACCOUNT:role/audit-role"
        }
      }
    },
    {
      "Sid": "Deny write actions for the audit role",
      "Effect": "Deny",
      "Principal": {"AWS": "arn:aws:iam::ACCOUNT:role/audit-role"},
      "Action": [
        "s3:AbortMultipartUpload",
        "s3:DeleteObject",
        "s3:DeleteObjectVersion",
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3:PutObjectTagging",
        "s3:PutObjectVersionAcl",
        "s3:PutObjectVersionTagging",
        "s3:RestoreObject"
      ],
      "Resource": "arn:aws:s3:REGION:ACCOUNT:accesspoint/logs-ap/object/*"
    },
    {
      "Sid": "Deny list outside s3accesslogs/",
      "Effect": "Deny",
      "Principal": {"AWS": "arn:aws:iam::ACCOUNT:role/audit-role"},
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:REGION:ACCOUNT:accesspoint/logs-ap",
      "Condition": {
        "StringNotLike": {"s3:prefix": "s3accesslogs/*"}
      }
    },
    {
      "Sid": "Deny reads outside s3accesslogs/",
      "Effect": "Deny",
      "Principal": {"AWS": "arn:aws:iam::ACCOUNT:role/audit-role"},
      "Action": "s3:GetObject",
      "NotResource": "arn:aws:s3:REGION:ACCOUNT:accesspoint/logs-ap/object/s3accesslogs/*"
    }
  ]
}
```

These four denies deliver the required behaviour:

1. Everyone except the intended role is blocked from using the access point at
   all.
2. The allowed role is still read-only.
3. That role cannot list anything outside the `s3accesslogs/` prefix.
4. It also cannot read objects outside the prefix.

Take away any of those statements and the guarantees collapse.

## What Can Go Wrong!

A policy review found access points with only the first deny. The role
could:

- `GET` or `LIST` any key reachable through the access point (no prefix guard).
- Upload or delete data (no write deny).

Because access point policies are independent from the bucket policy, the
misconfiguration slipped through normal checks. IAM role permissions were still
limited, but the access point no longer enforced the isolation we depend on for
logs, audit trails, and other sensitive prefixes.

## Detection: Automate the Review

To make the findings repeatable we wrote [`validate_policy.py`](https://s.natalian.org/2025-10-07/validate_policy.py), a small helper
that flags missing denies and shows the problematic statement alongside the fix.

Usage:

```bash
python3 validate_policy.py policy.json \
  --role arn:aws:iam::123456789012:role/audit-role \
  --prefix s3accesslogs/
```

For each failure, the tool prints the *actual* JSON that was found (in red) and
the *expected* policy snippet (in green). That side-by-side view made it easy to
coach teams through the required changes and prevented regressions.

## Remediation Playbook for SecOps

1. **Inventory access points.** Use AWS Config or `aws s3control` to list every
   access point in scope.
2. **Export the policies.** `aws s3control get-access-point-policy` for each.
3. **Run the validation script.** Feed each policy through the helper with the
   role ARN and expected prefix.
4. **Fix failures quickly.** Copy the green snippet, swap in the real ARN and
   access point name, and update the policy.
5. **Add to CI.** If you treat access point JSON as code, add the script to your
   pipeline so broken policies never ship again.

## Key Takeaways

- Treat S3 access point policies with the same rigor as bucket policies.
- Deny-by-default still applies; every permit must be paired with an explicit
  deny for the opposite case.
- Prefix isolation is not automatic—you have to enforce it.
- Automation is the only practical way to keep dozens (or hundreds) of access
  points aligned with policy.

If your estate already uses access points, grab the validator and run it on the
entire fleet. The output will tell you exactly where your guardrails are missing
and how to fix them.
