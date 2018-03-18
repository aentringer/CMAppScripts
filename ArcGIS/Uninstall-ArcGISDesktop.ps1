$uninstallArgs = @('/X'
                   '{4740FC57-60FE-45BB-B513-3309F6B73183}'
                   '/qn'
                   "/log C:\Windows\Temp\ArcGIS-Uninstall-$(Get-Date -Format 'yyyyMMdd-hhmmss').log")

Start-Process -FilePath msiexec.exe -ArgumentList $uninstallArgs -Wait

Start-Sleep -Seconds 5
