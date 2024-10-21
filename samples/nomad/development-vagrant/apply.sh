#!/usr/bin/env bash

set -euo pipefail

DIR=$(dirname "$0")
pushd $DIR

ARTIFACTS_DIR="${ARTIFACTS_DIR:-$DIR/artifacts}"
mkdir -p $ARTIFACTS_DIR

docker compose build

docker compose up -d consul
sleep 5s

nohup nomad agent -dev -config=$DIR/nomad.hcl > $ARTIFACTS_DIR/nomad.log 2>&1 &
sleep 5s

export NOMAD_ADDR="http://127.0.0.1:4646"

nomad server members
nomad node status
nomad status

popd
