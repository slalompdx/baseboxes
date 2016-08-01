#Get Operating System version and set source files for updates
$OS = Get-WmiObject Win32_OperatingSystem

If ($OS | where {$OS.version -like "6.1.*"})
{
  $source = "e:\w61-x64\glb"
}
elseif ($OS | where {$OS.version -like "6.2.*"})
{
  $source = "e:\w62-x64\glb"
}
elseif ($OS | where {$OS.version -like "6.3.*"})
{
  $source = "e:\w63-x64\glb"
}

$updates = @(Get-ChildItem -Path $source -Filter '*.msu')
if ($updates.Count -ge 1) {
  $updates | % {
    Write-Host "Processing update $($_.Name)."
    & wusa $_.FullName /quiet /norestart
  }
} else {
  Write-Host 'No updates found.'
}

If ($OS.version -gt 6.1)
{
  Add-WindowsPackage -PackagePath $source -Online
}
else
{
  dism.exe /Online /Add-Package /PackagePath:$source /NoRestart
}
