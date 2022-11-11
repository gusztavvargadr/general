directory = File.dirname(__FILE__)

require "#{directory}/../../core.Policyfile"

name 'gusztavvargadr_vsts_agent_windows'

default_sources

run_list(
  'recipe[gusztavvargadr_vsts_agent_windows::default]'
)

named_run_list(
  :upgrade,
  'recipe[gusztavvargadr_vsts_agent_windows::upgrade]'
)

named_run_list(
  :add,
  'recipe[gusztavvargadr_vsts_agent_windows::add]'
)

named_run_list(
  :remove,
  'recipe[gusztavvargadr_vsts_agent_windows::remove]'
)
