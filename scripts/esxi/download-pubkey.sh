#!/bin/sh -eux

pubkey_url="https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub";
if command -v wget >/dev/null 2>&1; then
    wget --no-check-certificate "$pubkey_url" -O http/vagrant.pub
elif command -v curl >/dev/null 2>&1; then
    curl --insecure --location "$pubkey_url" > http/vagrant.pub
elif command -v fetch >/dev/null 2>&1; then
    fetch -am -o http/vagrant.pub "$pubkey_url";
else
    echo "Cannot download vagrant public key";
    exit 1;
fi
