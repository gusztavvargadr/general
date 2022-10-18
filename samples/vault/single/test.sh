#!/usr/bin/env bash

set -euxo pipefail

cd `dirname $0`

docker compose run --rm cli vault token lookup
docker compose run --rm cli vault secrets list
