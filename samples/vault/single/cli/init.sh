#!/usr/bin/env sh

set -eu

cd `dirname $0`

cd ./state/

if [ ! -f ./ca.crt ]; then
  cp ../config/ca.crt ./
fi

export VAULT_CAPATH=`pwd`/ca.crt

vault status -format=json | cat > ./status.json
VAULT_INITIALIZED=`jq -r .initialized ./status.json`
VAULT_SEALED=`jq -r .sealed ./status.json`
rm ./status.json

if [ $VAULT_INITIALIZED = "false" ]; then
  vault operator init -key-shares=1 -key-threshold=1 -format=json | cat > ./operator-init.json
fi

if [ $VAULT_SEALED = "true" ]; then
  jq -r .unseal_keys_b64[0] ./operator-init.json | xargs vault operator unseal -format=json | cat > /dev/null
fi

export VAULT_TOKEN=`jq -r .root_token ./operator-init.json`

if [ ! -f ./env.sh ]; then

  cat <<EOF > ./env.sh
#!/usr/bin/env sh

set -eu

cd \`dirname \$0\`

echo export VAULT_ADDR=$VAULT_ADDR
echo export VAULT_TOKEN=$VAULT_TOKEN
echo export VAULT_CAPATH=\`pwd\`/ca.crt
EOF
  chmod +x ./env.sh
fi
