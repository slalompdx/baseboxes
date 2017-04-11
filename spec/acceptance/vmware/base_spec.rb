require 'acceptance_spec_helper'

$req_packages = [
  'libXinerama',
  'libXcursor',
  'libXtst',
  'libXi',
  'libX11',
  'libXext',
  'unzip'
]

$req_packages.each do |p|
  describe package(p) do
    it { should be_installed }
  end
end

describe file ('/usr/local/sbin/packer') do
  it { should be_file }
  it { should be_executable }
end

describe service ('/usr/sbin/vmware-authdlauncher') do
  it { should be_running }
end
