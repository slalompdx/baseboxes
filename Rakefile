require 'rake'
require 'pty'
require 'net/https'
require 'rspec/core/rake_task'
require './lib/util'
require './lib/util/packer'

task :before do
  @http_proxy = ENV['http_proxy'] if ENV['http_proxy']
  @https_proxy = ENV['https_proxy'] if ENV['https_proxy']
  @override = ENV['spec_override']
end

RSpec::Core::RakeTask.new(:spec)
Dir.glob('./lib/tasks/**/*.rake').each { |r| import r }
