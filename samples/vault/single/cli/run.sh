#!/usr/bin/env sh

set -eu

eval `./state/env.sh`
vault $*
