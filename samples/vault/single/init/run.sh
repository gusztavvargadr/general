#!/usr/bin/env sh

set -eux

cd ./artifacts/cli/

export VAULT_CAPATH=./ca.crt

vault status -format=json | tee ./status.json
export VAULT_INITIALIZED=`jq -r .initialized ./status.json`
export VAULT_SEALED=`jq -r .sealed ./status.json`

if [ $VAULT_INITIALIZED = "false" ]; then
  vault operator init -key-shares=1 -key-threshold=1 -format=json | tee ./operator-init.json
  rm -f ./env.sh
fi

if [ $VAULT_SEALED = "true" ]; then
  jq -r .unseal_keys_b64[0] ./operator-init.json | xargs vault operator unseal -format=json | tee ./operator-unseal.json
fi

export VAULT_TOKEN=`jq -r .root_token ./operator-init.json`

if [ ! -f ./env.sh ]; then
cat <<EOF > ./env.sh
cd \`dirname \$0\`
echo export VAULT_ADDR=$VAULT_ADDR
echo export VAULT_TOKEN=$VAULT_TOKEN
echo export VAULT_CAPATH=\`pwd\`/ca.crt
EOF
fi