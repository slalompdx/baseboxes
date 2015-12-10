namespace :clean do
  desc 'Clean centos base - Default for clean_iso is false'
  task :base, :clean_iso do |_task, args|
    puts 'Cleaning CentOS base image'
    clean_iso = args[:clean_iso] || 'false'
    Dir.chdir('ext/bento') do
      system 'rm -rf packer-centos-7.1-x86_64-virtualbox'
      system 'rm -rf packer-centos-6.7-x86_64-virtualbox'
      system 'rm -rf builds'
      unless clean_iso == 'false'
        puts 'Cleaning CentOS ISO'
        system 'rm -rf packer_cache'
      end
    end
  end
end
