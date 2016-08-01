param([String]$proxy="myproxy.com")
param([String]$no_proxy="localhost,127.0.0.1")

$env:http_proxy = $proxy
$env:https_proxy = $proxy
$env:no_proxy = $no_proxy