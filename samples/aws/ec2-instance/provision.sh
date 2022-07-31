#!/bin/bash

set -e

sudo apt update -qq
sudo apt install -qq -y apt-transport-https

wget -qO - https://packages.chef.io/chef.asc | sudo apt-key add -
echo "deb https://packages.chef.io/repos/apt/stable $(lsb_release -cs) main" > chef.list
sudo mv chef.list /etc/apt/sources.list.d/
sudo apt update -qq

sudo apt install -qq -y chef
