$InstallArgs = '/SP-', '/VERYSILENT', '/SUPPRESSMSGBOXES', "/LOADINF=`"$PSScriptRoot\a2e.inf`""

Start-Process -FilePath "$PSScriptRoot\InstallAble2ExtractPro.exe" -ArgumentList $InstallArgs -Wait

Start-Sleep -Seconds 15

# Close browser windows that may pop-up after installation
Get-Process -Name browser_broker -IncludeUserName -ErrorAction SilentlyContinue | 
    Where-Object {$_.Username -like 'NT AUTHORITY\SYSTEM'} | Stop-Process -Force -Confirm:$false
Get-Process -Name MicrosoftEdge -IncludeUserName -ErrorAction SilentlyContinue | 
    Where-Object {$_.Username -like 'NT AUTHORITY\SYSTEM'} | Stop-Process -Force -Confirm:$false
Get-Process -Name MicrosoftEdgeCP -IncludeUserName -ErrorAction SilentlyContinue | 
    Where-Object {$_.Username -like 'NT AUTHORITY\SYSTEM'} | Stop-Process -Force -Confirm:$false
Get-Process -Name iexplore -IncludeUserName -ErrorAction SilentlyContinue | 
    Where-Object {$_.Username -like 'NT AUTHORITY\SYSTEM'} | Stop-Process -Force -Confirm:$false
Get-Process -Name chrome -IncludeUserName -ErrorAction SilentlyContinue | 
    Where-Object {$_.Username -like 'NT AUTHORITY\SYSTEM'} | Stop-Process -Force -Confirm:$false

if (Test-Path 'C:\Users\Public\Desktop\Able2Extract Professional 12.0.lnk') {
    Remove-Item -Path 'C:\Users\Public\Desktop\Able2Extract Professional 12.0.lnk' -Force -Confirm:$false
}
