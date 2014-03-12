class wirbelsturm_common (
  $facter_package_ensure = $wirbelsturm_common::params::facter_package_ensure,
  $ipv6_disable          = hiera('wirbelsturm_common::ipv6_disable', $wirbelsturm_common::params::ipv6_disable),
  $ipv6_manage           = hiera('wirbelsturm_common::ipv6_manage', $wirbelsturm_common::params::ipv6_manage),
  $java_package_ensure   = $wirbelsturm_common::params::java_package_ensure,
  $java_package_name     = $wirbelsturm_common::params::java_package_name,
  $ntp_manage            = hiera('wirbelsturm_common::ntp_manage', $wirbelsturm_common::params::ntp_manage),
  $puppet_package_ensure = $wirbelsturm_common::params::puppet_package_ensure,
) inherits wirbelsturm_common::params {

  validate_string($facter_package_ensure)
  validate_bool($ipv6_disable)
  validate_bool($ipv6_manage)
  validate_string($java_package_ensure)
  validate_string($java_package_name)
  validate_bool($ntp_manage)
  validate_string($puppet_package_ensure)

  # Configure a global path (e.g. required for sysctl module)
  # FIXME: this setting does not seem to have a global effect
  Exec { path => '/usr/bin:/usr/sbin/:/bin:/sbin' }

  include '::wirbelsturm_common::install'
  include '::wirbelsturm_common::config'

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up. You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'wirbelsturm_common::begin': }
  anchor { 'wirbelsturm_common::end': }

  Anchor['wirbelsturm_common::begin'] -> Class['::wirbelsturm_common::install']
    -> Class['::wirbelsturm_common::config'] -> Anchor['wirbelsturm_common::end']
}
