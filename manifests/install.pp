class wirbelsturm_common::install inherits wirbelsturm_common {

  package { 'puppet':
    ensure => $puppet_package_ensure,
  }

  package { 'facter':
    ensure => $facter_package_ensure,
  }

  package { 'java-runtime-environment':
    name   => $java_package_name,
    ensure => $java_package_ensure,
    alias  => java-jdk,
  }

  package { 'netcat':
    name   => $netcat_package_name,
    ensure => $netcat_package_ensure,
  }

  # Workaround for a known Amazon cloud-init bug (left-over scripts from original AMI image when running a derived,
  # custom image).  See https://forums.aws.amazon.com/message.jspa?messageID=449984 (May 2013).
  #
  # When Puppet is run the scripts have already been executed, and they will only be executed once per instance
  # anyways.  So we can safely remove them at this point.
  case $::operatingsystem {
    'Amazon': {
      file { '/var/lib/cloud/data/scripts':
        ensure  => 'directory',
        recurse => true,
        purge   => true,
      }
    }
  }

}
