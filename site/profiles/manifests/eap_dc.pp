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

  $servers = hiera_hash('wildfly::servers',false)
  create_resources('wildfly::resource', $servers)

  $mod_cluster_config=hiera_hash('wildfly::mod_cluster_config',false)
  create_resources('wildfly::resource',$mod_cluster_config)

  $undertow_config=hiera_hash('wildfly::undertow_config',false)
  create_resources('wildfly::resource',$undertow_config)

  $default_undertow= hiera_hash('wildfly::default_undertow',false)
  create_resources('wildfly::resource',$default_undertow)

  $deployment = hiera_hash('wildfly::deployment',false)
  create_resources('wildfly::deployment', $deployment)
}
