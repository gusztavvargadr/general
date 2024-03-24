#!/usr/bin/env bash

set -uo pipefail

sudo kill $(cat ./artifacts/nomad.pid)
