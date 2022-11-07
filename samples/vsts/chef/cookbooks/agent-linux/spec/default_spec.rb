require 'chefspec'

describe 'gusztavvargadr_vsts_agent_linux::default' do
  platform 'ubuntu'

  step_into 'gusztavvargadr_vsts_agent_linux_os'
  step_into 'gusztavvargadr_vsts_agent_linux_git'
  step_into 'gusztavvargadr_vsts_agent_linux_dotnet'
  step_into 'gusztavvargadr_vsts_agent_linux_hashicorp'
  step_into 'gusztavvargadr_vsts_agent_linux_chef'
  step_into 'gusztavvargadr_vsts_agent_linux_docker'
  step_into 'gusztavvargadr_vsts_agent_linux_virtualbox'
  step_into 'gusztavvargadr_vsts_agent_linux_agent'

  describe 'uses the custom resource' do
    it { is_expected.to update_apt_update('') }
  end
end
