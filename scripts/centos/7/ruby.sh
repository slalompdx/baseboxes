#!/bin/sh

cat > /etc/yum.repos.d/slalompdx_ruby.repo <<EOH
[slalompdx_ruby]
name=slalompdx_ruby
baseurl=https://packagecloud.io/slalompdx/ruby/el/7/\$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/slalompdx/ruby/gpgkey
metadata_expire=300

[slalompdx_ruby-source]
name=slalompdx_ruby-source
baseurl=https://packagecloud.io/slalompdx/ruby/el/7/SRPMS
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/slalompdx/ruby/gpgkey
metadata_expire=300
EOH

yum clean all

sudo yum -y install ruby2-2.3.1-1.el7.centos.x86_64