job "consul-standalone" {
  type = "service"

  group "server" {
    count = 1

    task "agent" {
      driver = "docker"

      template {
        data = <<EOH
bind_addr = "127.0.0.1"

server           = true
bootstrap_expect = 1

ui_config {
  enabled = true
}
EOH
        destination = "local/config/config.hcl"
      }

      config {
        image = "hashicorp/consul:1.18.1"

        volumes = [
          "local/config:/consul/config",
          "/opt/nomad/volumes/consul-server-agent-data:/consul/data",
        ]

        network_mode = "host"

        args = [
          "agent",
        ]
      }

      resources {
        cpu    = 200
        memory = 200
      }
    }
  }
}
