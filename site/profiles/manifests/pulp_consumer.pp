class profiles::pulp_consumer(){

  class { '::pulp::consumer':
    host                => $pulp::consmer::host,
    messaging_host      => $pulp::consmer::messaging_host,
    messaging_transport => $pulp::consmer::messaging_transport
  }


}
