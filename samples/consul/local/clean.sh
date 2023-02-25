#!/usr/bin/env bash

set -eu

docker container prune -f
docker image prune -f

docker compose down --rmi all --volumes
docker volume prune --filter all=true -f

docker builder prune -af

# docker network prune -f

# sudo rm -Rf ./artifacts/
# git clean -ndX
