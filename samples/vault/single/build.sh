#!/usr/bin/env bash

set -o errexit
set -o nounset

cd `dirname $0`

docker-compose build

docker-compose up -d server
sleep 1s
docker-compose run --rm init

docker-compose run --rm export
