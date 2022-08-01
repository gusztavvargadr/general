#!/bin/bash

set -e

apt update -qq
apt install -qq -y apt-transport-https

pushd /tmp
wget -qO - https://packages.chef.io/chef.asc | sudo apt-key add -
echo "deb https://packages.chef.io/repos/apt/stable $(lsb_release -cs) main" > chef.list
mv chef.list /etc/apt/sources.list.d/
apt update -qq
popd

apt install -qq -y chef
