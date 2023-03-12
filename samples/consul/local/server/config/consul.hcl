server = true
retry_join = [ "core-agent" ]

data_dir = "{{ with secret "/secret/consul/core" }}{{ .Data.data.data_dir }}{{end}}"
datacenter = "{{ with secret "/secret/consul/core" }}{{ .Data.data.datacenter }}{{end}}"

bind_addr   = {{ `"{{ GetAllInterfaces | include \"name\" \"eth\" | sort \"-name\" | limit 1 | attr \"address\" }}"` }}
client_addr = "0.0.0.0"

connect {
  enabled = true
}

ui_config {
  enabled = true
}

encrypt = "{{ with secret "/secret/consul/gossip" }}{{ .Data.data.key }}{{end}}"

tls {
  defaults {
    verify_incoming = true
    verify_outgoing = true
    ca_file         = "{{ with secret "/secret/consul/core" }}{{ printf "%scerts/ca-cert.pem" .Data.data.config_dir }}{{end}}"
    cert_file       = "{{ with secret "/secret/consul/core" }}{{ printf "%scerts/server-cert.pem" .Data.data.config_dir }}{{end}}"
    key_file        = "{{ with secret "/secret/consul/core" }}{{ printf "%scerts/server-key.pem" .Data.data.config_dir }}{{end}}"
  }

  internal_rpc {
    verify_server_hostname = true
  }
}

{{ with secret "/secret/consul/tls" }}{{ .Data.data.ca_cert | base64Decode | writeToFile "./config/certs/ca-cert.pem" "" "" "0644" }}{{end}}
{{ with secret "/secret/consul/tls" }}{{ .Data.data.server_cert | base64Decode | writeToFile "./config/certs/server-cert.pem" "" "" "0644" }}{{end}}
{{ with secret "/secret/consul/tls" }}{{ .Data.data.server_key | base64Decode | writeToFile "./config/certs/server-key.pem" "" "" "0600" }}{{end}}

auto_encrypt {
  allow_tls = true
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
