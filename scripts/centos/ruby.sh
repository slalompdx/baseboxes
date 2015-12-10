#!/bin/sh

puppet apply -v /tmp/ruby.pp
echo ". /opt/rh/rh-ruby22/enable" >> /etc/profile
