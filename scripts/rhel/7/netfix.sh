#!/bin/sh -eux
# this script is not needed anymore
# the fix is to pass net.ifnames and biosdevname to boot cmd
# keeping this script for posterity

mv /etc/sysconfig/network-scripts/ifcfg-ens33 /etc/sysconfig/network-scripts/ifcfg-ens32
sed -i -e 's/ens33/ens32/' /etc/sysconfig/network-scripts/ifcfg-ens32

yum -y remove biosdevname

#grub grub grub
sed "s/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX=\"crashkernel=auto rd.lvm.lv=rhel\/root rd.lvm.lv=rhel\/swap rhgb quiet net.ifnames=0 biosdevname=0\"/g" /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

cat > /etc/grub.d/40_custom <<EOH
net.ifnames=0
biosdevname=0
EOH