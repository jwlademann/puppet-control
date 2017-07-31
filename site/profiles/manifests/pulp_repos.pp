class profiles::pulp_repos(
  $rpmrepos = {},
  $repository_uri = undef,
  ){

  file { '/etc/yum.repos.d/pulp.repo':
    ensure  => 'file',
    content => template('pulp/pulp.repo.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  exec { 'Clean Yum cache':
    command => 'yum clean all'
  }
}
