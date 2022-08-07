#!/usr/bin/env sh

set -o errexit
set -o nounset

source /vault/init/env.sh

vault $*
