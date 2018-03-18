# Able2Extract Installer - Version 12.0.3 - ConfigMgr

The scripts on this page are designed to install [Investintech.com's Able2Extract](https://www.investintech.com/products/desktop/) using ConfigMgr Current Branch.

## Installation

1. Download the [Trial Installer](https://www.investintech.com/download/InstallAble2ExtractPro.exe "InstallAble2ExtractPro.exe") from the Investintech.com website.
1. Place the installer in the same directory as this folder's a2e.inf and Install-Able2Extract.ps1 files.
1. Specify the [Install-Able2Extract.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Able2Extract/Install-Able2Extract.ps1 "Install-Able2Extract.ps1") file in the ConfigMgr Deployment Method Installation Box.

### *Users will specify license manually, post-installation*

## Uninstallation

1. Specify the [Uninstall-Able2Extract.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Able2Extract/Uninstall-Able2Extract.ps1 "Uninstall-Able2Extract.ps1") file in the ConfigMgr Deployment Method Uninstallation Box.

## Detection Method

    * Folder: 'C:\Program Files (x86)\Investintech.com Inc\Able2Extract Professional 12.0'
    * File: 'Able2ExtractPro.exe'
    * Version (Equals): '12.0.3'
