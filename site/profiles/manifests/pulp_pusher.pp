class profiles::pulp_pusher(
  $uname = undef,
  $pword = undef,
  ){

  class { '::pulp::consumer':
    host                => $pulp::consumer::host,
    messaging_host      => $pulp::consumer::messaging_host,
    messaging_transport => $pulp::consumer::messaging_transport,
  }

  class { '::pulp::admin':} ->
  class { '::pulp::login':
    uname => $uname,
    pword => $pword,
  }
}
