#!/usr/bin/env bash

set -o errexit
set -o nounset

mkdir -p ./tmp/

eval `bash ./env.sh`

consul acl bootstrap -format=json | tee ./tmp/acl.json

eval `bash ./env.sh`

consul acl set-agent-token agent $CONSUL_HTTP_TOKEN

consul members

consul acl policy create -name dns-query -rules @../core/policy-dns-query.hcl
consul acl token create -policy-name dns-query -format json | tee ./tmp/policy-dns-query.json
consul acl set-agent-token default `jq -r .SecretID ./tmp/policy-dns-query.json`
