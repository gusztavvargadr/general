#!/bin/bash

set -e

cloud-init status --wait

chef-client --version
