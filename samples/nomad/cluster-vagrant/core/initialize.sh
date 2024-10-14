#!/usr/bin/env bash

curl -Ls https://gist.github.com/gusztavvargadr/1f0d7dddc7f48549368eaaedf19bfe55/raw/provision.sh | sudo CHEF_POLICY="gusztavvargadr_development" bash -s

sudo apt upgrade -y git jq net-tools
sudo apt autoremove -y
sudo apt clean -y
