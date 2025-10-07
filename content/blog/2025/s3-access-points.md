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

AWS’ own examples show that the minimal pattern relies on *allow* statements that scope
both the principal and the resource. Example&nbsp;1 in
[*Configuring IAM policies for using access points*](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-policies.html)
grants a single IAM user access to a prefixed path through an access point, and example&nbsp;3
adds a targeted `s3:ListBucket` allow for the same user. We start from that pattern, then
layer a set of explicit denies as a defence-in-depth backstop. That way, even if the IAM role
later gains broader S3 permissions, the access point still enforces read-only, prefix-scoped
behaviour.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Allow reads through the access point",
      "Effect": "Allow",
      "Principal": {"AWS": "arn:aws:iam::ACCOUNT:role/audit-role"},
      "Action": ["s3:GetObject"],
      "Resource": "arn:aws:s3:REGION:ACCOUNT:accesspoint/logs-ap/object/s3accesslogs/*"
    },
    {
      "Sid": "Allow listing within the prefix",
      "Effect": "Allow",
      "Principal": {"AWS": "arn:aws:iam::ACCOUNT:role/audit-role"},
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:REGION:ACCOUNT:accesspoint/logs-ap",
      "Condition": {"StringLike": {"s3:prefix": "s3accesslogs/*"}}
    },
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

Those final four statements are the “divergence” from the AWS documentation. They shut every
other principal out, deny write-style APIs, and prevent the intended role from listing or
reading outside its prefix. Without them the policy still works, but we lose the extra
assurance that misconfigured IAM permissions can’t punch through the access point.

## What Can Go Wrong!

You might find policies that skipped the prefix scoping in their allow
statements. The `Resource` looked like `.../object/*`, so the role could read or write
anything reachable through the access point. Others granted `s3:*` to `"Principal": "*"`,
which effectively turned the access point into an open door. The deny backstop would have
caught both errors.

Because access point policies are independent from the bucket policy, these mistakes slipped
through normal checks. IAM role permissions were still limited, but the access point no longer
enforced the isolation we depend on for logs, audit trails, and other sensitive prefixes.

## Detection: Automate the Review

To make the findings repeatable we rewrote [`validate_policy.py`](https://s.natalian.org/2025-10-07/validate_policy.py) so that it checks
for the AWS-documented allow patterns *and* the deny overlay. The helper now verifies that:

- only the expected IAM role appears in `Principal`;
- every object `Resource` ends with `/object/<prefix>*`;
- any `s3:ListBucket` allows are gated by an `s3:prefix` condition for that same prefix; and
- the four deny statements above are present and scoped correctly (principal lockdown, write
  guard, list guard, get guard).

Usage:

```bash
python3 validate_policy.py policy.json \
  --role arn:aws:iam::123456789012:role/audit-role \
  --prefix s3accesslogs/
```

For each failure, the tool prints the *actual* JSON that was found (in red) and
the *expected* policy snippet (in green). That side-by-side view makes it easy to
coach teams through the required changes and prevents regressions.

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
- Tight allow statements (principal + resource) do most of the work; we still layer explicit
  denies so the access point stays safe even if IAM permissions drift.
- Prefix isolation is not automatic—you have to enforce it.
- Automation is the only practical way to keep dozens (or hundreds) of access
  points aligned with policy.

If your estate already uses access points, grab the validator and run it on the
entire fleet. The output will tell you exactly where your guardrails are missing
and how to fix them.
