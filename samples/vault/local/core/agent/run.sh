#!/usr/bin/env sh

set -eu

vault status || true

VAULT_INIT=$(vault operator init -format=json)
echo $VAULT_INIT
VAULT_UNSEAL_KEYS=$(echo $VAULT_INIT | jq -r .unseal_keys_b64)
echo $VAULT_UNSEAL_KEYS
VAULT_ROOT_TOKEN=$(echo $VAULT_INIT | jq -r .root_token)
echo $VAULT_ROOT_TOKEN

export VAULT_ADDR=$CORE_VAULT_ADDR
export VAULT_TOKEN=$CORE_VAULT_TOKEN

vault kv put -mount=secret /vault/init \
  root_token=$VAULT_ROOT_TOKEN \
  unseal_keys="$VAULT_UNSEAL_KEYS"
