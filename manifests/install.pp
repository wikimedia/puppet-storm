# == Class storm::install
#
class storm::install {
	package { "storm": ensure => "installed" }
}