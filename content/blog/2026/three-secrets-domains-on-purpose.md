---
title: "Three Secrets Domains on Purpose"
date: 2026-08-18T13:28:09Z
description: "Why a large org keeps developer, CI and workload secrets in three separate systems — 1Password, GitHub secrets and AWS — and how short-lived credentials and least privilege hold it together."
---

<div style="overflow-x:auto;margin:2rem calc(50% - 50vw) 2.5rem;width:100vw;padding:0 1rem;box-sizing:border-box">
<svg viewBox="0 0 1880 950" role="img" aria-label="Three secrets domains across the SDLC, using the Stripe keys as a worked example" style="width:100%;min-width:1000px;height:auto;font-family:system-ui,-apple-system,sans-serif">
  <defs>
    <marker id="ab" markerWidth="9" markerHeight="9" refX="8" refY="3" orient="auto"><path d="M0,0 L8,3 L0,6 z" fill="#4dabf7"/></marker>
    <marker id="ag" markerWidth="9" markerHeight="9" refX="8" refY="3" orient="auto"><path d="M0,0 L8,3 L0,6 z" fill="#51cf66"/></marker>
    <marker id="an" markerWidth="9" markerHeight="9" refX="8" refY="3" orient="auto"><path d="M0,0 L8,3 L0,6 z" fill="#909296"/></marker>
  </defs>

  <g font-size="16" font-weight="600" fill="#7a8590" letter-spacing="1.5">
    <text x="270" y="44">PROVISION</text>
    <text x="600" y="44">STORE</text>
    <text x="930" y="44">DEVELOP</text>
    <text x="1260" y="44">BUILD &amp; DEPLOY</text>
    <text x="1590" y="44">RUN</text>
  </g>

  <g fill="#ffffff08" stroke="#ffffff20" rx="14">
    <rect x="30" y="70" width="1850" height="230" rx="14"/>
    <rect x="30" y="320" width="1850" height="230" rx="14"/>
    <rect x="30" y="570" width="1850" height="350" rx="14"/>
  </g>

  <g font-size="20" font-weight="700" fill="#ced4da">
    <text x="52" y="180">1. Developers</text><text x="52" y="206">1Password</text>
    <text x="52" y="430">2. CI</text><text x="52" y="456">GitHub</text>
    <text x="52" y="735">3. Workloads</text><text x="52" y="761">AWS</text>
  </g>

  <g stroke-width="2" rx="10">
    <rect x="270" y="140" width="250" height="100" rx="10" fill="#e6498026" stroke="#f06595"/>
    <rect x="600" y="140" width="250" height="100" rx="10" fill="#7950f226" stroke="#9775fa"/>
    <rect x="930" y="140" width="250" height="100" rx="10" fill="#15aabf26" stroke="#3bc9db"/>
    <rect x="930" y="390" width="250" height="100" rx="10" fill="#86909626" stroke="#909296"/>
    <rect x="1260" y="390" width="250" height="100" rx="10" fill="#228be626" stroke="#4dabf7"/>
    <rect x="270" y="630" width="250" height="100" rx="10" fill="#e6498026" stroke="#f06595"/>
    <rect x="600" y="630" width="250" height="100" rx="10" fill="#fd7e1426" stroke="#ff922b"/>
    <rect x="1260" y="630" width="250" height="100" rx="10" fill="#228be626" stroke="#4dabf7"/>
    <rect x="1590" y="630" width="250" height="100" rx="10" fill="#228be626" stroke="#4dabf7"/>
    <rect x="600" y="780" width="250" height="100" rx="10" fill="#40c05726" stroke="#51cf66"/>
  </g>

  <g font-size="18" fill="#e9ecef" text-anchor="middle">
    <text x="395" y="183">Stripe dashboard</text><text x="395" y="207">test mode → sk_test_</text>
    <text x="725" y="183">1Password Engineering</text><text x="725" y="207">item: stripe-test</text>
    <text x="1055" y="183">Developer laptop</text><text x="1055" y="207">op run --env-file</text>
    <text x="1055" y="433">.envrc in git</text><text x="1055" y="457">op:// refs, no values</text>
    <text x="1385" y="433">GitHub Actions</text><text x="1385" y="457">stripe-mock, no key</text>
    <text x="395" y="659">Stripe dashboard</text><text x="395" y="683">live mode → rk_live_</text><text x="395" y="707">value shown once</text>
    <text x="725" y="673">Service owner</text><text x="725" y="697">drop role: Put, never Get</text>
    <text x="1385" y="673">IAM role gha-deploy</text><text x="1385" y="697">scoped to one ref</text>
    <text x="1715" y="673">ECS task payments</text><text x="1715" y="697">role via IMDS</text>
    <text x="725" y="823">Secrets Manager</text><text x="725" y="847">prod/payments/stripe</text>
  </g>

  <g font-size="17" fill="#7a8590">
    <text x="1260" y="168">Test mode only.</text><text x="1260" y="192">No live key ever</text><text x="1260" y="216">enters 1Password.</text>
    <text x="1590" y="430">GitHub secrets never</text><text x="1590" y="454">hold the Stripe key.</text>
    <text x="930" y="670">No human read path.</text><text x="930" y="694">KMS-gated, alerted.</text>
  </g>

  <g fill="none" stroke-width="2">
    <path d="M520,190 H592" stroke="#4dabf7" marker-end="url(#ab)"/>
    <path d="M850,190 H922" stroke="#4dabf7" marker-end="url(#ab)"/>
    <path d="M1055,240 V382" stroke="#909296" marker-end="url(#an)"/>
    <path d="M1180,440 H1252" stroke="#909296" marker-end="url(#an)"/>
    <path d="M1385,490 V622" stroke="#51cf66" marker-end="url(#ag)"/>
    <path d="M1510,680 H1582" stroke="#51cf66" marker-end="url(#ag)"/>
    <path d="M520,680 H592" stroke="#4dabf7" marker-end="url(#ab)"/>
    <path d="M725,730 V772" stroke="#4dabf7" marker-end="url(#ab)"/>
    <path d="M850,830 H1715 V738" stroke="#51cf66" marker-end="url(#ag)"/>
  </g>

  <g font-size="15" text-anchor="middle">
    <text x="886" y="178" fill="#4dabf7">op://</text>
    <text x="1096" y="316" fill="#909296" text-anchor="start">commit</text>
    <text x="1216" y="430" fill="#909296">push</text>
    <text x="1426" y="562" fill="#51cf66" text-anchor="start">OIDC</text>
    <text x="1546" y="668" fill="#51cf66">deploy</text>
    <text x="1290" y="818" fill="#51cf66">read at startup</text>
  </g>
