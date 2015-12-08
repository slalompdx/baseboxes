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
      #run_rake_task
      expect(File).to be_directory(
        "#{toplevel_dir}/packer-centos-6-puppet-virtualbox")
      expect(File).to exist(
        "#{toplevel_dir}/packer-centos-6-puppet-virtualbox/packer-virtualbox-ovf.ovf")
    end

    it 'should produce an importable box artifact' do
      expect(File).to exist(
        "#{toplevel_dir}/builds/centos-6-puppet.virtualbox.box")
      import_vm = capture_stdout { %x{"vagrant box add --force --name spec-centos-6-puppet #{toplevel_dir}/builds/centos-6-puppet.virtualbox.box"} }
      expect($?.exitstatus).to eq(0)
    end

    it 'should be able to be instantiated' do
    end
  end
end
