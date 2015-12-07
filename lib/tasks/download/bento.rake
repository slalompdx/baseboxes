namespace :download do
  desc 'Download Slalom Bento fork'
  task :bento do
    bento_fork_url = 'https://github.com/slalompdx/bento.git'
    puts 'Downloading bento fork...'
    Rake::Task['fixtures'].invoke
    Dir.chdir('fixtures') do
      system "git clone #{bento_fork_url}" unless File.directory?('bento')
      Dir.chdir('bento') { system 'git pull origin master --rebase' }
    end
  end
end
