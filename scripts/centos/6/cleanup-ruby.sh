#!/bin/sh -eux

# Remove development and kernel source packages
sudo rm -rf ~/rpmbuild
sudo yum -y remove rpmdevtools glibc-devel readline-devel libyaml-devel ncurses-devel gdbm-devel tcl-devel openssl-devel compat-db47 libffi-devel gcc unzip byacc
