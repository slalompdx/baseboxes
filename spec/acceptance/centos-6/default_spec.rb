# frozen_string_literal: true
require 'acceptance_spec_helper'

describe package('libyaml-dev') do
  it { should be_installed }
end
