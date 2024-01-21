#!/usr/bin/env bash

set -eu

docker compose exec core-agent vault status
