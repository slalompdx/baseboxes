#!/bin/bash

if [ -z "${RHN_UNAME}" ] || [ -z "${RHN_PW}" ]
then
  echo "You must set RHN_UNAME and RHN_PW to register with RHN."
  exit 1
fi

subscription-manager register --username $RHN_UNAME --password $RHN_PW
subscription-manager attach
subscription-manager repos --enable rhel-7-server-optional-rpms
yum -y upgrade
