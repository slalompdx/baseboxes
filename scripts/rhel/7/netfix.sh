#!/bin/sh -eux

mv /etc/sysconfig/network-scripts/ifcfg-ens33 /etc/sysconfig/network-scripts/ifcfg-ens32
sed -i -e 's/ens33/ens32/' /etc/sysconfig/network-scripts/ifcfg-ens32
