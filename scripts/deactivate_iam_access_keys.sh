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
