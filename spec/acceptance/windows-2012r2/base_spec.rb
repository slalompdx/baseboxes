require 'spec_helper'

describe command('Get-ExecutionPolicy -ExecutionPolicy') do
  its(:stdout) { should match /RemoteSigned/ }
end
