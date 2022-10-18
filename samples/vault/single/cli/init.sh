#!/usr/bin/env sh

set -eux

cd `dirname $0`

cd ./config/

export VAULT_CAPATH=`pwd`/ca.crt

vault status -format=json | tee ./status.json
VAULT_INITIALIZED=`jq -r .initialized ./status.json`
VAULT_SEALED=`jq -r .sealed ./status.json`

if [ $VAULT_INITIALIZED = "false" ]; then
  vault operator init -key-shares=1 -key-threshold=1 -format=json | tee ./operator-init.json
fi

if [ $VAULT_SEALED = "true" ]; then
  jq -r .unseal_keys_b64[0] ./operator-init.json | xargs vault operator unseal -format=json | tee ./operator-unseal.json
fi

export VAULT_TOKEN=`jq -r .root_token ./operator-init.json`

cat <<EOF > ./env.sh
#!/usr/bin/env sh

export VAULT_TOKEN=$VAULT_TOKEN
export VAULT_CAPATH=\`dirname \$0\`/ca.crt

\$*
EOF
chmod +x ./env.sh
