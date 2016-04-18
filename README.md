#Oracle XE 11g on OEL7

Simple vagrant box with latest available oracle xe edition 11.2.0-1.0 on top of Oracle Enterprise Linux 7.

## Requirements

* You need to have [Vagrant] installed.
* The host machine needs at least 2 GB of RAM.
* The host machine needs to support a 64-bit architecture.

## Installation

* Check out this project:

        git clone https://github.com/bmlevchenko/oracle11g-xe-oel7.git

* Install [vbguest] plugin:

        vagrant plugin install vagrant-vbguest

* Download [Oracle Database 11g Express Edition] for Linux x64. Drop the file
  `oracle-xe-11.2.0-1.0.x86_64.rpm.zip` to the root directory of this project.
  
* Run ```vagrant up``` from the root directory of this project.

#Connecting

You should now be able to connect to the new database at localhost:1521/XE as system with password manager.

From the box itself you can connect using sqlplus:

        sqlplus sys/manager as sysdba
  
[Vagrant]: http://www.vagrantup.com/
[vbguest]: https://github.com/dotless-de/vagrant-vbguest
[Puppet]: http://puppetlabs.com/
[Oracle Database 11g Express Edition]: http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html
