node 'oracle.vm' {
  
  package {
    ["bc", "libaio", "unixODBC", "unzip", "rlwrap", "dos2unix", "ksh"]:
      ensure => installed;
  }
  
}