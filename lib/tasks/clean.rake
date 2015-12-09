desc 'Clean artifacts'
task :clean do
  system 'rm -r builds/*'
  system 'rm -r packer-centos*'
  system 'rm -r ext/bento/packer-centos*'
  system 'rm -r ext/bento/packer_cache/*'
end
