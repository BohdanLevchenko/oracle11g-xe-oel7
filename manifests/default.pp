node 'oracle.vm' {
  
  package {
    ["bc", "libaio", "unixODBC", "unzip", "rlwrap", "dos2unix", "ksh"]:
      ensure => installed;
  }

  Exec { path  => ['/bin','/usr/bin', '/sbin','/usr/sbin','/usr/local/bin']}
  
}