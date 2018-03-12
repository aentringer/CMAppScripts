$UninstallArgs = '/VERYSILENT', '/SUPPRESSMSGBOXES', '/CLOSEAPPLICATIONS'

Stop-Process -Name Able2ExtractPro -ErrorAction SilentlyContinue -Force -Confirm:$false

Start-Process -FilePath 'C:\Program Files (x86)\Investintech.com Inc\Able2Extract Professional 12.0\unins000.exe' -ArgumentList $UninstallArgs -Wait

if (Test-Path 'C:\Program Files (x86)\Investintech.com Inc\Able2Extract Professional 12.0') {
    Remove-Item -Path 'C:\Program Files (x86)\Investintech.com Inc\Able2Extract Professional 12.0' -Recurse -Force -Confirm:$false
}

Start-Sleep -Seconds 5

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

