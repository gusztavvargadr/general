#!/usr/bin/env bash

set -uo pipefail

sudo systemctl stop nomad.service
sudo systemctl disable nomad.service
