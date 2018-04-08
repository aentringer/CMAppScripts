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