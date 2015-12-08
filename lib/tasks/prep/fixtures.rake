namespace :prep do
  desc 'Build spec fixtures'
  task :fixtures do
    Rake::Task['ensure:fixtures'].invoke
#    Dir.chdir('fixtures/vagrant')
    #tasks = capture_stdout { Rake::Task['list'].invoke }.split('\n')
    Rake::Task['list'].reenable
    Rake::Task[:list].invoke
#    puts tasks
    #capture_stdout { Rake::Task['list'].invoke }.split('\n').each do |task|
    #  puts "#{task}"
    #end
  end
end
