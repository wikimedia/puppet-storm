# == Class storm::supervisor
#
class storm::supervisor(
	$jvm_memory = "768m",
	$jvm_opts   = "-Dlog4j.configuration=storm.log.properties")
{
	require storm

	$enable_jmxremote          = $storm::config::enable_jmxremote
	$supervisor_jmxremote_port = 9971

	file { "/etc/default/storm-supervisor":
		content => template("storm/storm-supervisor.default.erb")
	}

	service { "storm-supervisor":
		ensure    => "running",
		enable    => true,
		subscribe => [File["/etc/storm/storm.yaml"], File["/etc/default/storm-supervisor"], File["/etc/default/storm"]],
	}
}