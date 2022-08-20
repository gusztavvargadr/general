#!/usr/bin/env sh

set -eux

cd $VAULT_CLI_PATH

export VAULT_CAPATH=./ca.crt

mkdir -p ./log/

vault status -format=json | tee ./log/status.json
export VAULT_INITIALIZED=`jq -r .initialized ./log/status.json`
export VAULT_SEALED=`jq -r .sealed ./log/status.json`

if [ $VAULT_INITIALIZED = "false" ]; then
  vault operator init -key-shares=1 -key-threshold=1 -format=json | tee ./log/operator-init.json
  rm -f ./env.sh
fi

if [ $VAULT_SEALED = "true" ]; then
  jq -r .unseal_keys_b64[0] ./log/operator-init.json | xargs vault operator unseal -format=json | tee ./log/operator-unseal.json
fi

export VAULT_TOKEN=`jq -r .root_token ./log/operator-init.json`

if [ ! -f ./env.sh ]; then
  echo export VAULT_ADDR=$VAULT_ADDR > ./env.sh 
  echo export VAULT_TOKEN=$VAULT_TOKEN >> ./env.sh
  echo export VAULT_CAPATH=${VAULT_CLI_PATH}ca.crt >> ./env.sh
fi
