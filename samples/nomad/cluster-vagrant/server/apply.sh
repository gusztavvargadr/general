#!/usr/bin/env bash

set -euo pipefail

DIR=$(dirname "$0")
pushd $DIR

ARTIFACTS_DIR="${ARTIFACTS_DIR:-$DIR/../artifacts}"

if [ -z $(pgrep consul) ]; then
  nohup consul agent -dev > /tmp/consul.log 2>&1 &
  sleep 5s
fi

consul kv import @$ARTIFACTS_DIR/kv.json  

KV_PATH=nomad

if [ -z $(pgrep nomad) ]; then
  sudo consul-template -config ./templates.hcl -once
  sudo chown -R nomad:nomad $(consul kv get $KV_PATH/core/config_dir)

  sudo systemctl enable nomad.service
  sudo systemctl start nomad.service
  sleep 15s
fi

source ../core/env.sh

nomad server members
nomad node status
nomad status

NOMAD_SERVERS=$(nomad server members -json | jq -r -c [.[].Addr])
consul kv put $KV_PATH/servers $NOMAD_SERVERS

consul kv export $KV_PATH > $ARTIFACTS_DIR/kv.json

popd
