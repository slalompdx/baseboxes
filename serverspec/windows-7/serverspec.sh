#!/bin/bash -x

cd /vagrant
sudo yum -y install centos-release-SCL centos-release-scl-rh
sudo yum -y install rh-ruby22
sudo sh -c "echo '#!/bin/bash' > /etc/profile.d/enableruby22.sh"
sudo sh -c "echo 'source scl_source enable rh-ruby22' >> /etc/profile.d/enableruby22.sh"
sudo sh -c "scl enable rh-ruby22 'gem install bundler'"
sudo sh -c "cd /vagrant && scl enable rh-ruby22 '/opt/rh/rh-ruby22/root/usr/local/bin/bundle install'"
sudo sh -c "cd /vagrant && scl enable rh-ruby22 '/opt/rh/rh-ruby22/root/usr/local/bin/rake spec'"
