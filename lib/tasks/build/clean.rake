desc 'Clean all builds and bento images'
task :clean do
  puts 'Cleaning builds and bento images'
  Rake::Task['clean:builds'].invoke
end
