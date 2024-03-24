job "vault-development" {
  type = "service"

  group "server" {
    count = 1

    task "agent" {
      driver = "docker"

      config {
        image = "hashicorp/vault:1.15.6"

        network_mode = "host"

        args = [
          "server",
          "-dev",
          "-dev-root-token-id=root",
          "-dev-listen-address=127.0.0.1:8200",
        ]
      }

      resources {
        cpu    = 100
        memory = 500
      }
    }
  }
}
