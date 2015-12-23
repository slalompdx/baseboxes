require 'spec_helper'

describe file('/etc/redhat-release') do
  its(:content) { should_match /CentOS release 6.7/ }
end

describe file('/etc/puppet/modules/rbenv') do
  it { should be_directory }
end

describe file('/etc/puppet/modules/stdlib') do
  it { should be_directory }
end

describe package('bundler') do
  it { should be_installed.by('gem').with_version('1.10.6') }
end

describe package('rake') do
  it { should be_installed.by('gem').with_version('10.4.2') }
end

describe package('serverspec') do
  it { should be_installed.by('gem').with_version('2.24.3') }
end

describe command('ruby --version') do
  its(:stdout) { should match /ruby 2.2.2p/ }
  its(:exit_status) { should eq 0 }
end

describe command('gem --version') do
  its(:stdout) { should match /2.4.5/ }
  its(:exit_status) { should eq 0 }
end
