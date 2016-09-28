Set-PSDebug –Trace 1

$Destination = "C:\sqlserver_2012_ee_sp3.iso"
Mount-DiskImage $Destination
