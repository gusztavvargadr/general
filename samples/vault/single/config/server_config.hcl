storage "file" {
  path = "/vault/file"
}

listener "tcp" {
  address                  = "0.0.0.0:8200"
  tls_cert_file            = "/vault/config/server.crt"
  tls_key_file             = "/vault/config/server.key"
  tls_disable_client_certs = true
}

ui = true
