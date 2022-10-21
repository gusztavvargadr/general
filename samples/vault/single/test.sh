#!/usr/bin/env bash

set -euxo pipefail

cd `dirname $0`

docker compose run --rm cli token lookup

eval `./cli/artifacts/env.sh`
vault token lookup
