# rubocop:disable Metrics/MethodLength
# frozen_string_literal: false

def build_packer_command(args = {})
  defaults = {
    builder: %w(vmware virtualbox),
    format: 'iso',
    box: 'centos-7.1-x86_64',
    force: ENV['BOX_FORCE'] || false
  }
  http_proxy = ENV['HTTP_PROXY'] || ENV['http_proxy']
  https_proxy = ENV['HTTPS_PROXY'] || ENV['https_proxy']
  no_proxy = ENV['NO_PROXY'] || ENV['no_proxy']

  actual = defaults.merge(args)

  command = 'packer build'
  command << ' --force' if actual[:force]
  command << " -var http_proxy=#{http_proxy}" if http_proxy
  command << " -var https_proxy=#{https_proxy}" if https_proxy
  command << " -var no_proxy=#{no_proxy}" if no_proxy
  command << ' -only='
  actual[:builder].each_with_index do |builder, index|
    if actual[:format] == 'ovf'
      format = if builder == 'vmware'
                 'vmx'
               else
                 'ovf'
               end
    else
      format = actual[:format]
    end
    command << "#{builder}-#{format}"
    command << ',' unless index == actual[:builder].size - 1
  end
  command << " #{actual[:box]}.json"
end
# rubocop:enable Metrics/MethodLength
