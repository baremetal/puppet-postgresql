Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin" }


class postgres {
  $system_memory = 536870912

  service { "postgresql":
    ensure => running,
  }

  exec { "update_apt":
    command => "apt-get update",
    refreshonly => true,
  }

  exec { "notify_reboot":
    command => "echo '*** YOU NEED TO REBOOT IN ORDER TO APPLY SYSCTL CHANGES! ***'",
    refreshonly => true,
    logoutput => true,
  }

  exec { "add_pitti_ppa":
    command => "apt-add-repository ppa:pitti/postgresql",
    unless => "test -e /etc/apt/sources.list.d/pitti-postgresql-precise.list",
    notify => Exec["update_apt"],
  }

  package { ["postgresql-client-9.2", "postgresql-9.2"]:
    ensure => present,
    require => Exec["add_pitti_ppa"],
    before => Service["postgresql"],
  }

  file { "/etc/postgresql/9.2/main/postgresql.conf":
    ensure => present,
    content => template("/etc/puppet/modules/postgres/templates/etc/postgresql/9.2/main/postgresql.conf"),
    require => Package["postgresql-9.2"],
    notify => Service["postgresql"],
  }

  file { "/etc/sysctl.d/30-postgresql-shm.conf":
    ensure => present,
    content => template("/etc/puppet/modules/postgres/templates/etc/sysctl.d/30-postgresql-shm.conf"),
    notify => Exec["notify_reboot"],
  }
}


include postgres
