require 'rake'
require 'pty'
require './lib/util'

task :default => [:help]

task :before do
  @http_proxy = ENV['http_proxy'] if ENV['http_proxy']
  @https_proxy = ENV['https_proxy'] if ENV['https_proxy']
end

desc 'Ensure fixtures directory'
file 'fixtures' do
  mkdir 'fixtures'
end

desc 'Download and build Slalom Bento fork'
task :prep_bento do
  Rake::Task['download_bento'].invoke
  Rake::Task['build_base'].invoke
end

desc 'Download Slalom Bento fork'
task :download_bento do
  puts "Downloading bento fork..."
  Rake::Task['fixtures'].invoke
  stream_output "cd fixtures && git clone https://github.com/slalompdx/bento.git && cd .."
end

desc 'Build centos base'
task :build_base do
  puts "Building CentOS base from bento fork..."
  command = "cd fixtures/bento && "
  command << "packer build "
  command << "-var http_proxy=#{@http_proxy} " if @http_proxy
  command << "-var https_proxy=#{@https_proxy} " if @https_proxy
  command << "-only=virtualbox-iso centos-7.1-x86_64.json && "
  command << "cd ../../"
  stream_output command
end

desc 'Clean centos base - Default for clean_iso is false'
task :clean_base, :clean_iso do |task, args|
  puts "Cleaning CentOS base image"
  clean_iso = args[:clean_iso] || 'false'
  stream_output "rm -rf fixtures/bento/packer-centos-7.1-x86_64-virtualbox"
  stream_output "rm -rf fixtures/bento/builds"
  unless clean_iso == 'false'
    puts "Cleaning CentOS ISO"
    stream_output "rm -rf fixtures/bento/packer_cache"
  end
end

desc 'Build specified image'
task :build_image, [:name] do |task, args|
  puts "Building image #{args[:name]}"
  command = "packer build "
  command << "-var http_proxy=#{@http_proxy} " if @http_proxy
  command << "-var https_proxy=#{@https_proxy} " if @https_proxy
  command << "-only=virtualbox-ovf #{args[:name]}.json && "
  command << "mv packer-centos-7.1-puppet-virtualbox/*.vmdk packer-centos-7.1-puppet-virtualbox/packer-virtualbox-ovf-disk1.vmdk && "
  command << "mv packer-centos-7.1-puppet-virtualbox/*.ovf packer-centos-7.1-puppet-virtualbox/packer-virtualbox-ovf.ovf"
  puts command
  stream_output command
end
