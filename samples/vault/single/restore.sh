#!/usr/bin/env bash

set -euxo pipefail

cd `dirname $0`

docker pull hashicorp/terraform:1.3.2
docker pull library/vault:1.12.0
