#domain master controller

class profiles::eap_dc(){

  $repository_source = hiera('wildfly::repository_source')
  $modules = [ "${wildfly::dirname}/modules/com", "${wildfly::dirname}/modules/com/ibm","${wildfly::dirname}/modules/com/ibm/main",
              "${wildfly::dirname}/modules/com/oracle","${wildfly::dirname}/modules/com/oracle/main"]

  class { '::wildfly':
    distribution => 'jboss-eap',
    console_log  => '/var/log/jboss-eap/console.log',
    java_home    => '/usr',
    mode         => 'domain',
    host_config  => 'host-master.xml',
  }
  file { $modules:
    ensure  => 'directory',
    owner   => $wildfly::user,
    group   => $wildfly::group,
    require => Class['::wildfly']
  }
  file { "${wildfly::dirname}/modules/com/ibm/main/module.xml":
    ensure  => present,
    owner   => $wildfly::user,
    group   => $wildfly::group,
    source  => 'puppet:///modules/profiles/jboss-eap/ibm/module.xml',
    recurse => true,
    require => File[$modules]
  }
  exec { "download ibm driver license":
    command  => "wget ${repository_source}/db2jcc_license_cisuz.jar -P ${wildfly::dirname}/modules/com/ibm/main",
    path     => ['/bin', '/usr/bin', '/sbin'],
    loglevel => 'notice',
    user     => $wildfly::user,
    group    => $wildfly::group,
    creates  => "${wildfly::dirname}/modules/com/ibm/main/db2jcc_license_cisuz.jar",
    require  => File[$modules],
  }
  exec { "download ibm driver":
    command  => "wget ${repository_source}/db2jcc4.jar -P ${wildfly::dirname}/modules/com/ibm/main",
    path     => ['/bin', '/usr/bin', '/sbin'],
    loglevel => 'notice',
    user     => $wildfly::user,
    group    => $wildfly::group,
    creates  => "${wildfly::dirname}/modules/com/ibm/main/db2jcc4.jar",
    require  => File[$modules],
  }
  file { "${wildfly::dirname}/modules/com/oracle/main/module.xml":
    ensure  => present,
    owner   => $wildfly::user,
    group   => $wildfly::group,
    source  => 'puppet:///modules/profiles/jboss-eap/oracle/module.xml',
    recurse => true,
    require => File[$modules]
  }
  exec { "download oracle driver":
    command  => "wget ${repository_source}/ojdbc7.jar -P ${wildfly::dirname}/modules/com/oracle/main",
    path     => ['/bin', '/usr/bin', '/sbin'],
    loglevel => 'notice',
    user     => $wildfly::user,
    group    => $wildfly::group,
    creates  => "${wildfly::dirname}/modules/com/oracle/main/ojdbc7.jar",
    require  => File[$modules],
  }

  $dc_server_groups = hiera_hash('wildfly::dc_server_groups',false)
  create_resources('wildfly::domain::server_group', $dc_server_groups)

  $mod_cluster_config=hiera_hash('wildfly::mod_cluster_config',false)
  create_resources('wildfly::resource',$mod_cluster_config)

  $undertow_config=hiera_hash('wildfly::undertow_config',false)
  create_resources('wildfly::resource',$undertow_config)

  $default_undertow= hiera_hash('wildfly::default_undertow',false)
  create_resources('wildfly::resource',$default_undertow)

  $driver_reg=hiera_hash('wildfly::driver_reg',false)
  create_resources('wildfly::datasources::driver', $driver_reg)

  $datasources = hiera_hash('wildfly::datasources',false)
  create_resources('wildfly::datasources::xa_datasource',$datasources)

  $naming = hiera_hash('wildfly::naming',false)
  create_resources('wildfly::resource',$naming)

  $servers = hiera_hash('wildfly::servers',false)
  create_resources('wildfly::resource', $servers)

  $deployment = hiera_hash('wildfly::deployment',false)
  create_resources('wildfly::deployment', $deployment)
}
