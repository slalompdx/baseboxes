#!/bin/bash

yum clean all
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
yum -y upgrade
yum -y install puppet
