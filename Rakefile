require 'rake'
require 'pty'
require './lib/util'

def old_packer_command_builder(version = 7)
  command = ['packer build']
  command << "-var http_proxy=#{ENV['http_proxy']}" if ENV['http_proxy']
  command << "-var https_proxy=#{ENV['https_proxy']}" if ENV['https_proxy']
  command << '-only=virtualbox-iso'
  case version.to_i
  when 6 then command << 'centos-6.7-x86_64.json'
  when 7 then command << 'centos-7.1-x86_64.json'
  end
  command.join(' ')
end

def new_packer_command_builder(args = {})
  defaults = {
    format: 'iso',
    box: 'centos-7.1-x86_64',
    force: ENV['force'] || false
  }

  actual = defaults.merge(args)

  command = ['packer build']
  command << '--force' if actual[:force]
  command << "-var http_proxy=#{ENV['http_proxy']}" if ENV['http_proxy']
  command << "-var https_proxy=#{ENV['https_proxy']}" if ENV['https_proxy']
  command << "-only=virtualbox-#{actual[:format]}"
  command << "#{actual[:box]}.json"
  command.join(' ')
end

def build_packer_command(args = {})
  if args.is_a?(Fixnum)
    old_packer_command_builder(args)
  elsif args.is_a?(Hash)
    new_packer_command_builder(args)
  end
end

task :before do
  @http_proxy = ENV['http_proxy'] if ENV['http_proxy']
  @https_proxy = ENV['https_proxy'] if ENV['https_proxy']
end

desc 'Ensure fixtures directory'
file 'fixtures' do
  mkdir 'fixtures'
end

desc 'Ensure artifacts directory'
file 'artifacts' do
  mkdir 'artifacts'
end

desc 'Download and build Slalom Bento fork'
task :prep_bento do
  Rake::Task['download_bento'].invoke
  Rake::Task['build_base'].invoke
end

desc 'Download Slalom Bento fork'
task :download_bento do
  bento_fork_url = 'https://github.com/slalompdx/bento.git'
  puts 'Downloading bento fork...'
  Rake::Task['fixtures'].invoke
  Dir.chdir('fixtures') do
    system "git clone #{bento_fork_url}" unless File.directory?('bento')
    Dir.chdir('bento') { system 'git pull origin master --rebase' }
  end
end

desc 'Build centos base - Default for version is both, use both, 6 or 7'
task :build_base, :version do |_task, args|
  version = args[:version] || %w(6 7)
  abort '"both" is deprecated as an explicit argument' if version == 'both'
  Dir.chdir('fixtures/bento') do
    system 'git checkout master'
    system 'git reset --hard HEAD'

    if version.include? '7'
      stream_output build_packer_command(box: 'centos-7.1-x86_64', force: true)
    end

    if version.include? '6'
      stream_output build_packer_command(box: 'centos-6.7-x86_64', force: true)
    end
  end
end

desc 'Preserve artifacts'
task :preserve_artifacts do
  puts 'Preserving artifacts'
  Rake::Task['artifacts'].invoke
  system 'cp -r builds/ artifacts/builds'
  system 'cp -r packer-centos* artifacts/'
  system 'cp -r fixtures/bento/packer-centos* artifacts/'
end

desc 'Clean all builds and bento images'
task :clean do
  puts 'Cleaning builds and bento images'
  system 'rm builds/*'
  system 'rm -rf packer-centos-6-*'
  system 'rm -rf packer-centos-7-*'
  Rake::Task['clean_base'].invoke
end

desc 'Clean centos base - Default for clean_iso is false'
task :clean_base, :clean_iso do |_task, args|
  puts 'Cleaning CentOS base image'
  clean_iso = args[:clean_iso] || 'false'
  system 'rm -rf fixtures/bento/packer-centos-7.1-x86_64-virtualbox'
  system 'rm -rf fixtures/bento/packer-centos-6.7-x86_64-virtualbox'
  system 'rm -rf fixtures/bento/builds'
  unless clean_iso == 'false'
    puts 'Cleaning CentOS ISO'
    system 'rm -rf fixtures/bento/packer_cache'
  end
end

desc 'Build specified image'
task :build, [:name] do |_task, args|
  puts "Building image #{args[:name]}"
  stream_output build_packer_command(format: 'ovf', box: args[:name])
  command = "mv packer-#{args[:name]}-virtualbox/*.ovf " \
    "packer-#{args[:name]}-virtualbox/packer-virtualbox-ovf.ovf"
  stream_output command
end
