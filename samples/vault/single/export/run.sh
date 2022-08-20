#!/usr/bin/env sh

set -eux

mkdir -p ./artifacts/cli/
cp -R ${VAULT_CLI_PATH}* ./artifacts/cli/
