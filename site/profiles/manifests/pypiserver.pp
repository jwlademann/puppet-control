class profiles::pypiserver(
  ){

  class {'bandersnatch':
    document_root => '/srv/pypi',
    enable_cron => false,
    }

  class { 'nginx':
  }

  nginx::resource::vhost { "pypi-mirror":
    ensure      => present,
    listen_port => 8080,
    www_root    => '/srv/pypi/web',
    server_name => ['_'],
    autoindex   => 'on',
  }

  # Load SELinuux policy for NginX
  selinux::module { 'httpd_t':
    ensure => 'present',
    source => '/vagrant/nginx_pypi.te'
  }

Class['::nginx::config'] -> Nginx::Resource::Vhost <| |>

}
