class profiles::pulp(
  $rpmrepos = {},
  $uname = undef,
  $pword = undef,
  ){

  class { 'pulp::runstages':}
  class { '::pulp':
    broker_url          => $pulp::broker_url,
    messaging_url       => $pulp::messaging_url,
    messaging_transport => $pulp::messaging_transport
    }
  class { '::pulp::consumer':
    host                => $pulp::consumer::host,
    messaging_host      => $pulp::consumer::messaging_host,
    messaging_transport => $pulp::consumer::messaging_transport,
    messaging_port      => $pulp::consumer::messaging_port
    }
  class { '::pulp::admin':} ->
  class { '::pulp::login':
    uname => $uname,
    pword => $pword,
    stage => 'justbefore',
  } ->
  class { '::pulp::reposetup':
    rpmrepos  => $rpmrepos,
    stage     => 'last',
    }

}
