#!/usr/bin/env bash

set -euo pipefail

if ! [ -x "$(command -v jq)" ]; then
  sudo apt-get -y update && sudo apt-get -y install wget gpg coreutils jq
fi

if ! [ -x "$(command -v consul-template)" ]; then
  wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

  sudo apt-get -y update && sudo apt-get -y install vault consul nomad consul-template
fi
