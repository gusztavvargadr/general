#!/usr/bin/env bash

KV_PATH=nomad

export NOMAD_ADDR="https://127.0.0.1:4646"
export NOMAD_CAPATH="$(consul kv get $KV_PATH/core/config_dir)/tls/ca-cert.pem"
export NOMAD_TOKEN=$(consul kv get $KV_PATH/acl/bootstrap_token)
