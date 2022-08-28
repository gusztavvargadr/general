#!/usr/bin/env bash

set -eux

cd `dirname $0`

sudo apt-get update -q -y
sudo apt-get install -q -y docker-compose-plugin
sudo apt-get clean

docker pull hashicorp/terraform:1.2.7
docker pull library/vault:1.11.2
docker pull library/ubuntu:20.04

sudo bash ./init/build.sh 1.11.2
