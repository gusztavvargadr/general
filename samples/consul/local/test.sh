#!/usr/bin/env bash

set -eu

bash ./run.sh

docker compose exec core-agent consul members
