#!/bin/bash

export http_proxy='http://proxy.standard.com:8080'
export https_proxy='http://proxy.standard.com:8080'
export HTTP_PROXY='http://proxy.standard.com:8080'
export HTTPS_PROXY='http://proxy.standard.com:8080'
yum clean all
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
yum -y install puppet
