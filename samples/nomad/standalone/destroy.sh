#!/usr/bin/env bash

sudo systemctl stop nomad.service
sudo systemctl disable nomad.service
sleep 5s

sudo rm -Rf /opt/nomad/volumes/*
sudo rm -Rf /opt/nomad/data/*
