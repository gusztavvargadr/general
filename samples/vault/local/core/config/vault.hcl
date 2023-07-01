disable_mlock = true

storage "raft" {
  path = "{{ with secret "/secret/vault/core" }}{{ .Data.data.data_dir }}{{end}}"
}

api_addr     = "https://{{ `{{ GetAllInterfaces | include \"name\" \"eth\" | sort \"-name\" | limit 1 | attr \"address\" }}` }}:8200"
cluster_addr = "https://{{ `{{ GetAllInterfaces | include \"name\" \"eth\" | sort \"-name\" | limit 1 | attr \"address\" }}` }}:8201"

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = true
}

{{ with secret "/secret/vault/tls" }}{{ .Data.data.ca_cert | base64Decode | writeToFile "./config/certs/ca-cert.pem" "" "" "0644" }}{{end}}
{{ with secret "/secret/vault/tls" }}{{ .Data.data.server_cert | base64Decode | writeToFile "./config/certs/server-cert.pem" "" "" "0644" }}{{end}}
{{ with secret "/secret/vault/tls" }}{{ .Data.data.server_key | base64Decode | writeToFile "./config/certs/server-key.pem" "" "" "0600" }}{{end}}

listener "tcp" {
  address                  = "{{ `{{ GetAllInterfaces | include \"name\" \"eth\" | sort \"-name\" | limit 1 | attr \"address\" }}` }}:8200"
  tls_client_ca_file       = "{{ with secret "/secret/vault/core" }}{{ .Data.data.config_dir }}{{end}}certs/ca-cert.pem"
  tls_cert_file            = "{{ with secret "/secret/vault/core" }}{{ .Data.data.config_dir }}{{end}}certs/server-cert.pem"
  tls_key_file             = "{{ with secret "/secret/vault/core" }}{{ .Data.data.config_dir }}{{end}}certs/server-key.pem"
  tls_disable_client_certs = true
}

ui = true
