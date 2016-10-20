#!/bin/bash

yum clean all
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
if [ -n "${PUPPET_VERSION}" ];
then
  echo "Installing agent version ${PUPPET_VERSION}"
  yum -y install "puppet-agent-${PUPPET_VERSION}"
else
  echo "Installing latest agent version"
  yum -y install puppet-agent
fi
echo 'PATH=$PATH:/opt/puppetlabs/bin/' >> /etc/profile
ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet
