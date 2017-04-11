require 'acceptance_spec_helper'

describe service('SQL Server (MSSQLSERVER)') do
  it { should be_enabled }
  it { should be_running }
end

describe package('Microsoft SQL Server 2012 (64-bit)') do
  it { should be_installed }
end
