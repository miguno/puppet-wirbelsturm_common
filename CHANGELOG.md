# Change log

## 1.0.5 (unreleased)

* Install `netcat` by default.


## 1.0.4 (July 02, 2014)

* Rename module (in `Modulefile`) from "wirbelsturm-common" to "wirbelsturm-wirbelsturm_common" to be consistent across
  the various `puppet-wirbelsturm_*` Puppet modules of Wirbelsturm.


## 1.0.3 (April 09, 2014)

IMPROVEMENTS

* Remove dependencies from `Modulefile` to decouple us from PuppetForge.


## 1.0.2 (March 24, 2014)

* Configure NTP closer to the default configurations in RHEL/CentOS 6 and Amazon Linux (if `$ntp_manage` is true).


## 1.0.1 (March 24, 2014)

IMPROVEMENTS

* Harden NTP configuration to prevent abuse for NTP-based DDoS reflection attacks.


## 1.0.0 (March 12, 2014)

* Initial release.