</svg>
</div>

A recurring question in security engineering review: *"can't we just have one place
for secrets?"*

No. In a large org there are three domains, and the separation is deliberate:

1. **Developers** — 1Password
2. **CI** — GitHub secrets
3. **Workloads** — AWS

They have different threat models, different blast radii, and different people
holding the keys. Collapsing them into one vault means the laptop that gets
stolen is also the thing that can deploy to production.

## 1. Developers: 1Password with `op://` references

A developer needs credentials on their laptop. What they must *not* do is paste
them into a `.env` file that lives on disk forever, gets `cat`'d into a Slack
thread, and eventually lands in a git commit.

Use references, not values. With [direnv](https://direnv.net/) and the 1Password
CLI, `.envrc` holds a pointer:

```bash
# .envrc — safe to commit
export STRIPE_API_KEY="op://Engineering/stripe-test/credential"
export DATABASE_URL="op://Engineering/dev-db/connection-string"
```

Then wrap the command rather than exporting into your shell:

```bash
op run --env-file .envrc -- ./myapp
```

The secret exists only in the process environment, for the lifetime of the
process. There is nothing on disk to leak, and `.envrc` is reviewable in a pull
request because it contains no secret material — only the name of one.

Two things follow from this that people miss:

- **`op run` masks secrets in stdout.** It's not perfect, but it stops the
  obvious `echo $STRIPE_API_KEY` accident from reaching a CI log.
- **Access is revocable per-person.** Someone leaves, you remove them from the
  Engineering vault, done. You do not rotate the secret. Compare that to a
  shared `.env` on twelve laptops, where the only correct response to a
  departure is rotating everything.

The 1Password vault is for **human** access to **non-production** systems. If a
developer needs a production secret, that is a separate conversation with a
separate approval, and usually the answer is that they need a break-glass role,
not a secret.

## 2. CI: GitHub secrets, and preferably not secrets at all

GitHub Actions needs credentials to build, test and deploy. The instinct is to
paste an AWS access key into repository secrets. Don't.

Use [OIDC](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services).
GitHub mints a short-lived JWT, AWS trusts it, and the job assumes a role. No
long-lived key exists anywhere:

```yaml
permissions:
  id-token: write
  contents: read

steps:
  - uses: aws-actions/configure-aws-credentials@v5
    with:
      role-to-assume: arn:aws:iam::111122223333:role/gha-deploy
      aws-region: eu-west-2
```

The trust policy is where the least-privilege work actually happens. This is the
common mistake:

```json
"StringLike": {
  "token.actions.githubusercontent.com:sub": "repo:myorg/*"
}
```

That lets *any* workflow in *any* repo in the org assume the deploy role,
including a fork's pull request build. Scope it to the repo **and** the ref:

```json
"StringEquals": {
  "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
  "token.actions.githubusercontent.com:sub": "repo:myorg/myrepo:ref:refs/heads/main"
}
```

Better still, scope it to a GitHub **environment**
(`repo:myorg/myrepo:environment:production`) so that deployment requires a
required reviewer to approve before the token is ever minted.

What legitimately stays in GitHub secrets: third-party tokens with no OIDC
story. Signing keys, npm publish tokens, a vendor API key. Keep the list short
and audit it — every entry is a long-lived secret that a workflow change can
exfiltrate.

## 3. Workloads: AWS, where the app never sees a credential

Running code should not read secrets from a file or an environment variable it
inherited from a deploy pipeline. It should ask AWS at runtime, using an
identity AWS already assigned it.

For AWS services — S3, DynamoDB, SQS — there is no secret at all. The task role
or instance profile *is* the credential, rotated automatically by the metadata
service:

```python
import boto3
# No keys. The role is attached to the task.
s3 = boto3.client("s3")
```

For things AWS doesn't own — a Stripe key, a database password — use Secrets
Manager, and read it at startup:

```python
import boto3, json

sm = boto3.client("secretsmanager")
secret = json.loads(
    sm.get_secret_value(SecretId="prod/payments/stripe")["SecretString"]
)
```

The IAM policy is the interesting part, and it should name the specific secret:

```json
{
  "Effect": "Allow",
  "Action": "secretsmanager:GetSecretValue",
  "Resource": "arn:aws:secretsmanager:eu-west-2:111122223333:secret:prod/payments/*"
}
```

`"Resource": "*"` on `GetSecretValue` means a compromised payments container can
read the HR database password. This is the single most common least-privilege
failure I see, and it is also the easiest to fix.

For RDS, skip the password entirely — use
[IAM database authentication](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html)
and generate a token that expires in 15 minutes.

## Worked example: the Stripe keys

Abstractions are easy to nod along to, so here is the whole thing for one real credential.

### It isn't one key

| Credential | Secret? | Where it lives |
| --- | --- | --- |
| `pk_test_` / `pk_live_` publishable | No | In the code, shipped to the browser |
| `sk_test_` / `rk_test_` | Yes, low value | 1Password, and the dev account |
| `rk_live_` restricted | **Yes, high value** | Prod Secrets Manager only |
| `whsec_` webhook signing | Yes | With the matching mode's key |

The test/live split is what makes "who stores it where" answerable — they are different secrets with different blast radii, so they get different homes. Conflating them is exactly how live keys end up in a shared vault.

Note `rk_live_` rather than `sk_live_`. Stripe restricted keys are Stripe's own least-privilege mechanism: scope one to `charges:write` and it cannot issue refunds. Do that first, because it is a tighter control than anything you write in IAM.

### Test mode: the team stores it in 1Password

Anyone on the payments team can do this. It is a sandbox credential — treat it as a convenience, not a crown jewel.

```bash
op item create --category "API Credential" --vault Engineering \
  --title stripe-test \
  credential="sk_test_..." \
  'notesPlain=Test mode only. Live keys are in Secrets Manager, not here.'
```

That note matters more than it looks. It is what stops someone six months from now from "helpfully" filing the live key next to it.

### Live mode: nobody stores it in 1Password

The service owner does this — the person accountable for payments, with Stripe live-mode admin. Not SecEng, not platform, not whoever is on call. Ideally two of them together, because the value is on screen exactly once.

Infrastructure defines the container, never the value:

```hcl
resource "aws_secretsmanager_secret" "stripe" {
  name       = "prod/payments/stripe"
  kms_key_id = aws_kms_key.payments.arn
}

resource "aws_secretsmanager_secret_version" "stripe" {
  secret_id     = aws_secretsmanager_secret.stripe.id
  secret_string = "PLACEHOLDER"
  lifecycle { ignore_changes = [secret_string] }
}
```

`ignore_changes` is not a style preference. Terraform state stores values in plaintext, and state lives in a bucket with a far wider reader list than the secret does. Put the key in the `.tf` and it is now in state, in every plan output, and in your CI logs.

The human drops the value in separately:

```bash
aws secretsmanager put-secret-value \
  --secret-id prod/payments/stripe \
  --secret-string file:///dev/stdin
```

Paste, Ctrl-D. Via `file://` rather than as an argument, so it never lands in shell history or in `ps` output on a shared box.

### The important part: whoever writes it cannot read it

The role that operator assumes is write-only:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DropOnly",
      "Effect": "Allow",
      "Action": [
        "secretsmanager:PutSecretValue",
        "secretsmanager:UpdateSecretVersionStage"
      ],
      "Resource": "arn:aws:secretsmanager:eu-west-2:111122223333:secret:prod/payments/stripe-*"
    },
    {
      "Sid": "NeverRead",
      "Effect": "Deny",
      "Action": "secretsmanager:GetSecretValue",
      "Resource": "*"
    }
  ]
}
```

Two details people get wrong here. The trailing `-*`: Secrets Manager appends six random characters to the ARN, so an exact-match ARN silently matches nothing. And the explicit `Deny`, which beats any `Allow` the operator picks up from some other attached policy.

Then layer KMS on top. The customer-managed key's policy grants `kms:Decrypt` only to the ECS task role, so reading the secret needs `GetSecretValue` **and** a KMS grant. An over-broad IAM policy on its own is no longer enough to leak it.

### CI never touches it

This is the part that surprises people: GitHub secrets do not appear in this scenario at all.

Unit tests use `stripe-mock`. Integration tests that genuinely need test mode assume a role via OIDC and read the test key from the dev account. The value is never pasted into repository secrets, so a malicious workflow change cannot exfiltrate what the runner was never given.

### Rotation, honestly

Stripe has no public API for minting API keys — you create them in the dashboard. A fully automatic Secrets Manager rotation Lambda is therefore not achievable here, and pretending otherwise gets you a rotation config that silently fails.

What works: Stripe lets you roll a key with a grace period, so the old one keeps working for up to 24 hours. Create the new key, `put-secret-value`, confirm the workload picked it up, revoke the old one. Semi-manual, a few times a year, every step auditable.

### Who holds what

| | Test key | Live key |
| --- | --- | --- |
| Created by | Any team member | Service owner, two-person |
| Stored in | 1Password Engineering vault | Prod Secrets Manager, one copy |
| Also in | Dev account Secrets Manager | Nowhere else |
| Readable by humans | Yes, the team | No — break-glass, alerted |
| Read at runtime by | Dev task role | `payments` task role, KMS-gated |
| In GitHub secrets | Never | Never |

The test key deliberately exists in two places, and that is fine: two copies of a sandbox credential handed to two different identity domains. The live key exists in exactly one place, and no human is on its read path.

## Short-lived credentials

Notice the pattern in all three domains. Nothing long-lived is issued to anything:

| Domain | Identity | Lifetime |
| --- | --- | --- |
| Developer | SSO session → `aws sso login` | Hours |
| CI | GitHub OIDC token → assumed role | Minutes |
| Workload | Task role via IMDS/container credentials | Auto-rotated |

A leaked credential with a one-hour TTL is an incident. A leaked IAM access key
with no expiry is a breach that lasts until someone notices — and the industry
average for noticing is measured in months.

The practical test for any secrets design: **if this value appeared in a public
gist right now, how long would it be useful to an attacker?** If the answer is
"forever", it is the wrong shape of credential and no amount of vaulting fixes
that.

Corollary: stop rotating long-lived keys on a 90-day schedule and calling it
security. Rotation is a mitigation for credentials that should not exist.

## Principle of least privilege, in practice

Least privilege is easy to agree with and hard to implement, because the honest
version requires you to know what your application actually does. Some things
that make it tractable:

**Start from deny.** Write the policy with no permissions, deploy to staging,
read the `AccessDenied` errors, add exactly those actions. Painful for an
afternoon, correct forever.

**Use IAM Access Analyzer.** It generates a policy from CloudTrail history for a
role. It is not a substitute for thinking, but it's a much better starting point
than `PowerUserAccess`.

**Separate accounts, not just separate roles.** An AWS account is the strongest
isolation boundary AWS offers. Production and development in the same account
means an IAM mistake is a production incident.

**Permission boundaries** stop a developer with `iam:CreateRole` from creating a
role more privileged than their own — which is otherwise a trivial privilege
escalation path and is why handing out `IAMFullAccess` is effectively handing
out admin.

**Make the audit real.** Alert on `GetSecretValue` calls from principals that
don't normally make them. A policy nobody checks is a document, not a control.

## Why three, not one

| | Developers | CI | Workloads |
| --- | --- | --- | --- |
| Who holds it | Humans | Automation, human-triggered | Machines only |
| Access via | 1Password + SSO | OIDC → assumed role | Task role / Secrets Manager |
| Blast radius | One laptop | One repository, one branch | One service |
| Revocation | Remove from vault | Remove from trust policy | Detach role |
| Audit trail | 1Password activity log | Workflow run + CloudTrail | CloudTrail |

Three domains means three separate compromises are required to get from a
phished developer to production data. One unified vault means one.

The friction is the feature. When someone asks why they can't just put the
production database password in the shared vault, that friction is the control
working exactly as designed.
