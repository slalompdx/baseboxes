#!/bin/bash

if [ -z "${UPDATE_SOURCE}" ]
then
  echo "No UPDATE_SOURCE set. Defaulting to RHN."
  UPDATE_SOURCE="rhn"
fi

if [ "${UPDATE_SOURCE}" == "rhn" ]
then
  if [ -z "${RHN_UNAME}" ] || [ -z "${RHN_PW}" ]
  then
    echo "You must set RHN_UNAME and RHN_PW to register with RHN."
    exit 1
  fi

  subscription-manager register --username $RHN_UNAME --password $RHN_PW
  subscription-manager attach
  subscription-manager repos --enable rhel-7-server-optional-rpms
  yum -y upgrade
elif [ "${UPDATE_SOURCE}" == "satellite" ]
then
  if [ -z "${SATELLITE_SERVER}" ] || [ -z "${SATELLITE_KEY}" ]
  then
    echo "You must set SATELLITE_SERVER and SATELLITE_KEY to register with a private satellite server"
    exit 1
  fi

  wget -O /usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT \
    "http://${SATELLITE_SERVER}/pub/RHN-ORG-TRUSTED-SSL-CERT"

  rpm -Uvh "http://${SATELLITE_SERVER}/pub/rhn-org-trusted-ssl-cert-1.0-1.noarch.rpm"

  sed -i -- 's/enter\.your\.server\.url\.here/pdxlrhssp001\.standard\.com/g' /etc/sysconfig/rhn/up2date

  sed -i -- 's/networkRetries=1/networkRetries=5/g' /etc/sysconfig/rhn/up2date

  /usr/sbin/rhnreg_ks --activationkey "${SATELLITE_KEY}"
fi
