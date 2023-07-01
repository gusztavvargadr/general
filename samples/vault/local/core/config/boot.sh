#!/usr/bin/env sh

set -eu

VAULT_CORE_CONFIG_DIR="/vault/config/"
VAULT_CORE_DATA_DIR="/vault/file/"
vault kv put -mount=secret /vault/core \
  config_dir=$VAULT_CORE_CONFIG_DIR \
  data_dir=$VAULT_CORE_DATA_DIR \

VAULT_TLS_CA_CERT=$(cat .https/ca-cert.pem | base64 -w 0)
VAULT_TLS_SERVER_CERT=$(cat .https/server-cert.pem .https/ca-cert.pem | base64 -w 0)
VAULT_TLS_SERVER_KEY=$(cat .https/server-key.pem | base64 -w 0)

vault kv put -mount=secret /vault/tls \
  ca_cert=$VAULT_TLS_CA_CERT \
  server_cert=$VAULT_TLS_SERVER_CERT \
  server_key=$VAULT_TLS_SERVER_KEY
