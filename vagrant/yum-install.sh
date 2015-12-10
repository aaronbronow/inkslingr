#!/usr/bin/env bash
# This script needs to be run as root

# Uncomment if you want to use rpmforge packages
# curl -O http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
# rpm -ivh rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm

# Uncomment if you want to upgrade packages before installing
# yum -y upgrade

curl -O http://yum.postgresql.org/9.2/redhat/rhel-6-x86_64/pgdg-centos92-9.2-6.noarch.rpm
rpm -ivh pgdg-centos92-9.2-6.noarch.rpm

yum -y install vim git-core postgresql92 postgresql92-server postgresql92-contrib postgresql92-devel
service postgresql-9.2 initdb
service postgresql-9.2 start
su - postgres -c "psql postgres -tAc \"SELECT 1 FROM pg_roles WHERE rolname='vagrant'\" | grep -q 1 || createuser -s vagrant"