server = true
bootstrap_expect = 1

data_dir = "/consul/data/"
datacenter = "local"
client_addr = "127.0.0.1"

connect {
  enabled = true
}

encrypt = "{{ with secret "/secret/consul/gossip" }}{{ .Data.data.key }}{{end}}"

tls {
  defaults {
    verify_incoming = true
    verify_outgoing = true
    ca_file         = "/consul/config/certs/ca-cert.pem"
    cert_file       = "/consul/config/certs/server-cert.pem"
    key_file        = "/consul/config/certs/server-key.pem"
  }

  internal_rpc {
    verify_server_hostname = true
  }
}

{{ with secret "/secret/consul/tls" }}{{ .Data.data.ca_cert | base64Decode | writeToFile "/tmp/consul/config/certs/ca-cert.pem" "" "" "0644" }}{{end}}
{{ with secret "/secret/consul/tls" }}{{ .Data.data.server_cert | base64Decode | writeToFile "/tmp/consul/config/certs/server-cert.pem" "" "" "0644" }}{{end}}
{{ with secret "/secret/consul/tls" }}{{ .Data.data.server_key | base64Decode | writeToFile "/tmp/consul/config/certs/server-key.pem" "" "" "0644" }}{{end}}

auto_encrypt {
  allow_tls = true
}

acl {
  enabled                  = true
  default_policy           = "deny"
  enable_token_persistence = true
}
