require 'spec_helper'
require 'rake'
require 'English'

def build_ssh_config(workingdir)
  Dir.chdir(workingdir) do
    ssh_config = `vagrant ssh-config`.split(/\n/)
    ssh_config.map! { |x| x.strip.split(/ /) }
    ssh_config.to_h
  end
end

def build_env_vars
  vars = ""
  vars << "http_proxy=#{ENV['http_proxy']} " if ENV['http_proxy']
  vars << "https_proxy=#{ENV['https_proxy']} " if ENV['https_proxy']
  vars << "no_proxy=#{ENV['no_proxy']} " if ENV['no_proxy']
  vars
end

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
      workingdir = "#{toplevel_dir}/serverspec/centos-6-puppet"
      before(:each) do
        Dir.chdir(workingdir)
      end
      after(:each) do
        Dir.chdir(toplevel_dir)
      end
      after(:all) do
        Dir.chdir(workingdir) do
          system 'vagrant destroy -f'
        end
      end

      it 'should be able to be instantiated' do
        capture_stdout { %x(vagrant up --provider virtualbox) }
        expect($CHILD_STATUS.exitstatus).to be(0)
      end

      it 'should produce a working ssh configuration' do
        capture_stdout { %x(#{build_ssh_command build_ssh_config(workingdir)} "ls") }
        expect($CHILD_STATUS.exitstatus).to be(0)
      end

      it 'should successfully pass serverspec' do
        Dir.chdir("#{toplevel_dir}/serverspec/") do
          run_serverspec = system "#{build_ssh_command build_ssh_config(workingdir)} #{build_env_vars} /vagrant/serverspec.sh"
          expect(run_serverspec).to be true
        end
      end
    end
  end
end
