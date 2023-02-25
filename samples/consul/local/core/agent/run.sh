#!/usr/bin/env sh

set -eu

CONSUL_ACL_BOOTSTRAP_TOKEN=$(consul acl bootstrap -format=json | jq -r .SecretID)
CONSUL_ACL_AGENT_TOKEN_AGENT=$CONSUL_ACL_BOOTSTRAP_TOKEN
CONSUL_ACL_AGENT_TOKEN_DEFAULT=$CONSUL_ACL_BOOTSTRAP_TOKEN

export CONSUL_HTTP_TOKEN=$CONSUL_ACL_BOOTSTRAP_TOKEN
consul acl set-agent-token agent $CONSUL_ACL_AGENT_TOKEN_AGENT
consul acl set-agent-token default $CONSUL_ACL_AGENT_TOKEN_DEFAULT

vault kv put -mount=secret /consul/acl \
  bootstrap_token=$CONSUL_ACL_BOOTSTRAP_TOKEN \
  agent_token_agent=$CONSUL_ACL_AGENT_TOKEN_AGENT \
  agent_token_default=$CONSUL_ACL_AGENT_TOKEN_DEFAULT
