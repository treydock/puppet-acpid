require 'rspec-system/spec_helper'
require 'rspec-system-puppet/helpers'
require 'rspec-system-serverspec/helpers'

include RSpecSystemPuppet::Helpers
include Serverspec::Helper::RSpecSystem
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  # Project root for this module
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Enable colour in Jenkins
  c.tty = true
  
  c.include RSpecSystemPuppet::Helpers

  # This is where we 'setup' the nodes before running our tests
  c.before :suite do
    # Install puppet
    puppet_install
    puppet_master_install

    shell('[ -d /etc/puppet/modules/stdlib ] || puppet module install puppetlabs-stdlib --modulepath /etc/puppet/modules')
    
    # Install acpid module
    puppet_module_install(:source => proj_root, :module_name => 'acpid')
  end
end
