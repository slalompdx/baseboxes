#!/bin/sh

puppet module install jdowning-rbenv
puppet module install rtyler-jenkins
puppet module install puppetlabs-firewall
puppet module install puppetlabs-java
yum clean all
