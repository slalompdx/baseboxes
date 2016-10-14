#!/bin/sh -eux

# set a default HOME_DIR environment variable if not set
HOME_DIR="${HOME_DIR:-/home/vagrant}";

case "$PACKER_BUILDER_TYPE" in

virtualbox-iso|virtualbox-ovf)
    mkdir -p /tmp/vbox;
    ver="`cat /home/vagrant/.vbox_version`";
    mount -o loop $HOME_DIR/VBoxGuestAdditions_${ver}.iso /tmp/vbox;
    sh /tmp/vbox/VBoxLinuxAdditions.run \
        || echo "VBoxLinuxAdditions.run exited $? and is suppressed." \
            "For more read https://www.virtualbox.org/ticket/12479";
    umount /tmp/vbox;
    rm -rf /tmp/vbox;
    rm -f $HOME_DIR/*.iso;
    ;;

vmware-iso|vmware-vmx)
    mkdir -p /tmp/vmfusion;
    mkdir -p /tmp/vmfusion-archive;
    mount -o loop $HOME_DIR/linux.iso /tmp/vmfusion;
    tar xzf /tmp/vmfusion/VMwareTools-*.tar.gz -C /tmp/vmfusion-archive;
    yum -y install gcc kernel-devel;
cat > /tmp/answer << __ANSWER__
yes
yes
/usr/bin
/etc/rc.d
/etc/rc.d/init.d
/usr/sbin
/usr/lib/vmware-tools
yes
/usr/lib
/var/lib
/usr/share/doc/vmware-tools
yes
yes
yes
no
no
no
yes
no

__ANSWER__
    /tmp/vmfusion-archive/vmware-tools-distrib/vmware-install.pl < /tmp/answer;
    sed -i '/answer AUTO_KMODS_ENABLED no/c\answer AUTO_KMODS_ENABLED yes' /etc/vmware-tools/locations
    umount /tmp/vmfusion;
    rm -rf  /tmp/vmfusion;
    rm -rf  /tmp/vmfusion-archive;
    rm -f $HOME_DIR/*.iso;
    ;;

parallels-iso|parallels-pvm)
    mkdir -p /tmp/parallels;
    mount -o loop $HOME_DIR/prl-tools-lin.iso /tmp/parallels;
    /tmp/parallels/install --install-unattended-with-deps \
      || (code="$?"; \
          echo "Parallels tools installation exited $code, attempting" \
          "to output /var/log/parallels-tools-install.log"; \
          cat /var/log/parallels-tools-install.log; \
          exit $code);
    umount /tmp/parallels;
    rm -rf /tmp/parallels;
    rm -f $HOME_DIR/*.iso;
    ;;

qemu)
    echo "Don't need anything for this one"
    ;;

*)
    echo "Unknown Packer Builder Type >>$PACKER_BUILDER_TYPE<< selected.";
    echo "Known are virtualbox-iso|virtualbox-ovf|vmware-iso|vmware-vmx|parallels-iso|parallels-pvm.";
    ;;

esac
