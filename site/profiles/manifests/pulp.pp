class profiles::pulp(){

  class { '::pulp':
    broker_url          => $pulp::broker_url,
    messaging_url       => $pulp::messaging_url,
    messaging_transport => $pulp::messaging_transport
    }
  class { '::pulp::consumer':
    messaging_host      => $pulp::consumer::messaging_host,
    messaging_transport => $pulp::consumer::messaging_transport
  }
  class { '::pulp::admin':}

}
