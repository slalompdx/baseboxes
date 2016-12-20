require 'spec_helper'

describe package ('puppet-agent'), :if => os[:osfamily] == 'redhat' do
  it { should be_installed }
end

describe file ('/etc/profile'), :if => os[:osfamily] == 'redhat' do
  it { should be_file }
  its(:content) { should match /PATH=\$PATH:\/opt\/puppetlabs\/bin\// }
end

describe file ('/usr/bin/puppet'), :if => os[:osfamily] == 'redhat' do
  it { should be_symlink }
end

describe command ('choco list --local-only'), :if => os[:osfamily] == 'windows' do
  its(:stdout) { should match /puppet/ }
end
