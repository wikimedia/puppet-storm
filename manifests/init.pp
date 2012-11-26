# == Class storm
#
class storm(
	$nimbus_host      = "localhost",
	$zookeeper_hosts  = ["localhost"],
	$storm_local_dir  = "/var/lib/storm",
	$worker_count     = undef,
	$ui_port          = undef,
	$storm_home       = "/usr/lib/storm",
	$enable_jmxremote = true)
{
	include storm::install

	class { "storm::config":
		nimbus_host       => $nimbus_host,
		zookeeper_hosts  => $zookeeper_hosts,
		storm_local_dir  => $storm_local_dir,
		worker_count     => $worker_count,
		ui_port          => $ui_port,
		storm_home       => $storm_home,
		enable_jmxremote => $enable_jmxremote,
		require         => Class["storm::install"],
	}
}