require 'spec_helper_system'

describe 'acpid class:' do
  context 'with default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
        class { 'acpid': }
      EOS
  
      puppet_apply(pp) do |r|
       r.exit_code.should_not == 1
       r.refresh
       r.exit_code.should be_zero
      end
    end

    describe package('acpid') do
      it { should be_installed }
    end

    describe service('acpid') do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
