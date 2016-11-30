::http://support.microsoft.com/kb/2570538
::http://robrelyea.wordpress.com/2007/07/13/may-be-helpful-ngen-exe-executequeueditems/

if exist %windir%\microsoft.net\framework\v4.0.30319\ngen.exe (
	%windir%\microsoft.net\framework\v4.0.30319\ngen.exe update /force /queue
	%windir%\microsoft.net\framework\v4.0.30319\ngen.exe executequeueditems
)
if exist %windir%\microsoft.net\framework64\v4.0.30319\ngen.exe (
	%windir%\microsoft.net\framework64\v4.0.30319\ngen.exe update /force /queue
	%windir%\microsoft.net\framework64\v4.0.30319\ngen.exe executequeueditems
)

:: continue even if ngen fails
winrm quickconfig -q
winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"}
winrm set winrm/config @{MaxTimeoutms="1800000"}
winrm set winrm/config/service @{AllowUnencrypted="true"}
winrm set winrm/config/service/auth @{Basic="true"}
sc config WinRM start= auto
exit /b 0
