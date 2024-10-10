#!/usr/bin/env bash

nomad job stop consul-development

unset CONSUL_HTTP_ADDR
