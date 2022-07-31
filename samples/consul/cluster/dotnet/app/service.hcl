service {
  name = "app"
  port = 5001

  checks = [
    {
      tcp      = "localhost:5001"
      interval = "5s"
    }
  ]

  connect = {
    sidecar_service = {
      proxy = {
        upstreams = [
          {
            destination_name = "api"
            local_bind_port = 5000
          }
        ]
      }
    }
  }
}
