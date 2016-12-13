require 'spec_helper'

if os['release'] =~ /^7\./
  $ver = '2.3.1'
else
  $ver = '2.2.2'
end

describe command('ruby --version') do
  its(:stdout) { should match /#{ver}/ }
end

describe command ('gem list') do
  its(:stdout) { should match /serverspec/ }
  its(:stdout) { should match /bundler/ }
end
