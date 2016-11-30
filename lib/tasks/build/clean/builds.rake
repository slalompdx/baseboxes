# frozen_string_literal: true

namespace :clean do
  desc 'Clean all builds'
  task :builds do
    puts 'Cleaning builds'
    system 'rm builds/*'
    system 'rm -rf packer-centos-6-*'
    system 'rm -rf packer-centos-7-*'
  end
end
