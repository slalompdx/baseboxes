#!/bin/bash

yum clean all
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
yum -y install puppet
