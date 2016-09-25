function DownloadFile($url, $targetFile)
{

   $uri = New-Object "System.Uri" "$url"
   $request = [System.Net.HttpWebRequest]::Create($uri)
   $request.set_Timeout(15000) #15 second timeout
   $response = $request.GetResponse()
   $totalLength = [System.Math]::Floor($response.get_ContentLength()/1024)
   $responseStream = $response.GetResponseStream()
   $targetStream = New-Object -TypeName System.IO.FileStream -ArgumentList $targetFile, Create
   $buffer = new-object byte[] 10KB
   $count = $responseStream.Read($buffer,0,$buffer.length)
   $downloadedBytes = $count
   while ($count -gt 0)
   {
       $targetStream.Write($buffer, 0, $count)
       $count = $responseStream.Read($buffer,0,$buffer.length)
       $downloadedBytes = $downloadedBytes + $count
       Write-Progress -activity "Downloading file '$($url.split('/') | Select -Last 1)'" -status "Downloaded ($([System.Math]::Floor($downloadedBytes/1024))K of $($totalLength)K): " -PercentComplete ((([System.Math]::Floor($downloadedBytes/1024)) / $totalLength)  * 100)
   }
}
downloadFile "https://s3-us-west-2.amazonaws.com/slalompdx/ISO/Microsoft/en_sql_server_2012_enterprise_edition_with_service_pack_3_x64_dvd_7286819.iso" "C:\sql2012.iso"
downloadFile "https://s3-us-west-2.amazonaws.com/slalompdx/ISO/Microsoft/en_sql_server_2012_enterprise_edition_with_service_pack_3_x64_dvd_7286819.iso" "C:\ConfigurationFile.ini"
Mount-DiskImage C:\sql2012.iso
& cmd.exe /c "E:\setup.exe /ConfigurationFile=c:\ConfigurationFile.ini /QS"
