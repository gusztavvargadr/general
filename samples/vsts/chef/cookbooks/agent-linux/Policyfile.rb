directory = File.dirname(__FILE__)

require "#{directory}/../../core.Policyfile"

name 'gusztavvargadr_vsts_agent_linux'

default_sources

run_list(
  'recipe[gusztavvargadr_vsts_agent_linux::default]'
)

named_run_list(
  :upgrade,
  'recipe[gusztavvargadr_vsts_agent_linux::upgrade]'
)

named_run_list(
  :add,
  'recipe[gusztavvargadr_vsts_agent_linux::add]'
)

named_run_list(
  :remove,
  'recipe[gusztavvargadr_vsts_agent_linux::remove]'
)
