require 'acceptance_spec_helper'

describe command ('choco list --local-only') do
  its(:stdout) { should match /chocolatey/ }
end
