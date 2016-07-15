#!/bin/sh -eux

# register with SIC satellite server

wget -O /usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT \
 http://pdxlrhssp001.standard.com/pub/RHN-ORG-TRUSTED-SSL-CERT

rpm -Uvh http://pdxlrhssp001.standard.com/pub/rhn-org-trusted-ssl-cert-1.0-1.noarch.rpm

sed -i -- 's/enter\.your\.server\.url\.here/pdxlrhssp001\.standard\.com/g' /etc/sysconfig/rhn/up2date

sed -i -- 's/networkRetries=1/networkRetries=5/g' /etc/sysconfig/rhn/up2date

/usr/sbin/rhnreg_ks --activationkey 1-SFGRHEL7X64