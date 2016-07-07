#!/bin/bash

yum clean all
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
yum -y install puppet-agent
echo 'PATH=$PATH:/opt/puppetlabs/bin/' >> /etc/profile
ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet
