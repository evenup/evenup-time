# Class: time
#
# This module manages the timezone and ntp status of a machine
#
# Requires:
#   time::params
#
# Sample Usage:
#   include time
#
class time {

  $timezone = hiera('time::timezone', 'UTC')

  package {
    ['tzdata', 'ntp']:
      ensure => 'present'
  }

  file {
    '/etc/localtime':
      ensure  => 'link',
      target  => "/usr/share/zoneinfo/${timezone}";

    '/etc/sysconfig/clock':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      require => Package['ntp'],
      content => template('time/clock.sysconfig');

    '/etc/ntp.conf':
      ensure  => file,
      path    => '/etc/ntp.conf',
      require => Package['ntp'],
      notify  => Service['ntpd'],
      content => template('time/ntp.conf');
  }

  service {
    'ntpd':
      ensure    => running,
      enable    => true,
      subscribe => File['/etc/ntp.conf'];
  }

  common::line {
    'peerntp-eth0-y':
      ensure  => absent,
      file    => '/etc/sysconfig/network-scripts/ifcfg-eth0',
      line    => 'PEERNTP=yes';

    'peerntp-eth0-n':
      file  => '/etc/sysconfig/network-scripts/ifcfg-eth0',
      line  => 'PEERNTP=no';
  }

  if 'eth1' in $::interfaces {
    common::line {
      'peerntp-eth1-y':
        ensure  => absent,
        file    => '/etc/sysconfig/network-scripts/ifcfg-eth1',
        line    => 'PEERNTP=yes';

      'peerntp-eth1-n':
        file    => '/etc/sysconfig/network-scripts/ifcfg-eth1',
        line    => 'PEERNTP=no';
    }
  }
}
