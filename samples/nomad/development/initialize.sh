#!/usr/bin/env bash

curl -Ls https://gist.github.com/gusztavvargadr/1f0d7dddc7f48549368eaaedf19bfe55/raw/provision.sh | sudo CHEF_POLICY="gusztavvargadr_development" bash -s
