desc 'Build specified image'
task :build, :name do |_task, args|
  puts "Building image #{args[:name]}"
  if args[:name] =~ /^\w*-\w$/
    stream_output build_packer_command(format: 'iso', box: args[:name])
  else
    stream_output build_packer_command(format: 'ovf', box: args[:name])
  end
  command = "mv packer-#{args[:name]}-virtualbox/*.ovf " \
    "packer-#{args[:name]}-virtualbox/packer-virtualbox-ovf.ovf"
  stream_output command
  command = "mv packer-#{args[:name]}-vmware/packer-vmware-vmx-{{timestamp}}.vmsd " \
    "packer-#{args[:name]}-vmware/packer-vmare-vmx.vmsd"
  stream_output command
  command = "mv packer-#{args[:name]}-vmware/packer-vmware-vmx-{{timestamp}}.nvram " \
    "packer-#{args[:name]}-vmware/packer-vmware-vmx.nvram"
  stream_output command
  command = "mv packer-#{args[:name]}-vmware/packer-vmware-vmx-{{timestamp}}.vmx " \
    "packer-#{args[:name]}-vmware/packer-vmware-vmx.vmx"
  stream_output command
  command = "mv packer-#{args[:name]}-vmware/packer-vmware-vmx-{{timestamp}}.vmxf " \
    "packer-#{args[:name]}-vmware/packer-vmware-vmx.vmxf"
  stream_output command
end
