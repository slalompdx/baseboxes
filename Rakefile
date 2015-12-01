require 'rake'
require 'pty'
require './lib/util'

# task :default => [:help]

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
  puts 'Downloading bento fork...'
  Rake::Task['fixtures'].invoke
  stream_output 'cd fixtures && ' \
                'git clone https://github.com/slalompdx/bento.git && cd ..'
end

desc 'Build centos base - Default for version is both, use both, 6 or 7'
task :build_base, :version do |_task, args|
  version = args[:version] || 'both'
  command_base = 'cd fixtures/bento && '
  command_base << 'git checkout master && '
  command_base << 'git reset --hard HEAD && '
  command_base << 'packer build '
  command_base << "-var http_proxy=#{@http_proxy} " if @http_proxy
  command_base << "-var https_proxy=#{@https_proxy} " if @https_proxy
  if version == 'both' || version == '6'
    puts 'Building CentOS base from bento fork...'
    command = command_base
    command << '-only=virtualbox-iso centos-6.7-x86_64.json && '
    command << 'cd ../../'
    stream_output command
  end
  if version == 'both' || version == '7'
    puts 'Building CentOS base from bento fork...'
    command = command_base
    command << '-only=virtualbox-iso centos-7.1-x86_64.json && '
    command << 'cd ../../'
    stream_output command
  end
end

desc 'Preserve artifacts'
task :preserve_artifacts do
  puts 'Preserving artifacts'
  Rake::Task['artifacts'].invoke
  stream_output 'cp -r builds/ artifacts/builds'
  stream_output 'cp -r packer-centos* artifacts/'
  stream_output 'cp -r fixtures/bento/packer-centos* artifacts/'
end

desc 'Clean all builds and bento images'
task :clean do
  puts 'Cleaning builds and bento images'
  stream_output 'rm -rf builds/*'
  stream_output 'rm -rf packer-centos-6-*'
  stream_output 'rm -rf packer-centos-7-*'
  Rake::Task['clean_base'].invoke
end

desc 'Clean centos base - Default for clean_iso is false'
task :clean_base, :clean_iso do |_task, args|
  puts 'Cleaning CentOS base image'
  clean_iso = args[:clean_iso] || 'false'
  stream_output 'rm -rf fixtures/bento/packer-centos-7.1-x86_64-virtualbox'
  stream_output 'rm -rf fixtures/bento/packer-centos-6.7-x86_64-virtualbox'
  stream_output 'rm -rf fixtures/bento/builds'
  unless clean_iso == 'false'
    puts 'Cleaning CentOS ISO'
    stream_output 'rm -rf fixtures/bento/packer_cache'
  end
end

desc 'Build specified image'
task :build, [:name] do |_task, args|
  puts "Building image #{args[:name]}"
  command = 'packer build '
  command << "-var http_proxy=#{@http_proxy} " if @http_proxy
  command << "-var https_proxy=#{@https_proxy} " if @https_proxy
  command << "-only=virtualbox-ovf #{args[:name]}.json && "
  command << "mv packer-#{args[:name]}-virtualbox/*.ovf " \
    "packer-#{args[:name]}-virtualbox/packer-virtualbox-ovf.ovf"
  puts command
  stream_output command
end
