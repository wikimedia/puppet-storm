# == Class storm::nimbus
#
class storm::nimbus(
	$jvm_memory = "768m",
	$jvm_opts   = "-Dlog4j.configuration=storm.log.properties")
{
	require storm

	$enable_jmxremote      = $storm::config::enable_jmxremote
	$nimbus_jmxremote_port = 9970

	file { "/etc/default/storm-nimbus":
		content => template("storm/storm-nimbus.default.erb")
	}

	service { "storm-nimbus":
		ensure    => "running",
		enable    => true,
		subscribe => [File["/etc/storm/storm.yaml"], File["/etc/default/storm-nimbus"], File["/etc/default/storm"]],
	}
}