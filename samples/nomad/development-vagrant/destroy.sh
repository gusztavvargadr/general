#!/usr/bin/env bash

pushd ~/opt/nomad-development

kill $(cat ./nomad.pid)
sleep 5s

popd

rm -Rf ~/opt/nomad-development

unset NOMAD_ADDR
