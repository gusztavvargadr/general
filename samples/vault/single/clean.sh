#!/usr/bin/env bash

set -o errexit
set -o nounset

cd `dirname $0`

docker-compose down --rmi all --volumes

docker image prune -f
docker builder prune -af

rm -Rf artifacts
