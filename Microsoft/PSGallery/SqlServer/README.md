# SqlServer PowerShell Module - ConfigMgr

The scripts on this page are designed to install [SqlServer PS Module](https://www.powershellgallery.com/packages/SqlServer) using ConfigMgr Current Branch.

## Installation

1. Specify the [Install-SqlServer.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/PSGallery/SqlServer/Install-SqlServer.ps1) file in the ConfigMgr Deployment Method Installation Box.
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Install-SqlServer.ps1"

## Uninstallation

1. Specify the [Uninstall-SqlServer.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/PSGallery/SqlServer/Uninstall-SqlServer.ps1) file in the ConfigMgr Deployment Method Uninstallation Box.
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-SqlServer.ps1"

## Detection Method

* Script Detection

```PowerShell
if (Get-InstalledModule SqlServer -ErrorAction SilentlyContinue) {
    $true
}
```