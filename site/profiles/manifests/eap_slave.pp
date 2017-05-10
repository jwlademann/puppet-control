#host controller for slave

class profiles::eap_slave(
  dc = '127.0.0.1'
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
  }
}
