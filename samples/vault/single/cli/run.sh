#!/usr/bin/env sh

set -eux

cd $VAULT_CLI_PATH

source ./env.sh

vault $*
