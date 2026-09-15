#!/usr/bin/env bash
set -euo pipefail

# Applies the governance baseline to a subscription.
# Usage: ./apply-governance.sh <subscription-id>

SUBSCRIPTION_ID="${1:?Usage: $0 <subscription-id>}"
SCOPE="/subscriptions/${SUBSCRIPTION_ID}"

echo "Applying governance baseline to ${SCOPE}"

# Custom role: VM Operator
sed "s|00000000-0000-0000-0000-000000000000|${SUBSCRIPTION_ID}|g" \
  roles/vm-operator.json > /tmp/vm-operator.json
az role definition create --role-definition /tmp/vm-operator.json

# Policy assignment: require an owner tag on resource groups
az policy assignment create \
  --name require-owner-tag \
  --display-name "Require owner tag on resource groups" \
  --policy 96670d01-0a4d-4649-9c89-2d3abc0a5025 \
  --scope "${SCOPE}" \
  --params '{"tagName":{"value":"owner"}}'

echo "Done."