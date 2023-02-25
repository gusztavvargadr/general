server = false
retry_join = [ "server-agent" ]

data_dir = "/consul/data/"
datacenter = "local"
client_addr = "127.0.0.1"

encrypt = "{{ with secret "/secret/consul/gossip" }}{{ .Data.data.key }}{{end}}"

tls {
  defaults {
    verify_incoming = true
    verify_outgoing = true
    ca_file         = "/consul/config/certs/ca-cert.pem"
  }

  internal_rpc {
    verify_server_hostname = true
  }
}

{{ with secret "/secret/consul/tls" }}{{ .Data.data.ca_cert | base64Decode | writeToFile "/tmp/consul/config/certs/ca-cert.pem" "" "" "0644" }}{{end}}

auto_encrypt {
  tls = true
}

acl {
  enabled                  = true
  default_policy           = "deny"
  enable_token_persistence = true

  tokens {
    agent = "{{ with secret "/secret/consul/acl" }}{{ .Data.data.agent_token_agent }}{{end}}"
    default = "{{ with secret "/secret/consul/acl" }}{{ .Data.data.agent_token_default }}{{end}}"
  }
}
