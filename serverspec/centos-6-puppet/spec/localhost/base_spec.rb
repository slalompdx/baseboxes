require 'spec_helper'

describe file('/etc/redhat-release') do
  its(:content) { should_match /CentOS release 6.7/ }
end

describe package('puppet') do
  it { should be_installed.by('rpm').with_version('3.8') }
end

describe package('git') do
  it { should be_installed }
end

describe package('scl-utils') do
  it { should be_installed }
end

describe package('rhscl-rh-ruby22-epel-6-x86_64') do
  it { should be_installed }
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

describe file('/etc/profile') do
  it { should be_file }
  its(:content) { should match /. \/opt\/rh\/rh-ruby22\/enable/ }
end

describe command('ruby --version') do
  its(:stdout) { should match /ruby 2.2.2p/ }
  its(:exit_status) { should eq 0 }
end

describe command('gem --version') do
  its(:stdout) { should match /2.4.5/ }
  its(:exit_status) { should eq 0 }
end

describe command('puppet --version') do
  its(:stdout) { should match /3.8/ }
end
