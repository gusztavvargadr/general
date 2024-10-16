#!/usr/bin/env bash

cat <<EOF > /tmp/nomad.hcl
plugin "docker" {
  config {
    volumes {
      enabled = true
    }
  }
}
EOF

nohup nomad agent -dev -config=/tmp/nomad.hcl > /tmp/nomad.log 2>&1 &
sleep 5s

export NOMAD_ADDR="http://127.0.0.1:4646"

nomad server members
nomad node status
nomad status
