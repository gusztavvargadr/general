terraform {
  required_version = "~> 1.5"

  cloud {
    workspaces {
      tags = ["general-cherryservers-server-ubuntu"]
    }
  }
}
