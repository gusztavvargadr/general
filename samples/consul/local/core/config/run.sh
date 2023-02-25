#!/usr/bin/env sh

set -eu

CONSUL_GOSSIP_KEY=$(consul keygen)
vault kv put -mount=secret /consul/gossip key=$CONSUL_GOSSIP_KEY

cd /tmp/

consul tls ca create
CONSUL_TLS_CA_CERT=$(base64 -w 0 consul-agent-ca.pem)
CONSUL_TLS_CA_KEY=$(base64 -w 0 consul-agent-ca-key.pem)

consul tls cert create -server -dc local
CONSUL_TLS_SERVER_CERT=$(base64 -w 0 local-server-consul-0.pem)
CONSUL_TLS_SERVER_KEY=$(base64 -w 0 local-server-consul-0-key.pem)

vault kv put -mount=secret /consul/tls \
  ca_cert=$CONSUL_TLS_CA_CERT \
  ca_key=$CONSUL_TLS_CA_KEY \
  server_cert=$CONSUL_TLS_SERVER_CERT \
  server_key=$CONSUL_TLS_SERVER_KEY

cd /

consul-template -config templates.hcl -once
