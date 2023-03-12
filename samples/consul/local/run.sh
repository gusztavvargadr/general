#!/usr/bin/env bash

set -eu

bash ./build.sh

docker compose up -d core-vault
sleep 1s

docker compose run --rm --entrypoint sh core-config ./run.sh
docker compose up -d core-agent
sleep 5s
docker compose exec core-agent sh ./run.sh

docker compose run --rm --entrypoint sh server-config ./run.sh
docker compose up -d server-agent

docker compose run --rm --entrypoint sh client-config ./run.sh
docker compose up -d client-agent

# consul members
# consul catalog nodes | grep server | awk '{ print "retry_join = [ \"" $3 "\" ]" }' > ./tmp/join.hcl

# consul acl policy create -name dns-query -rules @./policy-dns-query.hcl
# consul acl token create -policy-name dns-query -format json | tee ./artifacts/token-dns-query.json
# consul acl set-agent-token default $(jq -r .SecretID ./artifacts/token-dns-query.json)
