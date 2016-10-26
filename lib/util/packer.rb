# rubocop:disable Metrics/MethodLength
# frozen_string_literal: false

def build_packer_command(args = {})
  defaults = {
    builder: %w(vmware virtualbox),
    format: 'iso',
    box: 'centos-7.1-x86_64',
    force: ENV['BOX_FORCE'] || false
  }

  var_file    = ENV['P_USE_VAR_FILE']
  http_proxy  = ENV['HTTP_PROXY']  || ENV['http_proxy']
  https_proxy = ENV['HTTPS_PROXY'] || ENV['https_proxy']
  no_proxy    = ENV['NO_PROXY']    || ENV['no_proxy']

  actual = defaults.merge(args)

  command = 'packer build'
  command << ' -var-file=/tmp/packer-variables.json' if var_file
  command << ' --force' if actual[:force]
  command << " -var http_proxy=#{http_proxy}" if http_proxy
  command << " -var https_proxy=#{https_proxy}" if https_proxy
  command << " -var no_proxy=#{no_proxy}" if no_proxy
  command << ' -only='
  actual[:builder].each_with_index do |builder, index|
    format =
      if actual[:format] == 'ovf'
        builder == 'vmware' ? 'vmx' : 'ovf'
      else
        actual[:format]
      end
    command << "#{builder}-#{format}"
    command << ',' unless index == actual[:builder].size - 1
  end
  command << " #{actual[:box]}.json"
end
# rubocop:enable Metrics/MethodLength
