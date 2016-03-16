#!/bin/bash

cd /vagrant
sudo yum -y install ruby rubygems
sudo gem install bundler
sudo su - -c "cd /vagrant && bundle install"
rake spec
