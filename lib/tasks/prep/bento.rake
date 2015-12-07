namespace :prep do
  desc 'Download and build Slalom Bento fork'
  task :bento do
    Rake::Task['download:bento'].invoke
    Rake::Task['build:base'].invoke
  end
end
