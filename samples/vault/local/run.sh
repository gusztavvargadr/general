#!/usr/bin/env bash

set -eu

docker compose up -d core-vault
sleep 1s

docker compose run --rm --entrypoint sh core-config ./boot.sh
docker compose run --rm --entrypoint sh core-config ./run.sh
docker compose up -d core-agent
sleep 1s
docker compose exec core-agent sh ./run.sh
