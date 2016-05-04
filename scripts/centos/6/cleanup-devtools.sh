#!/bin/sh -eux

# Remove development and kernel source packages
yum -y remove gcc cpp kernel-devel kernel-headers;
