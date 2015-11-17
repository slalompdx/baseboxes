#!/bin/sh

export http_proxy=http://proxy.standard.com:8080
export https_proxy=http://proxy.standard.com:8080
export HTTP_PROXY=http://proxy.standard.com:8080
export HTTPS_PROXY=http://proxy.standard.com:8080
puppet module install rtyler-jenkins
puppet module install puppetlabs-firewall
puppet module install puppetlabs-java
