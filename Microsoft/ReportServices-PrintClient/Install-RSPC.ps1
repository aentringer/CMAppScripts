# Cleanup existing copy, if applicable
if (Test-Path -Path 'C:\Windows\SysWOW64\srs_rpe\rsclientprint.dll') {
    $x86Args = @(
        '/u'
        '/s'
        'C:\Windows\SysWOW64\srs_rpe\rsclientprint.dll'
    )
    Start-Process -FilePath 'C:\Windows\SysWOW64\regsvr32.exe' -ArgumentList $x86Args -Wait
    Remove-Item -Path 'C:\Windows\SysWOW64\srs_rpe' -Recurse -Force -Confirm:$false
    Start-Sleep -Seconds 3
}

if (Test-Path -Path 'C:\Windows\System32\srs_rpe\rsclientprint64.dll') {
    $x64Args = @(
        '/u'
        '/s'
        'C:\Windows\System32\srs_rpe\rsclientprint64.dll'
    )
    Start-Process -FilePath 'C:\Windows\System32\regsvr32.exe' -ArgumentList $x64Args -Wait
    Remove-Item -Path 'C:\Windows\System32\srs_rpe' -Recurse -Force -Confirm:$false
    Start-Sleep -Seconds 3
}

# Create folders
if (-not (Test-Path 'C:\Windows\SysWOW64\srs_rpe')) {
    New-Item -Path 'C:\Windows\SysWOW64\srs_rpe' -ItemType Directory | Out-Null
}

if (-not (Test-Path 'C:\Windows\System32\srs_rpe')) {
    New-Item -Path 'C:\Windows\System32\srs_rpe' -ItemType Directory | Out-Null
}

# Copy Files before registration
Copy-Item -Path "$PSScriptRoot\x86\*" -Destination 'C:\Windows\SysWOW64\srs_rpe' -Force -Confirm:$false
Copy-Item -Path "$PSScriptRoot\x64\*" -Destination 'C:\Windows\System32\srs_rpe' -Force -Confirm:$false

Start-Sleep -Seconds 5

# Register DLL Files
$x86Args = @(
    '/s'
    'C:\Windows\SysWOW64\srs_rpe\rsclientprint.dll'
)
$x64Args = @(
    '/s'
    'C:\Windows\System32\srs_rpe\rsclientprint64.dll'
)
Start-Process -FilePath 'C:\Windows\SysWOW64\regsvr32.exe' -ArgumentList $x86Args -Wait
Start-Process -FilePath 'C:\Windows\System32\regsvr32.exe' -ArgumentList $x64Args -Wait

Start-Sleep -Seconds 2