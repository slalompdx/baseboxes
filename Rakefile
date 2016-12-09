require 'rake'
require 'net/http'
require 'open-uri'
require 'rspec/core/rake_task'
require 'ruby-progressbar'
require './lib/util'
require './lib/util/packer'

task :before do
  @http_proxy  = ENV['http_proxy'] if ENV['http_proxy']
  @https_proxy = ENV['https_proxy'] if ENV['https_proxy']
  @override    = ENV['spec_override']
end

RSpec::Core::RakeTask.new(:spec)
Dir.glob('./lib/tasks/**/*.rake').each { |r| import r }

def ary_to_regexp(ary)
  Regexp.new('(' + ary.join('|') + ')')
end

def tokenize_build(name)
  raise ArgumentError unless name.is_a?(String)
  nix_bases  = %w(centos-6 centos-7 rhel-7 esxi-6u2 solaris-10)
  win_bases  = %w(windows-2012r2 windows-7)

  base = name.match(ary_to_regexp(nix_bases)) ||
         name.match(ary_to_regexp(win_bases))
  abort unless base[1]

  layers = name.gsub(base[1], '').split('-').reject(&:empty?)

  { base: base, layers: layers }
end

namespace :vagrant do
  desc 'package a build in to a box'
  task :add, [:build] do |_t, args|
    build    = args.build
    provider = ENV['VAGRANT_DEFAULT_PROVIDER'] || 'virtualbox'

    sh "vagrant box add -f builds/#{build}.#{provider}.box --name #{build}"
  end

  desc 'bring up a vagrant instance'
  task :up, [:box] do |_t, args|
    sh "vagrant init -f --minimal #{args.box}"
    sh 'vagrant destroy -f'
    sh 'vagrant up'
  end

  desc 'force destroy vagrant default'
  task :down do |_t|
    sh 'vagrant destroy -f'
  end
end

namespace :spec do
  desc 'run acceptance tests'
  task :acceptance, [:build] do |_t, args|
    Rake::Task['vagrant:add'].invoke(args.build)
    Rake::Task['vagrant:up'].invoke(args.build)

    base, layers = tokenize_build(args.build).values_at(:base, :layers)
    tests = layers.empty? ? base : [base, layers].flatten

    sh "rspec -P spec/acceptance/{#{tests}}/*_spec.rb"
  end
end
