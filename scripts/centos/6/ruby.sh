#!/bin/sh

curl -s https://packagecloud.io/install/repositories/slalompdx/ruby/script.rpm.sh | sudo bash
sudo yum -y install ruby2-2.3.1-1.el6.x86_64
