require 'rake'

task :default => [:help]

desc 'Download and build Slalom Bento fork'
task :prep_bento do
  Rake::Task['download_bento'].invoke
  Rake::Task['build_base'].invoke
end

desc 'Download Slalom Bento fork'
task :download_bento, [:proxy] do |task, args|
  puts "Downloading bento fork..."
  puts task
  puts args
  `git clone https://github.com/slalompdx/bento.git`
end

desc 'Build centos base'
task :build_base do
  puts "Building CentOS base from bento fork..."
  `cd bento && packer build -only=virtualbox-iso centos-7.1-x86_64.json && cd ..`
end
