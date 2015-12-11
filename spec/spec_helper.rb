require 'rake'
require 'pty'
require 'rspec/core/rake_task'
require './lib/util'
require './lib/util/packer'

def list_builds
  Rake.application.rake_require 'tasks/build'
  Rake.application.rake_require 'tasks/list'
  Rake::Task['list'].reenable
  capture_stdout { Rake::Task['list'].invoke }.split(/\n/)
end
