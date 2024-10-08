#!/usr/bin/env bash

mkdir -p ~/opt/nomad
pushd ~/opt/nomad

nohup nomad agent -dev > ./nomad.log 2>&1 &
echo $! > ./nomad.pid
sleep 1s

popd

export NOMAD_ADDR="http://127.0.0.1:4646"

nomad server members
nomad node status
nomad status
