#!/usr/bin/env bash

set -euxo pipefail

cd `dirname $0`

docker compose build

docker compose run --rm config

docker compose up -d server
sleep 5s

docker compose run --rm init

docker compose run --rm export
