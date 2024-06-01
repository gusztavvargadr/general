#!/usr/bin/env bash

sudo cp ./config.hcl /etc/nomad.d/nomad.hcl
sudo chown -R nomad:nomad /etc/nomad.d

sudo systemctl enable nomad.service
sudo systemctl start nomad.service
sleep 15s

export NOMAD_ADDR="http://127.0.0.1:4646"

nomad server members
nomad node status
nomad status
