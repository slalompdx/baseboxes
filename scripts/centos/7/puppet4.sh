#!/bin/bash

sudo yum clean all
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum -y install puppet-agent
sudo "echo 'PATH=$PATH:/opt/puppetlabs/bin/' >> /etc/profile"
