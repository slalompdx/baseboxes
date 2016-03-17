namespace :prep do
  desc 'Build spec fixtures'
  task :fixtures do
    Rake::Task['ensure:fixtures'].invoke
    Dir.chdir('serverspec') do
      tasks = capture_stdout { Rake::Task['list'].invoke }.split(/\n/)
      tasks.each do |task|
        if Dir.exists?(task)
          puts "Fixtures for #{task} already exist."
        else
          puts "Initializing serverspec for #{task}..."
          case task.count('-')
          when 1
            role = 'base'
          else
            role = 'default'
          end
          FileUtils.cp_r("../fixtures/serverspec_skel/#{role}", task)
          Dir.chdir(task) do
            puts "Writing Vagrantfile for #{task}..."
            FileUtils.rm_rf('Vagrantfile')
            system "vagrant init spec-#{task} ."
            puts "\n"
          end
        end
      end
    end
  end
end
