#!/usr/bin/env bash

set -euxo pipefail

cloud-init status --wait

chef-client --version
