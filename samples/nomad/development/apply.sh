#!/usr/bin/env bash

mkdir -p ~/opt/nomad-development
pushd ~/opt/nomad-development

mkdir -p ./config
# cat <<EOF > ./config/client.hcl
# client {
#   cpu_total_compute = 1000
# }
# EOF

nohup nomad agent -dev -config=./config > ./nomad.log 2>&1 &
echo $! > ./nomad.pid
sleep 5s

popd

export NOMAD_ADDR="http://127.0.0.1:4646"

nomad server members
nomad node status
nomad status
