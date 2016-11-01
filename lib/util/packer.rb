# rubocop:disable Metrics/MethodLength
# frozen_string_literal: false

def fix_builder_format(builder, format)
  real_format =
    case (builder == 'vmware' && format == 'ovf')
    when true  then 'vmx'
    when false then format
    end

  "#{builder}-#{real_format}"
end

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

  command = ['packer build']
  command << '-var-file=/tmp/packer-variables.json' if var_file
  command << '--force'                              if actual[:force]
  command << "-var http_proxy=#{http_proxy}"        if http_proxy
  command << "-var https_proxy=#{https_proxy}"      if https_proxy
  command << "-var no_proxy=#{no_proxy}"            if no_proxy
  command << '-only=' + actual[:builder].map do |builder|
    fix_builder_format(builder, actual[:format])
  end.join(',')
  command << "#{actual[:box]}.json"

  command.join(' ')
end
# rubocop:enable Metrics/MethodLength
