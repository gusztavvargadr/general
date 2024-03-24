#!/usr/bin/env bash

nomad job run ./job.hcl

export CONSUL_HTTP_ADDR="http://127.0.0.1:8500"

consul members
