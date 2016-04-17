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
    "unzip xe":
      command => "unzip -o /vagrant/oracle-xe-11.2.0-1.0.x86_64.rpm.zip",
      require => [Package["unzip"]],
      cwd => "/home/vagrant",
      creates => "/home/vagrant/Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm",
      timeout => 3600,
      unless => "test -f /etc/sysconfig/oracle-xe";

    "install xe":
      command => "rpm -ivh Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm",
      cwd => "/home/vagrant",
      require => [Exec["unzip xe"]],
      timeout => 3600,
      unless => "test -f /etc/init.d/oracle-xe";
    "configure xe":
      command => "/etc/init.d/oracle-xe configure responseFile=/tmp/xe.rsp >> /tmp/xe-install.log",
      timeout => 3600,
      require => [Exec["install xe"],
                  Exec["enable swapfile"],
                  Exec["dos2unix xe.rsp"],
                  Exec["dos2unix oracle-env.sh"]],
      unless => "test -f /etc/sysconfig/oracle-xe";
    "dos2unix oracle-env.sh":
      command => "dos2unix -n /vagrant/oracle-env.sh /etc/profile.d/oracle-env.sh && chmod a+r /etc/profile.d/oracle-env.sh",
      creates => "/etc/profile.d/oracle-env.sh",
      require => [Package["dos2unix"]];
    "dos2unix xe.rsp":
      command => "dos2unix -n /vagrant/xe.rsp /tmp/xe.rsp",
      creates => "/tmp/xe.rsp",
      require => [Package["dos2unix"]];
  }

  file {
    "/swapfile":
      mode => 600,
      owner => root,
      group => root,
      require => Exec['create swapfile'];
  }
}