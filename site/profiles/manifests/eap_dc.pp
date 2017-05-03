#domain master controller

class profiles::eap_dc(){

  class { '::wildfly':
    distribution => 'jboss-eap',
    user         => 'jboss-eap',
    group        => 'jboss-eap',
    dirname      => '/opt/jboss-eap',
    console_log  => '/var/log/jboss-eap/console.log',
    java_home    => '/usr',
    mode         => 'domain',
    host_config  => 'host-master.xml',
  }
  $dc_server_groups = hiera_hash('wildfly::dc_server_groups',false)
  create_resources('wildfly::domain::server_group', $dc_server_groups)
}
