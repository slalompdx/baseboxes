namespace :build do
  desc 'Build centos base - Default for version is both, use both, 6 or 7'
  task :base, :version do |_task, args|
    version = args[:version] || %w(6 7)
    abort '"both" is deprecated as an explicit argument' if version == 'both'
    Dir.chdir('fixtures/bento') do
      system 'git checkout master'
      system 'git reset --hard HEAD'

      if version.include? '7'
        stream_output build_packer_command(box: 'centos-7.1-x86_64', force: true)
      end

      if version.include? '6'
        stream_output build_packer_command(box: 'centos-6.7-x86_64', force: true)
      end
    end
  end
end
