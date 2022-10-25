# == Class jupyterhub::params
#
# This class is meant to be called from jupyterhub.
# It sets variables according to platform.
#
class jupyterhub::params {
  case $facts['os']['family'] {
    'Debian': {
      $service_name           = 'jupyterhub'
      $jupyterhub_username    = '_jupyter'
      $jupyterhub_dir         = '/opt/jupyterhub'
      $pyvenv                 = '/opt/jupyterhub/pyvenv'
      $allowed_users          = undef
    }
    'RedHat', 'Amazon': {
      $service_name           = 'jupyterhub'
      $jupyterhub_username    = '_jupyter'
      $jupyterhub_dir         = '/opt/jupyterhub'
      $pyvenv                 = '/opt/jupyterhub/pyvenv'
      $allowed_users          = undef
    }
    default: {
      fail("${facts['os']['name']} not supported")
    }
  }
}
