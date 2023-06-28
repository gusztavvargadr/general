#!/usr/bin/env bash

set -eu

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
# sleep 5s
# docker compose exec core-agent consul leave
