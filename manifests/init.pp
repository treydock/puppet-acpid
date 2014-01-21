# == Class: acpid
#
# Manages acpid.
#
# === Parameters
#
# [*package_name*]
#   String. Name of the acpid package.
#   Default: 'acpid'
#
# [*service_name*]
#   String. Name of the acpid service.
#   Default: 'acpid'
#
# [*service_ensure*]
#   Service ensure parameter.
#   Default: 'running'
#
# [*service_enable*]
#   Service enable parameter.
#   Default: true
#
# [*service_hasstatus*]
#   Service hasstatus parameter.
#
# [*service_hasrestart*]
#   Service hasrestart parameter.
#
# === Examples
#
#  class { 'acpid': }
#
# === Authors
#
# Trey Dockendorf <treydock@gmail.com>
#
# === Copyright
#
# Copyright 2014 Trey Dockendorf
#
class acpid (
  $package_name         = $acpid::params::package_name,
  $service_name         = $acpid::params::service_name,
  $service_ensure       = 'running',
  $service_enable       = true,
  $service_hasstatus    = $acpid::params::service_hasstatus,
  $service_hasrestart   = $acpid::params::service_hasrestart
) inherits acpid::params {

  # This gives the option to not manage the service 'ensure' state.
  $service_ensure_real  = $service_ensure ? {
    /UNSET|undef/ => undef,
    default       => $service_ensure,
  }

  # This gives the option to not manage the service 'enable' state.
  $service_enable_real  = $service_enable ? {
    /UNSET|undef/ => undef,
    default       => $service_enable,
  }

  package { 'acpid':
    ensure  => present,
    name    => $package_name,
    before  => Service['acpid'],
  }

  service { 'acpid':
    ensure      => $service_ensure_real,
    enable      => $service_enable_real,
    name        => $service_name,
    hasstatus   => $service_hasstatus,
    hasrestart  => $service_hasrestart,
  }
}
