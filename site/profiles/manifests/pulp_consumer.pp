class profiles::pulp_consumer(){

  class { '::pulp::consumer':
    host => $host,
    messaging_host => $messaging_host,
    messaging_transport => $messaging_transport
  }


}
