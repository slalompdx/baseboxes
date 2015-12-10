namespace :preserve do
  desc 'Preserve artifacts'
  task :artifacts do
    puts 'Preserving artifacts'
    Rake::FileTask['artifacts'].invoke
    puts "Preserving builds directory"
    system 'cp -r builds/ artifacts/builds'
    puts "Preserving raw packer builds"
    system 'cp -r packer-centos* artifacts/'
    puts "Preserving bento builds"
    system 'cp -r ext/bento/packer-centos* artifacts/'
    puts "Preserving raw bento builds"
    system 'cp -r ext/bento/packer_cache/ artifacts/'
  end
end
