#!/usr/bin/env sh

set -eu

consul-template -config templates.hcl -once
chown -R consul:consul ./config/
