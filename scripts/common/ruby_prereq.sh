#!/bin/bash

export http_proxy=http://proxy.standard.com:8080
export https_proxy=http://proxy.standard.com:8080
export HTTP_PROXY=http://proxy.standard.com:8080
export HTTPS_PROXY=http://proxy.standard.com:8080
puppet module install puppetlabs-stdlib
puppet module install jdowning-rbenv
