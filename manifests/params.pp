# == Class: acpid::params
#
# The acpid configuration settings.
#
# === Authors
#
# Trey Dockendorf <treydock@gmail.com>
#
# === Copyright
#
# Copyright 2014 Trey Dockendorf
#
class acpid::params {

  case $::osfamily {
    'RedHat': {
      $package_name       = 'acpid'
      $service_name       = 'acpid'
      $service_hasstatus  = true
      $service_hasrestart = true
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}
