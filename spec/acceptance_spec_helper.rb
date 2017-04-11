# frozen_string_literal: true
require 'serverspec'
require 'net/ssh'
require 'tempfile'

set :backend, :ssh

host = 'default'
ENV['TARGET_HOST'] = host

config = Tempfile.new('', Dir.tmpdir)
config.write(`vagrant ssh-config #{host}`)
config.close

options = Net::SSH::Config.for(host, [config.path])
options[:user] ||= Etc.getlogin

set :host,        options[:host_name] || host
set :ssh_options, options
