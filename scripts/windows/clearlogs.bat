powershell.exe "wevtutil el | Foreach-Object {Write-Host \"Clearing $_\"; wevtutil cl \"$_\"}"
