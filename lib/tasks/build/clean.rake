desc 'Clean all builds'
task :clean do
  puts 'Cleaning builds'
  Rake::Task['clean:builds'].invoke
end
