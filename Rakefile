require 'rake'
require 'pty'
require './lib/util'

task :default => [:help]

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
task :download_bento, [:proxy] do |task, args|
  puts "Downloading bento fork..."
  Rake::Task['fixtures'].invoke
  stream_output "cd fixtures && git clone https://github.com/slalompdx/bento.git && cd .."
end

desc 'Build centos base'
task :build_base do
  puts "Building CentOS base from bento fork..."
  stream_output "cd fixtures/bento && packer build -only=virtualbox-iso centos-7.1-x86_64.json && cd ../.."
end
