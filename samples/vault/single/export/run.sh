#!/usr/bin/env sh

set -o errexit
set -o nounset

export VAULT_ADDR_LOCAL=$VAULT_ADDR

source /vault/init/env.sh

echo export VAULT_ADDR=$VAULT_ADDR_LOCAL > /vault/artifacts/env.sh
echo export VAULT_TOKEN=$VAULT_TOKEN >> ./vault/artifacts/env.sh
