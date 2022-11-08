require 'chefspec'

describe 'gusztavvargadr_vsts_agent_linux::upgrade' do
  platform 'ubuntu'

  step_into 'gusztavvargadr_vsts_agent_linux_agent'

  describe 'run_execute' do
    it { is_expected.to nothing_execute 'installdependencies.sh' }
  end
end
