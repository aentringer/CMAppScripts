# Fira Code Font Installer - Version 1.205 - ConfigMgr

The scripts on this page are designed to install [Fira Code](https://github.com/tonsky/FiraCode) using ConfigMgr Current Branch Application Deployment.

## Installation

1. Download the [Fira Code Fonts](https://github.com/tonsky/FiraCode/releases/download/1.205/FiraCode_1.205.zip) from the Fira Code GitHub.
1. Download the [PS_Font_Scripts.zip](https://msdnshared.blob.core.windows.net/media/TNBlogsFS/prod.evol.blogs.technet.com/telligent.evolution.components.attachments/01/6127/00/00/03/37/31/38/PS_Font_Scripts.zip) from [The Deployment Guys blog](https://blogs.technet.microsoft.com/deploymentguys/2010/12/04/adding-and-removing-fonts-with-windows-powershell/).
1. Download the [Install-FiraCode.ps1](https://github.com/aentringer/CMAppScripts/raw/master/FiraCode/Install-FiraCode.ps1) and [Uninstall-FiraCode.ps1](https://github.com/aentringer/CMAppScripts/raw/master/FiraCode/Uninstall-FiraCode.ps1) scripts from this repository.
1. Extract the contents of the 'otf' folder from the downloaded fonts archive into a directory
1. Extract the PS_Font_Scripts into the same directory
1. Place the install/uninstall scripts into the same directory
1. Rename the directory to follow your organization's naming scheme (*version number, perhaps*)
1. Place the directory on your ConfigMgr Package Source
1. Build ConfigMgr Application according to your organization's procedures
1. Specify the install script in the the ConfigMgr Application Deployment Installation Program field:
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Install-FiraCode.ps1"

## Uninstallation

1. Specify the uninstall script in the the ConfigMgr Application Deployment Installation Program field:
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-FiraCode.ps1"

## Detection Method

* Script Detection

```PowerShell
$version = '1.205'
$Success = 0

if (Test-Path 'C:\Windows\Fonts\FiraCode-Bold.otf' -ErrorAction SilentlyContinue) {
    $Success += 1
}

if (Test-Path 'C:\Windows\Fonts\FiraCode-Light.otf' -ErrorAction SilentlyContinue) {
    $Success += 1
}

if (Test-Path 'C:\Windows\Fonts\FiraCode-Medium.otf' -ErrorAction SilentlyContinue) {
    $Success += 1
}

if (Test-Path 'C:\Windows\Fonts\FiraCode-Regular.otf' -ErrorAction SilentlyContinue) {
    $Success += 1
}

if (Test-Path 'C:\Windows\Fonts\FiraCode-Retina.otf' -ErrorAction SilentlyContinue) {
    $Success += 1
}

$FiraKeys = @(
    'Fira Code Bold (OpenType)'
    'Fira Code Light (OpenType)'
    'Fira Code Medium (OpenType)'
    'Fira Code Regular (OpenType)'
    'Fira Code Retina (OpenType)'
)
foreach ($Key in $FiraKeys) {
    if ((Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts' -Name $Key -ErrorAction SilentlyContinue).$Key) {
        $Success += 1
    }
}

if ((Get-ItemProperty -Path 'HKLM:\SOFTWARE\FiraCode' -Name FiraCodeVersion -ErrorAction SilentlyContinue).FiraCodeVersion -eq $version) {
    $Success += 1
}

if ($Success -eq 11) {
    Write-Host 'FiraCode font installed successfully!'
}
```
