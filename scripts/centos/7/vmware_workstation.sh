#!/bin/bash

yum -y install libXinerama libXcursor libXtst libXi libX11 libXext unzip
wget https://releases.hashicorp.com/packer/0.10.1/packer_0.10.1_linux_amd64.zip
unzip packer_*
mv packer /usr/local/sbin
wget https://s3-us-west-2.amazonaws.com/slalompdx/bin/VMware-Workstation-Full-12.1.1-3770994.x86_64.bundle
sh VMware-Workstation-*.bundle --console --required --eulas-agreed
