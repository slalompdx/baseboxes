require 'spec_helper'

describe file('/etc/passwd') do
  it { should be_file }
end

describe user('vagrant') do
  it { should exist }
  its(:encrypted_password) { should match(/^\$6\$.{16}\$.{86}$/) }
end

describe file ('/home/vagrant/.ssh') do
  it { should be_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_mode '0700' }
end

describe file ('/home/vagrant/.ssh/authorized_keys') do
  it { should be_file }
  it { should be_owned_by 'vagrant' }
  it { should be_mode '0660' }
  its(:content) { should match /ssh-rsa/ }
end

describe port(22) do
  it { should be_listening }
end

describe file('/home/vagrant') {
  it { should be_directory }
}

describe file ('/etc/redhat-release') do
  it { should be_file }
  its(:content) { should match /CentOS release 6.7 (Final)/ }
end

describe file ('/etc/ssh/sshd_config') do
  it { should be_file }
  its(:content) { should match /UseDNS no/ }
  its(:content) { should match /GSSAPIAuthentication no/ }
end
