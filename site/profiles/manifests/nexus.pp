/*
 * profiles::nexus
 */
class profiles::nexus(){

  class { '::nexus':
    version               => $nexus::version,
    revision              => $nexus::revision,
    download_site         => $nexus::download_site,
    nexus_root            => $nexus::nexus_root,
    nexus_type            => $nexus::nexus_type,
    nexus_work_dir_manage => $nexus::nexus_work_dir_manage,
  }
}