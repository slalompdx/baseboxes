desc 'Build specified image'
task :build, :name, :force do |_task, args|
  puts "Building image #{args[:name]}"
  if args[:name] =~ /\w*-\w$/
    stream_output build_packer_command(format: 'iso', box: args[:name])
  else
    stream_output build_packer_command(format: 'ovf', box: args[:name])
  end
  command = "mv packer-#{args[:name]}-virtualbox/*.ovf " \
    "packer-#{args[:name]}-virtualbox/packer-virtualbox-ovf.ovf"
  stream_output command
end
