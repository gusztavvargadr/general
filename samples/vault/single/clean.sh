#!/usr/bin/env bash

set -eux

cd `dirname $0`

docker compose down --rmi all -v

docker container prune -f
docker image prune -f
docker builder prune -af

sudo rm -Rf artifacts
