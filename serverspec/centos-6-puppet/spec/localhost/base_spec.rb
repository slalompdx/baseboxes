require 'spec_helper'

describe package('puppet') do
  it { should be_installed.by('rpm').with_version('3.8') }
end
