#!/bin/bash

cd /vagrant
sudo yum -y install ruby
sudo gem install bundler
sudo bundle install
rake spec
