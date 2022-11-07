directory = File.dirname(__FILE__)

require "#{directory}/../../core.Policyfile"

name 'gusztavvargadr_vsts_agent_linux'

default_sources

run_list(
  'recipe[gusztavvargadr_vsts_agent_linux::default]'
)
