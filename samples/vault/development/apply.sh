#!/usr/bin/env bash

set -uo pipefail

nomad job run ./job.hcl

export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN="root"

vault status
