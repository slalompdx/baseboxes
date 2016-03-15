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
  if ENV['http_proxy']
    http_proxy = ENV['http_proxy']
  elsif ENV['HTTP_PROXY']
    http_proxy = ENV['HTTP_PROXY']
  end
  if ENV['https_proxy']
    https_proxy = ENV['https_proxy']
  elsif ENV['HTTPS_PROXY']
    https_proxy = ENV['HTTPS_PROXY']
  end
  if ENV['no_proxy']
    no_proxy = ENV['no_proxy']
  elsif ENV['NO_PROXY']
    no_proxy = ENV['NO_PROXY'}
  end
  vars = ''
  vars << "http_proxy=#{ENV['http_proxy']} " if http_proxy
  vars << "https_proxy=#{ENV['https_proxy']} " if https_proxy
  vars << "no_proxy=#{ENV['no_proxy']} " if no_proxy
  vars
end

def list_builds
  Rake.application.rake_require 'tasks/build'
  Rake.application.rake_require 'tasks/list'
  Rake::Task['list'].reenable
  capture_stdout { Rake::Task['list'].invoke }.split(/\n/)
end

tasks = []

describe 'build task' do
  before :all do
    Rake.application.rake_require 'tasks/build'
    Rake.application.rake_require 'tasks/list'
  end

  list_builds.each do |task|
    if ENV['BOX_BUILD']
      puts "BOX_BUILD set, skipping #{task}"
      next unless ENV['BOX_BUILD'] == task
    end
    describe "build #{task}" do
      let :run_rake_task do
        if ENV['BOX_OVERRIDE']
          puts "BOX_OVERRIDE set; skipping build..."
        else
          Rake::Task['build'].reenable
          Rake::Task['build'].invoke(task)
        end
      end

      it "should build #{task} artifacts" do
        run_rake_task
        expect(File).to be_directory(
          "#{toplevel_dir}/packer-#{task}-virtualbox")
        expect(File).to exist(
          "#{toplevel_dir}/packer-#{task}-virtualbox/packer-virtualbox-ovf.ovf")
      end

      it 'should produce an importable box artifact' do
        expect(File).to exist(
          "#{toplevel_dir}/builds/#{task}.virtualbox.box")
        capture_stdout { %x(vagrant box add --force --name spec-#{task} #{toplevel_dir}/builds/#{task}.virtualbox.box) }
        expect($CHILD_STATUS.exitstatus).to be(0)
      end

      describe "#{task} box" do
        workingdir = "#{toplevel_dir}/serverspec/#{task}"
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
end
