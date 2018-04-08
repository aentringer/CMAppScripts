# MSOnline PowerShell Module - ConfigMgr

The scripts on this page are designed to install [MSOnline PS Module](https://www.powershellgallery.com/packages/MSOnline) using ConfigMgr Current Branch.

## Installation

1. Specify the [Install-MSOnline.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/PSGallery/MSOnline/Install-MSOnline.ps1) file in the ConfigMgr Deployment Method Installation Box.
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Install-MSOnline.ps1"

## Uninstallation

1. Specify the [Uninstall-MSOnline.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/PSGallery/MSOnline/Uninstall-MSOnline.ps1) file in the ConfigMgr Deployment Method Uninstallation Box.
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-MSOnline.ps1"

## Detection Method

* Script Detection

```PowerShell
if (Get-InstalledModule MSOnline -ErrorAction SilentlyContinue) {
    $true
}
```