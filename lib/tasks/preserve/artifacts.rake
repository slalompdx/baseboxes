namespace :preserve do
  desc 'Preserve artifacts'
  task :artifacts do
    puts 'Preserving artifacts'
    system 'mkdir -p artifacts/'
    puts 'Preserving builds directory'
    system 'cp -r builds/ artifacts/builds'
    puts 'Preserving raw packer builds'
    system 'cp -r packer-centos* artifacts/'
    puts 'Preserving raw OS images builds'
    system 'cp -r packer_cache/ artifacts/'
  end
end
