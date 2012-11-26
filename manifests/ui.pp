# == Class storm::ui
#
class storm::ui(
	$jvm_memory = "768m",
	$jvm_opts   = "-Dlog4j.configuration=storm.log.properties")
{
	require storm

	$enable_jmxremote  = $storm::config::enable_jmxremote
	$ui_jmxremote_port = 9972

	file { "/etc/default/storm-ui":
		content => template("storm/storm-ui.default.erb")
	}

	service { "storm-ui":
		ensure    => "running",
		enable    => true,
		subscribe => [File["/etc/storm/storm.yaml"], File["/etc/default/storm-ui"], File["/etc/default/storm"]],
	}
}