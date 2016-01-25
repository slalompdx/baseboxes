namespace :restore do
  desc 'Restore artifacts'
  task :artifacts do
    puts 'Restoring artifacts'
    puts 'Restoring builds directory'
    system 'cp -r artifacts/builds/* builds/'
    puts 'Restoring raw packer builds'
    system 'cp -r artifacts/packer-centos-6-* .'
    system 'cp -r artifacts/packer-centos-7-* .'
    puts 'Restoring raw bento builds'
    system 'cp -r artifacts/packer_cache/*.iso packer_cache/'
  end
end
