node 'oracle.vm' {
  
  package {
    ["bc", "libaio", "unixODBC", "unzip", "rlwrap", "dos2unix", "ksh"]:
      ensure => installed;
  }

  Exec { path  => ['/bin','/usr/bin', '/sbin','/usr/sbin','/usr/local/bin']}
  
  exec {
    "create swapfile":
      command => "dd if=/dev/zero of=/swapfile bs=1M count=1024",
      creates => "/swapfile";
    "set up swapfile":
      command => "mkswap /swapfile",
      require => Exec["create swapfile"],
      unless => "file /swapfile | grep 'swap file' 2>/dev/null";
    "enable swapfile":
      command => "swapon /swapfile",
      require => Exec["set up swapfile"],
      unless => "cat /proc/swaps | grep '^/swapfile' 2>/dev/null";
    "add swapfile entry to fstab":
      command => "echo >>/etc/fstab /swapfile swap swap defaults 0 0",
      unless => "grep '^/swapfile' /etc/fstab 2>/dev/null";
  }

}