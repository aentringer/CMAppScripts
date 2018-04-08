# AzureAD PowerShell Module - ConfigMgr

The scripts on this page are designed to install [AzureAD PS Module](https://www.powershellgallery.com/packages/AzureAD/) using ConfigMgr Current Branch.

## Installation

1. Specify the [Install-AzureAD.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/PSGallery/AzureAD/Install-AzureAD.ps1) file in the ConfigMgr Deployment Method Installation Box.
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Install-AzureAD.ps1"

## Uninstallation

1. Specify the [Uninstall-AzureAD.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/PSGallery/AzureAD/Uninstall-AzureAD.ps1) file in the ConfigMgr Deployment Method Uninstallation Box.
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-AzureAD.ps1"

## Detection Method

* Script Detection

```PowerShell
if (Get-InstalledModule AzureAD -ErrorAction SilentlyContinue) {
    $true
}
```