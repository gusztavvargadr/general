data_dir = "{{ key "nomad/core/data_dir" }}"

bind_addr = "0.0.0.0"

client {
  enabled          = true

  server_join {
    retry_join = {{ key "nomad/servers" }}
  }

  drain_on_shutdown {
    deadline = "1h"
  }
}

tls {
  http = true
  rpc  = true

  {{ $ca_file_path := key "nomad/core/config_dir" | printf "%s/tls/ca-cert.pem" }}
  {{ key "nomad/tls/ca_cert" | writeToFile $ca_file_path  "" "" "0644" }}
  ca_file   = "{{ $ca_file_path }}"

  {{ $cert_file_path := key "nomad/core/config_dir" | printf "%s/tls/nomad-cert.pem" }}
  {{ key "nomad/tls/client_cert" | writeToFile $cert_file_path "" "" "0600" }}
  cert_file = "{{ $cert_file_path }}"

  {{ $key_file_path := key "nomad/core/config_dir" | printf "%s/tls/nomad-key.pem" }}
  {{ key "nomad/tls/client_key" | writeToFile $key_file_path "" "" "0600" }}
  key_file  = "{{ $key_file_path }}"
}

acl {
  enabled = true
}

leave_on_interrupt = true
leave_on_terminate = true

plugin "docker" {
  config {
    volumes {
      enabled = true
    }
  }
}
