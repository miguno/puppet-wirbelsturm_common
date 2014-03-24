class wirbelsturm_common::config inherits wirbelsturm_common {

  if $ipv6_manage == true {
    if $ipv6_disable == true {
      sysctl::value { 'net.ipv6.conf.all.disable_ipv6':
        value => 1
      }
      sysctl::value { 'net.ipv6.conf.default.disable_ipv6':
        value => 1
      }
    }
    else {
      sysctl::value { 'net.ipv6.conf.all.disable_ipv6':
        value => 0
      }
      sysctl::value { 'net.ipv6.conf.default.disable_ipv6':
        value => 0
      }
    }
  }

  if $ntp_manage == true {
    case $::operatingsystem {
      # Do not provision NTP on EC2 because the ntp module is not supported on an Amazon system
      'Amazon': {}

      default: {
        class { "::ntp":
          # 'iburst' speeds up the initial synchronization
          servers    => [ '0.rhel.pool.ntp.org iburst',
                          '1.rhel.pool.ntp.org iburst',
                          '2.rhel.pool.ntp.org iburst',
                        ],
          autoupdate => false,
          restrict   => [
            '127.0.0.1',
            '-6 ::1',
          ],
        }
      }
    }
  }

}
