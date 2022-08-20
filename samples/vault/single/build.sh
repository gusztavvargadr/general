#!/usr/bin/env bash

set -eux

cd `dirname $0`

docker-compose build

docker-compose run --rm config
docker-compose up -d server
sleep 1s
docker-compose run --rm init

docker-compose run --rm cli secrets list

docker-compose run --rm export
