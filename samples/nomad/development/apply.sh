#!/usr/bin/env bash

set -uo pipefail

mkdir -p ./artifacts
sudo nohup nomad agent -dev > ./artifacts/nomad.log 2>&1 &
echo $! > ./artifacts/nomad.pid
sleep 1s

export NOMAD_ADDR="http://127.0.0.1:4646"

nomad status
