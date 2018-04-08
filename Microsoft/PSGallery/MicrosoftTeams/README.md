# MicrosoftTeams PowerShell Module - ConfigMgr

The scripts on this page are designed to install [MicrosoftTeams PS Module](https://www.powershellgallery.com/packages/MicrosoftTeams) using ConfigMgr Current Branch.

## Installation

1. Specify the [Install-MicrosoftTeams.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/PSGallery/MicrosoftTeams/Install-MicrosoftTeams.ps1) file in the ConfigMgr Deployment Method Installation Box.
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Install-MicrosoftTeams.ps1"

## Uninstallation

1. Specify the [Uninstall-MicrosoftTeams.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/PSGallery/MicrosoftTeams/Uninstall-MicrosoftTeams.ps1) file in the ConfigMgr Deployment Method Uninstallation Box.
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-MicrosoftTeams.ps1"

## Detection Method

* Script Detection

```PowerShell
if (Get-InstalledModule MicrosoftTeams -ErrorAction SilentlyContinue) {
    $true
}
```