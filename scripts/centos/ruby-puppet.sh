#!scl enable ruby200 /bin/bash

rpm -qa | grep ruby
scl enable ruby200 "gem install puppet"
scl enable ruby200 "puppet --version"
