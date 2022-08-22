#!/usr/bin/env sh

set -eu

eval `sh ./artifacts/cli/env.sh`

vault $*
