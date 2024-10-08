#!/usr/bin/env bash

pushd ~/opt/nomad

kill $(cat ./nomad.pid)
sleep 1s

popd

sudo rm -Rf ~/opt/nomad
