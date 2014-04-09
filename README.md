# puppet-wirbelsturm_common

Wirbelsturm-compatible Puppet module to perform common Wirbelsturm deployment activities

---

Table of Contents

* <a href="#quickstart">Quick start</a>
* <a href="#features">Features</a>
* <a href="#requirements">Requirements and assumptions</a>
* <a href="#installation">Installation</a>
* <a href="#configuration">Configuration</a>
* <a href="#usage">Usage</a>
    * <a href="#configuration-examples">Configuration examples</a>
        * <a href="#hiera">Using Hiera</a>
        * <a href="#manifests">Using Puppet manifests</a>
* <a href="#todo">TODO</a>
* <a href="#changelog">Change log</a>
* <a href="#contributing">Contributing</a>
* <a href="#license">License</a>

---

<a name="quickstart"></a>

# Quick start

See section [Usage](#usage) below.


<a name="features"></a>

# Features

* Decouples code (Puppet manifests) from configuration data ([Hiera](http://docs.puppetlabs.com/hiera/1/)) through the
  use of Puppet parameterized classes, i.e. class parameters.  Hence you should use Hiera to configure the settings
  provided by this module.
* Supports RHEL OS family (e.g. RHEL 6, CentOS 6, Amazon Linux).
    * Code contributions to support additional OS families are welcome!
* The module covers the following tasks:
    * Manage Puppet/Facter installation.
    * Manage Java JRE/JDK installation.
    * Manage NTP.
    * Enable/disable IPv6.
    * Adds a workaround to fix a known cloud-init issue in Amazon Linux AMI images on AWS.


<a name="requirements"></a>

# Requirements and assumptions

* This module requires the following **additional Puppet modules**:

    * [puppetlabs/ntp](https://github.com/puppetlabs/puppetlabs-ntp)
    * [puppetlabs/stdlib](https://github.com/puppetlabs/puppetlabs-stdlib)
    * [puppet-sysctl](https://github.com/miguno/puppet-sysctl)

  It is recommended that you add these modules to your Puppet setup via
  [librarian-puppet](https://github.com/rodjek/librarian-puppet).  See the `Puppetfile` snippet in section
  _Installation_ below for a starting example.


<a name="installation"></a>

# Installation

It is recommended to use [librarian-puppet](https://github.com/rodjek/librarian-puppet) to add this module to your
Puppet setup.

Add the following lines to your `Puppetfile`:

```
# Add the dependencies as hosted on public Puppet Forge.
#
# We intentionally do not include e.g. the stdlib dependency in our Modulefile to make it easier for users who decided
# to use internal copies of stdlib so that their deployments are not coupled to the availability of PuppetForge.  While
# there are tools such as puppet-library for hosting internal forges or for proxying to the public forge, not everyone
# is actually using those tools.
mod 'puppetlabs/ntp', '>= 3.0.3'
mod 'puppetlabs/stdlib', '>= 4.1.0'

# Add the puppet-wirbelsturm_common module
mod 'wirbelsturm_common',
  :git => 'https://github.com/miguno/puppet-wirbelsturm_common.git'

# Add the puppet-sysctl module dependency
mod 'sysctl',
  :git => 'https://github.com/miguno/puppet-sysctl.git'
```

Then use librarian-puppet to install (or update) the Puppet modules.


<a name="configuration"></a>

# Configuration

* See [init.pp](manifests/init.pp) for the list of currently supported configuration parameters.  These should be self-explanatory.
* See [params.pp](manifests/params.pp) for the default values of those configuration parameters.


<a name="usage"></a>

# Usage

**IMPORTANT: Make sure you read and follow the [Requirements and assumptions](#requirements) section above.**
**Otherwise the examples below will of course not work.**


<a name="configuration-examples"></a>

## Configuration examples


<a name="hiera"></a>

### Using Hiera

Simple example, using default settings:

```yaml
---
classes:
  - wirbelsturm_common
```

In this example we override some of the default settings:

```yaml
---
classes:
  - wirbelsturm_common

# Custom settings
wirbelsturm_common::ipv6_manage: true  # Yes, we want to manage IPv6 on this machine...
wirbelsturm_common::ipv6_disable: true # ...and we want IPv6 to be disabled
wirbelsturm_common::java_package_name: 'java-1.6.0-sun' # Use Oracle/Sun JRE 6
                                                        # (package name as used on RHEL 6 OS family)
wirbelsturm_common::ntp_manage: true   # Install and set up NTP
```

<a name="manifests"></a>

### Using Puppet manifests

_Note: It is recommended to use Hiera to control deployments instead of using this module in your Puppet manifests_
_directly._

TBD


<a name="todo"></a>

# TODO

* Enhance documentation
* Split into single-purpose modules (e.g. a separate module just for managing Java JRE/JDK)
* Enhance in-line documentation of Puppet manifests.
* Add unit tests and specs.
* Add Travis CI setup.


<a name="changelog"></a>

# Change log

See [CHANGELOG](CHANGELOG.md).


<a name="contributing"></a>

# Contributing to puppet-wirbelsturm_common

Code contributions, bug reports, feature requests etc. are all welcome.

If you are new to GitHub please read [Contributing to a project](https://help.github.com/articles/fork-a-repo) for how
to send patches and pull requests to puppet-wirbelsturm_common.


<a name="license"></a>

# License

Copyright © 2014 Michael G. Noll

See [LICENSE](LICENSE) for licensing information.
