# frozen_string_literal: true

desc 'Build specified image'
task :build do
  name    = ENV['BASE_BUILD'] || nil
  builder = (ENV['BUILDER']   || 'vmware,virtualbox').split(',')

  abort 'Set BASE_BUILD to specify a target' unless name

  puts "Building image #{name}"

  if name =~ /^\w*-\w*$/
    format = ENV['FORMAT'] || 'iso'
    source = name
  else
    format = ENV['FORMAT'] || 'ovf'
    # TODO: this doesn't make sense, right? timestamp is a packer var and
    # neither ruby nor bash will know about it?
    source = 'packer-vmware-vmx-{{timestamp}}'
  end

  p cmd = build_packer_command(builder: builder, format: format, box: name)
  stream_output cmd

  if builder.include?('vmware')
    %w(vmsd nvram vmx vmxf).each do |ext|
      command =
        "mv packer-#{name}-vmware/#{source}.#{ext} " \
        "packer-#{name}-vmware/packer-vmware-vmx.#{ext}"
      stream_output command
    end
  end

  if builder.include?('virtualbox')
    command = "mv packer-#{name}-virtualbox/*.ovf " \
      "packer-#{name}-virtualbox/packer-virtualbox-ovf.ovf"
    stream_output command
  end
end
