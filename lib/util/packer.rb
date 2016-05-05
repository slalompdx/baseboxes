# rubocop:disable Metrics/MethodLength
def build_packer_command(args = {})
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
  if actual[:format] == 'iso'
    command << "-only=virtualbox-#{actual[:format]},vmware-#{actual[:format]}"
  else
    command << "-only=virtualbox-ovf,vmware-vmx"
  end
  command << "#{actual[:box]}.json"
  command.join(' ')
end
# rubocop:enable Metrics/MethodLength
