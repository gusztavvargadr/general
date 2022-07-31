service {
  name = "api"
  port = 5000

  checks = [
    {
      tcp      = "localhost:5000"
      interval = "5s"
    }
  ]

  connect = {
    sidecar_service = {}
  }
}
