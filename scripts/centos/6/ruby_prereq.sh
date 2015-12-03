#!/bin/sh

puppet module install covermymeds-ruby
puppet module install stahnma-epel
yum -y install scl-utils
rpm -ivh https://www.softwarecollections.org/en/scls/rhscl/ruby200/epel-6-x86_64/download/rhscl-ruby200-epel-6-x86_64.noarch.rpm
yum clean all
