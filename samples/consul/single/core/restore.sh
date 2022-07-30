#!/usr/bin/env bash

set -o errexit
set -o nounset

export CONSUL_VERSION=1.12.1

export DEBIAN_FRONTEND=noninteractive

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install consul=$CONSUL_VERSION-1 -y

sudo apt install jq net-tools -y

docker pull library/consul:$CONSUL_VERSION
