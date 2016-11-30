mkdir c:\windows\setup\scripts
copy a:\winrm.bat c:\windows\setup\scripts\SetupComplete.cmd
reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion /t REG_SZ /v Run /d c:\winrm.cmd /f
