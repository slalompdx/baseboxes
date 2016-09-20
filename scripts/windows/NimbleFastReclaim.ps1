##########################################################################
#    Written By: David Tan
#    
#    V1.0 29/01/2014        Davidt     Fast Space reclaimer.
#
#   Note: Concept and code parts taken from http://blog.whatsupduck.net/2012/03/powershell-alternative-to-sdelete.html
#
#   Uses powershell method to generate large (1GB) file containing 0. Re-copies this file until <1GB free.
##########################################################################


param (       
       [string] $FilePath,
       [string] $LogFile,
       [int] $CycleWait
)


Function DispMessage ([string] $Message) {
    [string] $DateStamp = get-date -format "yyyy-MM-dd HH:mm.ss"
    Write-Host "[$DateStamp] $Message"       
    Add-Content $LogFile "[$DateStamp] $Message"
    }

Function SleepWait ([string] $Sleeptime) {
    sleep $Sleeptime
    DispMessage "  --> Sleeping $Sleeptime sec"
    }


$LogFile = "C:\windows\temp\NimbleFastReclaim.log"
$FilePrefix = "NimbleFastReclaim"
$FileExt = ".tmp"

If ($FilePath -eq "") {
    Write-Host "- Filepath <driveletter or mountpoint>"
    Write-Host "- LogFile (DEFAULT=$LogFile)"
    Write-Host "- CycleWait(s) (DEFAULT=0)"
    Exit 1
    }
If ($FilePath.substring($FilePath.length - 1, 1) -ne "\") {
    $FilePath = $FilePath + "\"
  }  
$ArraySize = 1048576kb
DispMessage "--> Starting Reclaim on $Filepath ... "
DispMessage "--> Cycle Sleep = $CycleWait sec"
DispMessage "--> File Size = $($ArraySize/1024/1024) MB"
$SourceFile = "$($FilePath)$($FilePrefix)0$($FileExt)"

Try {
    DispMessage "  -->Writing $SourceFile"
    $ZeroArray= new-object byte[]($ArraySize)
    $Stream= [io.File]::OpenWrite($SourceFile)
    $Stream.Write($ZeroArray,0, $ZeroArray.Length)
    $Stream.Close()
    $copyidx = 1
    while ((gwmi win32_volume | where {$_.name -eq "$FilePath"}).Freespace -gt 1024*1024*1024) {
        $TargetFile = "$($FilePath)$($FilePrefix)$($copyidx)$($FileExt)"    
        DispMessage "  --> Writing $TargetFile"
        cmd /c copy $SourceFile  $TargetFile    
        $copyidx = $copyidx + 1
        If ($CycleWait -gt 0) {
            SleepWait $CycleWait
          }
      }
    DispMessage "--> Reclaim Complete. Cleaning up..."
    Remove-Item "$($FilePath)$($FilePrefix)*$($FileExt)"
    DispMessage "--> DONE! Zerod out $($copyidx*$ArraySize/1024/1024) GB"
  }
Catch {
    DispMessage "##> Reclaim Failed. Cleaning up..."
    Remove-Item "$($FilePath)$($FilePrefix)*$($FileExt)"
    Exit 1
  }

