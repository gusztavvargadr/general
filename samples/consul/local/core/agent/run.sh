#!/usr/bin/env sh

set -eu

CONSUL_ACL_BOOTSTRAP_TOKEN=$(consul acl bootstrap -format=json | jq -r .SecretID)
export CONSUL_HTTP_TOKEN=$CONSUL_ACL_BOOTSTRAP_TOKEN

consul acl policy create -name agent-agent -rules @policy.agent-agent.hcl
CONSUL_ACL_AGENT_AGENT_TOKEN=$(consul acl token create -policy-name agent-agent -format=json | jq -r .SecretID)
consul acl set-agent-token agent $CONSUL_ACL_AGENT_AGENT_TOKEN

consul acl policy create -name agent-default -rules @policy.agent-default.hcl
CONSUL_ACL_AGENT_DEFAULT_TOKEN=$(consul acl token create -policy-name agent-default -format=json | jq -r .SecretID)
consul acl set-agent-token default $CONSUL_ACL_AGENT_DEFAULT_TOKEN

vault kv put -mount=secret /consul/acl \
  bootstrap_token=$CONSUL_ACL_BOOTSTRAP_TOKEN \
  agent_agent_token=$CONSUL_ACL_AGENT_AGENT_TOKEN \
  agent_default_token=$CONSUL_ACL_AGENT_DEFAULT_TOKEN
