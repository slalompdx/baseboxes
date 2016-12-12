require 'spec_helper'

$ruby_packages =
  [
    'rpmdevtools',
    'glibc-devel',
    'readline-devel',
    'libyaml-devel',
    'ncurses-devel',
    'gdbm-devel',
    'tcl-devel',
    'openssl-devel',
    'libffi-devel',
    'make',
    'gcc',
    'unzip',
    'byacc',
    'ruby2'
  ]

$ruby_packages.each do |p|
  describe package(p) do
    it { should be_installed }
  end
end

describe command ('gem list') do
  its(:stdout) { should match /serverspec/ }
  its(:stdout) { should match /bundler/ }
end
