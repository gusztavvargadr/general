server = false
retry_join = [ "core-agent" ]
datacenter = "{{ with secret "/secret/consul/core" }}{{ .Data.data.datacenter }}{{end}}"

data_dir = "{{ with secret "/secret/consul/core" }}{{ .Data.data.data_dir }}{{end}}"

bind_addr   = "{{ `{{ GetAllInterfaces | include \"name\" \"eth\" | sort \"-name\" | limit 1 | attr \"address\" }}` }}"
client_addr = "127.0.0.1"

encrypt = "{{ with secret "/secret/consul/gossip" }}{{ .Data.data.key }}{{end}}"

acl {
  enabled                  = true
  default_policy           = "deny"
  enable_token_persistence = true

  tokens {
    agent = "{{ with secret "/secret/consul/acl" }}{{ .Data.data.agent_agent_token }}{{end}}"
    default = "{{ with secret "/secret/consul/acl" }}{{ .Data.data.agent_default_token }}{{end}}"
  }
}

{{ with secret "/secret/consul/tls/defaults" }}{{ .Data.data.ca_cert | base64Decode | writeToFile "./config/certs/ca-cert.pem" "" "" "0644" }}{{end}}

tls {
  defaults {
    verify_incoming = true
    verify_outgoing = true
    ca_file         = "{{ with secret "/secret/consul/core" }}{{ printf "%scerts/ca-cert.pem" .Data.data.config_dir }}{{end}}"
  }

  internal_rpc {
    verify_server_hostname = true
  }
}

auto_encrypt {
  tls = true
}
