class profiles::pulp(){

  class { '::pulp':
    broker_url => $broker_url,
    messaging_url => $messaging_url,
    messaging_transport => $messaging_transport
    }
  class { '::pulp::consumer':
    messaging_host => $messaging_host,
    messaging_transport => $messaging_transport
  }
  class { '::pulp::admin':}

}
