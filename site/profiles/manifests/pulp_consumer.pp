class profiles::pulp_consumer(
  $user = undef,
  $pass = undef,
  $repobindings = undef,
  ){

  class { '::pulp::consumer':
    host                => $pulp::consumer::host,
    messaging_host      => $pulp::consumer::messaging_host,
    messaging_transport => $pulp::consumer::messaging_transport,
  }

  class { '::pulp::consumer::bind':
    repobindings => $repobindings,
    user         => $user,
    pass         => $pass,
  }


}
