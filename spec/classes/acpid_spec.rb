require 'spec_helper'

describe 'acpid' do
  include_context :defaults

  let(:facts) { default_facts }

  it { should create_class('acpid') }
  it { should contain_class('acpid::params') }

  it do
    should contain_package('acpid').with({
      'ensure'    => 'present',
      'name'      => 'acpid',
      'before'    => 'Service[acpid]',
    })
  end

  it do
    should contain_service('acpid').with({
      'ensure'      => 'running',
      'enable'      => 'true',
      'name'        => 'acpid',
      'hasstatus'   => 'true',
      'hasrestart'  => 'true',
    })
  end

  # Test service ensure and enable 'magic' values
  [
    'undef',
    'UNSET',
  ].each do |v|
    context "with service_ensure => '#{v}'" do
      let(:params) {{ :service_ensure => v }}
      it { should contain_service('acpid').without_ensure }
    end

    context "with service_enable => '#{v}'" do
      let(:params) {{ :service_enable => v }}
      it { should contain_service('acpid').without_enable }
    end
  end
end
