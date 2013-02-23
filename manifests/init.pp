class lxc_testing () {
  package { ['lxc','lxc-templates','bridge-utils']:
    ensure => 'installed'
  }

  file { '/etc/sysconfig/network-scripts/ifcfg-br0':
    content => template('lxc_testing/ifcfg-br0.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['bridge-utils'],
  }
  
  file { '/var/lib/lxc/lxc.conf':
    content => template('lxc_testing/lxc.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['lxc'],
  }

  exec { 'create container':
    command => 'lxc-create -n test -f /var/lib/lxc/lxc.conf -t sshd',
    creates => '/var/lib/lxc/test/config',
  }
}
