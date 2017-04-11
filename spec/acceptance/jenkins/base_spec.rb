require 'acceptance_spec_helper'

$jenk_pkgs = [
  'java',
  'jenkins'
]
$jenk_pkgs.each do |t|
  describe package(t) do
    it { should be_installed }
  end
end


$plugins = [
  'ansicolor',
  'credentials',
  'credentials-binding',
  'plain-credentials',
  'workflow-step-api',
  'job-dsl',
  'copy-project-link',
  'rbenv',
  'ruby-runtime',
  'ssh-agent',
  'git',
  'git-client',
  'scm-api',
  'mailer',
  'token-macro',
  'matrix-project',
  'ssh-credentials',
  'parameterized-trigger',
  'subversion',
  'promoted-builds',
  'conditional-buildstep',
  'build-flow-plugin',
  'buildgraph-view',
  'groovy-postbuild',
  'script-security',
  'multiple-scms',
  'ws-cleanup',
  'gradle',
  'envinject',
  'global-build-stats',
  'rebuild'
]

$plugins.each do |p|
  describe file("/var/lib/jenkins/plugins/#{p}.hpi") do
    it { should be_file }
    it { should be_owned_by 'jenkins' }
  end
end

describe file('/var/lib/jenkins/jobs') do
  it { should be_directory }
end

describe service('jenkins') do
  it { should be_running }
end
