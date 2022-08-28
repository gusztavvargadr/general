#!/usr/bin/env sh

set -eux

export VAULT_VERSION=$1

export DEBIAN_FRONTEND=noninteractive

apt-get update -y -q
apt-get install -y -q wget unzip jq net-tools
apt-get clean

export VAULT_ZIP_FILE=vault_${VAULT_VERSION}_linux_amd64.zip
export VAULT_BINARY_FILE=vault
export VAULT_DOWNLOAD_URI=https://releases.hashicorp.com/vault/$VAULT_VERSION/$VAULT_ZIP_FILE

if [ ! -f /usr/bin/$VAULT_BINARY_FILE ]; then
  mkdir -p /tmp/vault/
  cd /tmp/vault/
  wget -q $VAULT_DOWNLOAD_URI
  unzip $VAULT_ZIP_FILE
  rm $VAULT_ZIP_FILE
  mv ./$VAULT_BINARY_FILE /usr/bin/
fi
