$date = Get-Date -Format 'yyyyMMdd-HHmmss'
$uninstallExeArgs = @(
    '-remove'
    '-silent'
)

$uninstallMsiArgs = @(
    '/X'
    '{F5DC7FFF-49E9-45F3-B42E-36FE963573DB}'
    '/qn'
    "/log C:\Windows\Temp\AnyConnect4.5.03040-Uninstall-$date.log"
    'REBOOT=ReallySuppress'
)

if (Test-Path -Path 'C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\Uninstall.exe') {
    Start-Process -FilePath 'C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\Uninstall.exe' -ArgumentList $uninstallExeArgs -Wait
}

Start-Process -FilePath msiexec.exe -ArgumentList $uninstallMsiArgs -Wait

Start-Sleep -Seconds 3