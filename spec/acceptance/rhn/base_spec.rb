require 'spec_helper'

describe file ('/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT') do
  it { should be_file }
end

describe package ('rhn-org-trusted-ssl-cert-1.0-1') do
  it { should be_installed }
end

describe file ('/etc/sysconfig/rhn/up2date') do
  it { should be_file }
  its(:content) { should match /networkRetries=5/ }
end
