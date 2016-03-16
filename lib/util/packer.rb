def old_packer_command_builder(version = 7)
  http_proxy = ENV['HTTP_PROXY'] || ENV['http_proxy']
  https_proxy = ENV['HTTPS_PROXY'] || ENV['https_proxy']
  no_proxy = ENV['NO_PROXY'] || ENV['no_proxy']

  command = ['packer build']
  command << "-var http_proxy=#{http_proxy}" if http_proxy
  command << "-var https_proxy=#{https_proxy}" if https_proxy
  command << "-var no_proxy=#{no_proxy}" if no_proxy
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
    force: ENV['BOX_FORCE'] || false
  }
  http_proxy = ENV['HTTP_PROXY'] || ENV['http_proxy']
  https_proxy = ENV['HTTPS_PROXY'] || ENV['https_proxy']
  no_proxy = ENV['NO_PROXY'] || ENV['no_proxy']

  actual = defaults.merge(args)

  command = ['packer build']
  command << '--force' if actual[:force]
  command << "-var http_proxy=#{http_proxy}" if http_proxy
  command << "-var https_proxy=#{https_proxy}" if https_proxy
  command << "-var no_proxy=#{no_proxy}" if no_proxy
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
