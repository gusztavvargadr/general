#!/usr/bin/env bash

set -euxo pipefail

cd `dirname $0`

docker compose down --rmi all --volumes

docker image prune -f
docker builder prune -af

sudo rm -Rf ./**/artifacts/
git clean -ndX
