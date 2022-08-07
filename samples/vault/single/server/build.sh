#!/usr/bin/env sh

set -o errexit
set -o nounset

cp ./*.hcl /vault/config/
chown -R vault:vault /vault/config/
chmod -R o-rwx /vault/config/
