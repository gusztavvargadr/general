#!/usr/bin/env sh

set -o errexit
set -o nounset

export VAULT_VERSION=$1

export DEBIAN_FRONTEND=noninteractive

apt-get update --yes --quiet
apt-get install --yes --quiet wget unzip jq net-tools
apt-get clean
rm --recursive --force /var/lib/apt/lists/*

export VAULT_ZIP_FILE=vault_${VAULT_VERSION}_linux_amd64.zip
export VAULT_BINARY_FILE=vault
export VAULT_DOWNLOAD_URI=https://releases.hashicorp.com/vault/$VAULT_VERSION/$VAULT_ZIP_FILE

if [ ! -f /usr/local/bin/$VAULT_BINARY_FILE ]; then
  wget --quiet $VAULT_DOWNLOAD_URI
  unzip $VAULT_ZIP_FILE
  rm $VAULT_ZIP_FILE
  mv ./$VAULT_BINARY_FILE /usr/local/bin/
fi
