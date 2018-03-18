$date = Get-Date -Format 'yyyyMMdd-HHmmss'
$installExeArgs = @(
    '/exenoui'
    "/exelog:C:\Windows\AnyConnect4.5.03040-Exe-$Date.log"
    '/qn'
    "/log C:\Windows\AnyConnect4.5.03040-Msi-$Date.log"
    'REBOOT=ReallySuppress'
)
$installMsiArgs = @(
    '/qn'
    "/log C:\Windows\AnyConnect4.5.03040-Msi-$Date.log"
    'REBOOT=ReallySuppress'
)

$installer = Get-ChildItem -Path $PSScriptRoot\* -Include ('*.exe', '*.msi')

if ($installer -like '*.exe') {
    Start-Process -FilePath $installer -ArgumentList $installExeArgs -Wait
}
if ($installer -like '*.msi') {
    Start-Process -FilePath $installer -ArgumentList $installMsiArgs -Wait
}

Start-Sleep -Seconds 3