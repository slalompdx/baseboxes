desc 'Clean artifacts'
task :clean do
  system 'rm -r builds/*'
  system 'rm -r packer-centos*'
  system 'rm -r packer-centos*'
  system 'rm -r packer_cache/*'
end
