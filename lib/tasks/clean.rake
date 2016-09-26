# frozen_string_literal: true

desc 'Clean artifacts'
task :clean do
  system 'rm -r builds/*'
  system 'rm -r packer-centos*'
  system 'rm -r packer-base*'
  system 'rm -r packer_cache/*'
end
