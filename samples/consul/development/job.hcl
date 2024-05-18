job "consul-development" {
  type = "service"

  group "server" {
    count = 1

    task "agent" {
      driver = "docker"

      config {
        image = "hashicorp/consul:1.18.1"

        network_mode = "host"

        args = [
          "agent",
          "-dev",
        ]
      }

      resources {
        cpu    = 100
        memory = 100
      }
    }
  }
}
