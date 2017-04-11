require 'acceptance_spec_helper'

include_examples 'ruby::init'

$dev_tools = [
  'zlib-devel',
  'make',
  'gettext',
  'binutils',
  'automake',
  'frysk',
  'rcs',
  'strace',
  'elfutils',
  'gcc',
  'libtool',
  'pfmon',
  'systemtap'
]

$dev_tools.each do |p|
  describe package(p) do
    it { should be_installed }
  end
end
