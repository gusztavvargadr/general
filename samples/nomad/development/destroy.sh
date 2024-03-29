#!/usr/bin/env bash

sudo kill $(cat ./artifacts/nomad.pid)
sleep 1s

sudo rm -Rf ./artifacts
