directory = File.dirname(__FILE__)

require "#{directory}/chef/core.Policyfile"

name 'gusztavvargadr_vsts_agent_linux_core'

default_sources

run_list(
  'recipe[gusztavvargadr_vsts_agent_linux::default]'
)
