require 'spec_helper'

$sunpacks = [
  'SUNWwgetr',
  'SUNWwgetu',
  'SUNWgss',
  'SUNWgssk',
  'SUNWgssc',
  'SUNWsshdr',
  'SUNWsshdu',
  'SUNWsshcu',
  'SUNWsshr',
  'SUNWsshu',
  'SUNWgcmn',
  'SUNWuiu8',
  'SUNWbash',
  'SUNWarc',
  'SUNWhea',
  'SUNWlibm',
  'SUNWscpu',
  'SUNWlibm',
  'SUNWlibmr',
  'SUNWlibms',
  'SUNWlibmsr',
  'SUNWggrp',
  'SUNWscpr',
  'SUNWscpu',
  'SUNWgcc',
  'SUNWgccruntime',
  'SUNWgtar',
  'SUNWtoo',
  'SUNWgmake'
]

$sunpacks.each do |t|
  describe package(t) do
    it { should be_installed }
  end
end

describe file('/etc/passwd') do
  it { should be_file }
end

describe user('vagrant') do
  it { should exist }
end

describe file ('/home/vagrant/.ssh') do
  it { should be_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_mode '0660' }
end

describe file ('/home/vagrant/.ssh/authorized_keys') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_mode '0660' }
  its(:content) { should match /ssh-rsa/ }
end

describe port(22) do
  it { should be_listening }
end

describe file('/home/vagrant') {
  it { should be_directory }
}

describe file ('/etc/release') do
  it { should be_file }
  its(:content) { should match /Oracle Solaris 10/ }
end

describe file ('/etc/ssh/sshd_config') do
  it { should be_file }
  its(:content) { should match /UseDNS no/ }
  its(:content) { should match /GSSAPIAuthentication no/ }
end

describe file ('/etc/sudoers') do
  it { should be_file }
  its(:content) { should match /vagrant ALL=(ALL) NOPASSWD: ALL/ }
  its(:content) { should match /Defaults secure_path=/ }
end
