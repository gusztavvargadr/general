#!/usr/bin/env bash

set -euo pipefail

DIR=$(dirname "$0")
pushd $DIR

ARTIFACTS_DIR="${ARTIFACTS_DIR:-$DIR/../artifacts}"
mkdir -p $ARTIFACTS_DIR

if [ -z $(pgrep consul) ]; then
  nohup consul agent -dev > /tmp/consul.log 2>&1 &
  sleep 5s
fi

if [ -f $ARTIFACTS_DIR/kv.json ]; then
  consul kv import @$ARTIFACTS_DIR/kv.json
fi

KV_PATH=nomad

if [ -z $(consul kv get -keys $KV_PATH/core) ]; then
  CONFIG_DIR="/etc/nomad.d"
  DATA_DIR="/opt/nomad/data"
  DATACENTER="dc1"

  consul kv put $KV_PATH/core/config_dir $CONFIG_DIR
  consul kv put $KV_PATH/core/data_dir $DATA_DIR
  consul kv put $KV_PATH/core/datacenter $DATACENTER
fi

if [ -z $(consul kv get -keys $KV_PATH/gossip) ]; then
  GOSSIP_KEY=$(nomad operator gossip keyring generate)

  consul kv put $KV_PATH/gossip/key $GOSSIP_KEY
fi

if [ -z $(consul kv get -keys $KV_PATH/tls) ]; then
  pushd $ARTIFACTS_DIR

  nomad tls ca create
  consul kv put $KV_PATH/tls/ca_cert @nomad-agent-ca.pem
  consul kv put $KV_PATH/tls/ca_key @nomad-agent-ca-key.pem

  nomad tls cert create -server
  consul kv put $KV_PATH/tls/server_cert @global-server-nomad.pem
  consul kv put $KV_PATH/tls/server_key @global-server-nomad-key.pem

  nomad tls cert create -client
  consul kv put $KV_PATH/tls/client_cert @global-client-nomad.pem
  consul kv put $KV_PATH/tls/client_key @global-client-nomad-key.pem

  rm -f *.pem
  popd
fi

if [ -z $(pgrep nomad) ]; then
  sudo consul-template -config ./templates.hcl -once
  sudo chown -R nomad:nomad $(consul kv get $KV_PATH/core/config_dir)

  sudo systemctl enable nomad.service
  sudo systemctl start nomad.service
  sleep 15s
fi

export NOMAD_ADDR="https://127.0.0.1:4646"
export NOMAD_CAPATH="$(consul kv get $KV_PATH/core/config_dir)/tls/ca-cert.pem"

if [ -z $(consul kv get -keys $KV_PATH/acl) ]; then
  export NOMAD_TOKEN=$(nomad acl bootstrap -json | jq -r .SecretID)
  consul kv put $KV_PATH/acl/bootstrap_token $NOMAD_TOKEN
fi

source ../core/env.sh

nomad server members
nomad node status
nomad status

NOMAD_SERVERS=$(nomad server members -json | jq -r -c [.[].Addr])
consul kv put $KV_PATH/servers $NOMAD_SERVERS

consul kv export $KV_PATH > $ARTIFACTS_DIR/kv.json

popd
