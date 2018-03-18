$esriLicenseHost = 'SERVERNAME'
$installArgs = @("ESRI_LICENSE_HOST=$esriLicenseHost"
                 'SOFTWARE_CLASS=Viewer'
                 'SEAT_PREFERENCE=Float'
                 'DESKTOP_CONFIG=TRUE'
                 'INSTALLDIR="C:\Program Files (x86)\ArcGIS"'
                 'INSTALLDIR1="C:\Program Files (x86)\ArcGIS\Python27"'
                 '/qn'
                 "/log C:\Windows\Temp\ArcGIS-Install-$(Get-Date -Format 'yyyyMMdd-hhmmss').log")

Start-Process -FilePath "$PSScriptRoot\Setup.exe" -ArgumentList $installArgs -Wait

Start-Sleep -Seconds 5
