# puppet-storm
A puppet module for installing and running [Storm](http://storm-project.net/).

_Note: This puppet module is meant to work with .debs built by [storm-deb-packaging](https://github.com/wmf-analytics/storm-deb-packaging)_.

# Puppet Module Installation
Clone (or copy) this repository into your puppet modules/storm directory:
```bash
git clone git://github.com/wikimedia/puppet-storm.git
```

Or you could also use a git submodule:
```bash
git submodule add git://github.com/wmf-analytics/puppet-storm.git modules/storm
git commit -m 'Adding modules/storm as a git submodule.'
```

# Usage
## Storm installation and config
All Storm nodes (nimbus, supervisor, ui, etc.) should
include the ```storm``` class.  This ensures that all
nodes share the same storm.yaml config file.

```puppet
class analytics::storm {
  class { "storm":
      nimbus_host     => "nimbus.mydomain.org"
      zookeeper_hosts => ["zk1.mydomain.org", "zk2.mydomain.org"],
      worker_count    => $processorcount - 2, # use all but 2 processors on each worker machine
      ui_port         => 6999,
  }
}
```

## Storm Nimbus Master
```puppet
# inherit from analytics::storm to get Storm installtion and configs
class analytics::storm::master inherits analytics::storm {
  include storm::nimbus
}
```

## Storm Supervisor Workers
```puppet
# inherit from analytics::storm to get Storm installtion and configs
class analytics::storm::worker inherits analytics::storm {
  include storm::supervisor
}
```

## Storm Web UI
```puppet
# inherit from analytics::storm to get Storm installtion and configs
class analytics::storm::ui inherits analtyics::storm {
  include storm::ui
}
```

# Requirements
This module requires that a ```storm``` package is available to your package
management system.  Storm requires [ZeroMQ](http://www.zeromq.org/), so it
must be available for installation as well.

I built Storm and dependent .debs using [storm-deb-packaging](https://github.com/wmf-analytics/storm-deb-packaging),
which is forked and modified from the [original](https://github.com/phobos182/storm-deb-packaging).
The packages are currently (2012-11) available at http://analytics1001.wikimedia.org:81/apt/binary/.

# Wishlist
- Puppetize [Storm DRPC](https://github.com/nathanmarz/storm/wiki/Distributed-RPC).
- Parameterize JMX Remote Ports.
