#!/usr/bin/env bash

set -eu

docker compose exec client-agent consul members
