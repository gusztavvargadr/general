#!/usr/bin/env bash

set -euxo pipefail

cd `dirname $0`

docker container prune -f
docker volume prune -f

docker compose down --rmi all --volumes

docker image prune -f
docker builder prune -af

docker network prune -f

sudo rm -Rf ./artifacts/
git clean -ndX
