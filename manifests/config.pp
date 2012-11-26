# == Class storm::config
#
class storm::config(
	$nimbus_host,
	$zookeeper_hosts,
	$storm_local_dir  = "/var/lib/storm",
	$worker_count     = undef,
	$ui_port          = undef,
	$storm_home       = "/usr/lib/storm",
	$enable_jmxremote = true)
{
	file { $storm_local_dir: 
		ensure => "directory",
	}

	file { "/etc/storm/storm.yaml":
		content => template("storm/storm.yaml.erb"),
	}

	file { "/etc/default/storm":
		content => template("storm/storm.default.erb")
	}
}