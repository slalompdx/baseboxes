require 'spec_helper'

describe file('/etc/ssh/keys-root/authorized_keys') do
  it { should be_file }
end

describe user('vagrant') do
  it { should exist }
end

describe command('esxcli network firewall ruleset list') do
  its(:stdout) { should match /httpClient\s*true/ }
end

describe command('esxcli system settings advanced list -o /Net/GuestIPHack') do
  its(:stdout) { should match /Path: \/Net\/GuestIPHack/ }
  its(:stdout) { should match /Path: \/Net\/FollowHardwareMac/ }
end

describe command('esxcli software vib list') do
  its(:stdout) { should match /esx-tools-for-esxi/ }
  its(:stdout) { should match /esxui-signed/ }
end

describe file('/etc/rc.local.d/local.sh') do
  it { should be_file }
end

describe file('/etc/vmware.esx.conf') do
  it { should be_file }
  its(:content) { should match /uuid/ }
end
