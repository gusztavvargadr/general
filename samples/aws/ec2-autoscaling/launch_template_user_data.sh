#!/usr/bin/env bash

set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update -q -y
apt-get install -q -y curl locales
apt-get clean

locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8

curl -Ls https://omnitruck.chef.io/install.sh | bash -s -- -P chef
