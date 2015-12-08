namespace :preserve do
  desc 'Preserve artifacts'
  task :artifacts do
    puts 'Preserving artifacts'
    Rake::FileTask['artifacts'].invoke
    system 'cp -r builds/ artifacts/builds'
    system 'cp -r packer-centos* artifacts/'
    system 'cp -r ext/bento/packer-centos* artifacts/'
  end
end
