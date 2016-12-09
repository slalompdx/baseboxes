require 'spec_helper'

describe package ('puppet-agent') do
  it { should be_installed }
end

describe file ('/etc/profile') do
  it { should be_file }
  its(:content) { should match /PATH=\$PATH:\/opt\/puppetlabs\/bin\// }
end

describe file ('/usr/bin/puppet') do
  it { should be_symlink }
end
