desc 'Build specified image'
task :build do
  name = ENV['BASE_BUILD'] || nil
  builder = ( ENV['BUILDER'] || 'vmware,virtualbox' ).split(',')
  abort 'Set BASE_BUILD to specify a target' unless name
  puts "Building image #{name}"
  if name =~ /^\w*-\w$/
    format = ENV['FORMAT'] || 'iso'
    puts build_packer_command(builder: builder, format: format, box: name)
    stream_output build_packer_command(builder: builder, format: format, box: name)
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
    format = ENV['FORMAT'] || 'ovf'
    puts build_packer_command(builder: builder, format: format, box: name)
    stream_output build_packer_command(builder: builder, format: format, box: name)
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
