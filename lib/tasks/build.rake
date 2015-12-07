desc 'Build specified image'
task :build, [:name] do |_task, args|
  puts "Building image #{args[:name]}"
  stream_output build_packer_command(format: 'ovf', box: args[:name])
  command = "mv packer-#{args[:name]}-virtualbox/*.ovf " \
    "packer-#{args[:name]}-virtualbox/packer-virtualbox-ovf.ovf"
  stream_output command
end
