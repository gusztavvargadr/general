#!/usr/bin/env sh

set -eu

CONSUL_CORE_CONFIG_DIR="/consul/config/"
CONSUL_CORE_DATA_DIR="/consul/data/"
CONSUL_CORE_DATACENTER="local"
vault kv put -mount=secret /consul/core \
  config_dir=$CONSUL_CORE_CONFIG_DIR \
  data_dir=$CONSUL_CORE_DATA_DIR \
  datacenter=$CONSUL_CORE_DATACENTER \

CONSUL_GOSSIP_KEY=$(consul keygen)
vault kv put -mount=secret /consul/gossip \
  key=$CONSUL_GOSSIP_KEY

mkdir -p ./tmp/
cd ./tmp/

consul tls ca create
CONSUL_TLS_CA_CERT=$(base64 -w 0 consul-agent-ca.pem)
CONSUL_TLS_CA_KEY=$(base64 -w 0 consul-agent-ca-key.pem)

consul tls cert create -server -dc $CONSUL_CORE_DATACENTER
CONSUL_TLS_SERVER_CERT=$(base64 -w 0 $CONSUL_CORE_DATACENTER-server-consul-0.pem)
CONSUL_TLS_SERVER_KEY=$(base64 -w 0 $CONSUL_CORE_DATACENTER-server-consul-0-key.pem)

vault kv put -mount=secret /consul/tls \
  ca_cert=$CONSUL_TLS_CA_CERT \
  ca_key=$CONSUL_TLS_CA_KEY \
  server_cert=$CONSUL_TLS_SERVER_CERT \
  server_key=$CONSUL_TLS_SERVER_KEY

cd ..
rm -Rf ./tmp/

consul-template -config templates.hcl -once
chown -R consul:consul ./config/
