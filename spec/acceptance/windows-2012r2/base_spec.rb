require 'spec_helper'

describe command('Get-ExecutionPolicy') do
  its(:stdout) { should match /RemoteSigned/ }
end

describe command('REG QUERY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\
') do
  its(:stdout) { should match /HideFileExt\s*REG_DWORD\s*0x0/ }
end

describe command('REG QUERY HKCU\Console') do
  its(:stdout) { should match /QuickEdit\s*REG_DWORD\s*0x1/ }
end

describe command('REG QUERY HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced') do
  its(:stdout) { should match /Start_ShowRun\s*REG_DWORD\s*0x1/ }
  its(:stdout) { should match /StartMenuAdminTools\s*REG_DWORD\s*0x1/ }
end

describe command('REG QUERY HKLM\SYSTEM\CurrentControlSet\Control\Power') do
  its(:stdout) { should match /HibernateFileSizePercent\s*REG_DWORD\s*0x0/ }
  its(:stdout) { should match /HibernateEnabled\s*REG_DWORD\s*0x0/ }
end

describe command('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections') do
  its(:stdout) { should match /fDenyTSConnections\s*REG_DWORD\s*0x0/ }
end

describe command('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"') do
  its(:stdout) { should match /Start_ShowRun\s*REG_DWORD\s*0x1/ }
  its(:stdout) { should match /AutoAdminLogon\s*REG_DWORD\s*0x0/ }
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
