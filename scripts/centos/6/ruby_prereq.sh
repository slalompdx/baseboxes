#!/bin/sh

export PATH=/opt/puppetlabs/bin:$PATH

puppet module install covermymeds-ruby
puppet module install stahnma-epel
yum -y install scl-utils
rpm -ivh https://www.softwarecollections.org/en/scls/rhscl/rh-ruby22/epel-6-x86_64/download/rhscl-rh-ruby22-epel-6-x86_64.noarch.rpm
yum clean all
