#!/bin/sh
# using software collections 2.3.0

subscription-manager register --username terrih-1 \
  --password 'k0\AJNM[hhW#'  --auto-attach

subscription-manager repos --enable rhel-server-rhscl-7-rpms

yum -y install rh-ruby23 scl-utils

#/bin/scl enable rh-ruby23 bash
echo "source scl_source enable rh-ruby23" >> /etc/profile