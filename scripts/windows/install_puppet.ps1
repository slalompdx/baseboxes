$puppet_download_url = "http://downloads.puppetlabs.com/windows/puppet-agent-1.3.6-x64.msi"

Write-Output "Downloading $puppet_download_url"
(New-Object System.Net.WebClient).DownloadFile($puppet_download_url, "C:\Windows\Temp\puppet-agent-1.3.6-x64.msi")

Write-Output "Installing puppet..."
msiexec /qn /norestart /i C:\Windows\Temp\puppet-agent-1.3.6-x64.msi PUPPET_MASTER_SERVER=puppet.standard.com

# give puppet some time to install
Start-Sleep -s 60