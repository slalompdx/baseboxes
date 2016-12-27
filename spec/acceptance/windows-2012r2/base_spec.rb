require 'acceptance_spec_helper'

describe command('Get-ExecutionPolicy') do
  its(:stdout) { should match /RemoteSigned/ }
end

describe windows_registry_key('HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced') do
  it { should have_property('HideFileExt', :type_dword, '0') }
  it { should have_property('Start_ShowRun', :type_dword, '1') }
  it { should have_property('StartMenuAdminTools', :type_dword, '1')}
end

describe windows_registry_key('HKCU\Console') do
  it { should have_property('QuickEdit', :type_dword, '1') }
end

describe windows_registry_key('HKLM\SYSTEM\CurrentControlSet\Control\Power') do
  it { should have_property('HibernateFileSizePercent', :type_dword, '0') }
  it { should have_property('HibernateEnabled', :type_dword, '0') }
end

describe windows_registry_key('HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server') do
  it { should have_property('fDenyTSConnections', :type_dword, '0') }
end

describe windows_registry_key('HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon') do
  it { should have_property('Start_ShowRun', :type_dword, '1') }
  it { should have_property('AutoAdminLogon', :type_dword, '0') }
end

describe command ('netsh advfirewall firewall show rule name="Open Port 3389"') do
  its(:stdout) { should match /Direction:\s*In/ }
  its(:stdout) { should match /Action:\s*Allow/ }
  its(:stdout) { should match /Protocol:\s*TCP/ }
  its(:stdout) { should match /LocalPort:\s*3389/ }
end

describe service('OpenSSHd') do
  it { should_not be_running }
end

describe command('winrm get winrm/config') do
  its(:stdout) { should match /MaxMemoryPerShellMB = 512/ }
  its(:stdout) { should match /MaxTimeoutms = 1800000/ }
  its(:stdout) { should match /AllowUnencrypted = true/ }
  its(:stdout) { should match /Basic = true/ }
end

describe command('Get-WmiObject -Class Win32_Service -Filter "name=\'WinRM\'"') do
  its(:stdout) { should match /StartMode\s*:\s*Auto/ }
end
