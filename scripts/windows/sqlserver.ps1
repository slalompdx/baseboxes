Import-Module BitsTransfer
$Source = "\\vmware-host\Shared Folders\-vagrant\blobs\sqlserver_2012_ee_sp3.iso"
$Destination = "C:\sqlserver_2012_ee_sp3.iso"
Start-BitsTransfer -Source $Source -Destination $Destination -Description "Backup" -DisplayName "Backup"
Mount-DiskImage $Destination
Copy-Item "\\vmware-host\Shared Folders\-vagrant\http\windows-2012r2\ConfigurationFile.ini" "C:\ConfigurationFile.ini"
& cmd.exe /c "E:\setup.exe /ConfigurationFile=c:\ConfigurationFile.ini /QS"
