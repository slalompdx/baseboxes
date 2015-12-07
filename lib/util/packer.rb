def old_packer_command_builder(version = 7)
  command = ['packer build']
  command << "-var http_proxy=#{ENV['http_proxy']}" if ENV['http_proxy']
  command << "-var https_proxy=#{ENV['https_proxy']}" if ENV['https_proxy']
  command << '-only=virtualbox-iso'
  case version.to_i
  when 6 then command << 'centos-6.7-x86_64.json'
  when 7 then command << 'centos-7.1-x86_64.json'
  end
  command.join(' ')
end

def new_packer_command_builder(args = {})
  defaults = {
    format: 'iso',
    box: 'centos-7.1-x86_64',
    force: ENV['force'] || false
  }

  actual = defaults.merge(args)

  command = ['packer build']
  command << '--force' if actual[:force]
  command << "-var http_proxy=#{ENV['http_proxy']}" if ENV['http_proxy']
  command << "-var https_proxy=#{ENV['https_proxy']}" if ENV['https_proxy']
  command << "-only=virtualbox-#{actual[:format]}"
  command << "#{actual[:box]}.json"
  command.join(' ')
end

def build_packer_command(args = {})
  if args.is_a?(Fixnum)
    old_packer_command_builder(args)
  elsif args.is_a?(Hash)
    new_packer_command_builder(args)
  end
end
