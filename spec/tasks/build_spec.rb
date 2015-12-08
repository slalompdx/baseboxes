require 'spec_helper'
require 'rake'

describe 'build task' do
  before :all do
    Rake.application.rake_require 'tasks/build'
  end

  describe 'build centos-6-puppet' do
    let :run_rake_task do
      Rake::Task['build'].reenable
      Rake::Task['build'].invoke('centos-6-puppet')
    end

    it 'should build centos-6-puppet artifacts' do
      run_rake_task
      expect(File).to be_directory('packer-centos-6-puppet-virtualbox')
      expect(File).to exist(
        'packer-centos-6-puppet-virtualbox/packer-virtuabox-ovf.ovf')
    end
  end
end
