#!/usr/bin/env bash

set -eu

docker compose down --rmi local --volumes

docker builder prune -af
