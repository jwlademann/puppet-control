#host controller for slave
class profiles::eap_slave (
  $dc = '127.0.0.1',
  $remote_password = hiera('wildfly::remote_password')
){

  # Assume that if we have multiple interfaces that eth1 is the data
  if ($::ipaddress_eth1) {
    $mgmt_addr = $::ipaddress_eth0
    $data_addr = $::ipaddress_eth1
  } else {
    $mgmt_addr = $::ipaddress_eth0
    $data_addr = $::ipaddress_eth0
  }

  class { '::wildfly':
    distribution => 'jboss-eap',
    user         => 'jboss-eap',
    group        => 'jboss-eap',
    dirname      => '/opt/jboss-eap',
    console_log  => '/var/log/jboss-eap/console.log',
    java_home    => '/usr',
    mode         => 'domain',
    host_config  => 'host-slave.xml',
    properties   => {
      'jboss.bind.address'            => $data_addr,
      'jboss.bind.address.management' => $mgmt_addr,
      'jboss.domain.master.address'   => $dc
    }
  }->
  wildfly_cli { ["/host=${::fqdn}/server-config=server-one:stop","/host=${::fqdn}/server-config=server-two:stop"]:
    username => $wildfly::remote_username,
    password => $remote_password,
    host     => $wildfly::properties['jboss.domain.master.address'],
    port     => '9990',
    require  => Service['wildfly'],
  }->
  wildfly_resource { ["/host=${::fqdn}/server-config=server-one","/host=${::fqdn}/server-config=server-two"]:
    ensure   => absent,
    username => $wildfly::remote_username,
    password => $remote_password,
    host     => $wildfly::properties['jboss.domain.master.address'],
    port     => '9990',
    require  => Service['wildfly'],
  }
}
