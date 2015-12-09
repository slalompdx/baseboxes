require 'spec_helper'
require 'rake'
require 'English'

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
      expect(File).to be_directory(
        "#{toplevel_dir}/packer-centos-6-puppet-virtualbox")
      expect(File).to exist(
        "#{toplevel_dir}/packer-centos-6-puppet-virtualbox/packer-virtualbox-ovf.ovf")
    end

    it 'should produce an importable box artifact' do
      expect(File).to exist(
        "#{toplevel_dir}/builds/centos-6-puppet.virtualbox.box")
      capture_stdout { %x(vagrant box add --force --name spec-centos-6-puppet #{toplevel_dir}/builds/centos-6-puppet.virtualbox.box) }
      expect($CHILD_STATUS.exitstatus).to be(0)
    end

    describe 'centos-6-puppet box' do
      before(:each) do
        Dir.chdir("#{toplevel_dir}/fixtures/vagrant/centos-6-puppet")
      end
      after(:each) do
        Dir.chdir(toplevel_dir)
      end

      it 'should be able to be instantiated' do
        capture_stdout { %x(vagrant up --provider virtualbox) }
        expect($CHILD_STATUS.exitstatus).to be(0)
      end
      it 'should produce a working ssh configuration' do
        ssh_config = `vagrant ssh-config`.split(/\n/)
        ssh_config.map! { |x| x.strip.split(/ /) }
        ssh_config = ssh_config.to_h
        capture_stdout { %x(ssh -o StrictHostKeyChecking=no -i #{ssh_config['IdentityFile']} -p #{ssh_config['Port']} #{ssh_config['User']}@#{ssh_config['HostName']}i 'ls') }
        expect($CHILD_STATUS.exitstatus).to be(0)
      end
    end
  end
end
