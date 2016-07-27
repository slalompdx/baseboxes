desc 'Build specified image'
task :build do
  name = ENV['BASE_BUILD'] || nil
  abort 'Set BASE_BUILD to specify a target' unless name
  puts "Building image #{name}"
  puts build_packer_command(format: 'iso', box: name)
  if name =~ /^\w*-\w*$/
    puts build_packer_command(format: 'iso', box: name)
    stream_output build_packer_command(format: 'iso', box: name)
    command = "mv packer-#{name}-vmware/#{name}.vmsd " \
      "packer-#{name}-vmware/packer-vmare-vmx.vmsd"
    stream_output command
    command = "mv packer-#{name}-vmware/#{name}.nvram " \
      "packer-#{name}-vmware/packer-vmare-vmx.nvram"
    stream_output command
    command = "mv packer-#{name}-vmware/#{name}.vmx " \
      "packer-#{name}-vmware/packer-vmare-vmx.vmx"
    stream_output command
    command = "mv packer-#{name}-vmware/#{name}.vmxf " \
      "packer-#{name}-vmware/packer-vmare-vmx.vmxf"
    stream_output command
  else
    stream_output build_packer_command(format: 'ovf', box: name)
    command = "mv packer-#{name}-vmware/packer-vmware-vmx-{{timestamp}}.vmsd " \
      "packer-#{name}-vmware/packer-vmare-vmx.vmsd"
    stream_output command
    command = "mv packer-#{name}-vmware/packer-vmware-vmx-{{timestamp}}.nvram " \
      "packer-#{name}-vmware/packer-vmware-vmx.nvram"
    stream_output command
    command = "mv packer-#{name}-vmware/packer-vmware-vmx-{{timestamp}}.vmx " \
      "packer-#{name}-vmware/packer-vmware-vmx.vmx"
    stream_output command
    command = "mv packer-#{name}-vmware/packer-vmware-vmx-{{timestamp}}.vmxf " \
      "packer-#{name}-vmware/packer-vmware-vmx.vmxf"
    stream_output command
  end
  command = "mv packer-#{name}-virtualbox/*.ovf " \
    "packer-#{name}-virtualbox/packer-virtualbox-ovf.ovf"
  stream_output command
end
