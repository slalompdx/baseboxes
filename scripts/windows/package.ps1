$ErrorActionPreference = "Stop"

. a:\Test-Command.ps1

start-service winrm

register-pssessionconfiguration Microsoft.PowerShell32 -processorarchitecture x86 -force

#Enable-RemoteDesktop
set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
netsh advfirewall firewall set rule group="remote desktop" new enable=Yes
set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1


Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force


Write-Host "Setting up winrm"
netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow

$enableArgs=@{Force=$true}
try {
 $command=Get-Command Enable-PSRemoting
  if($command.Parameters.Keys -contains "skipnetworkprofilecheck"){
      $enableArgs.skipnetworkprofilecheck=$true
  }
}
catch {
  $global:error.RemoveAt(0)
}
Enable-PSRemoting @enableArgs
Enable-WSManCredSSP -Force -Role Server
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/Service '@{MaxConcurrentOperationsPerUser="1000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="2048"}'
winrm set winrm/config/winrs '@{IdleTimeout="1800000"}'
winrm set winrm/config/winrs '@{MaxProcessesPerShell="0"}'
Write-Host "winrm setup complete"

if (Test-Command -cmdname 'Uninstall-WindowsFeature') {
    Write-Host "Removing unused features..."
    Remove-WindowsFeature -Name 'Powershell-ISE'
    Get-WindowsFeature |
    ? { $_.InstallState -eq 'Available' } |
    Uninstall-WindowsFeature -Remove
}

start-sleep -s 300
Restart-Computer
