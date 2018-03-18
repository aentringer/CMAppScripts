# Able2Extract Installer - Version 12.0.3 - ConfigMgr

The scripts on this page are designed to install [Investintech.com's Able2Extract](https://www.investintech.com/products/desktop/) using ConfigMgr Current Branch.

## Installation

1. Download the [Trial Installer](https://www.investintech.com/download/InstallAble2ExtractPro.exe "InstallAble2ExtractPro.exe") from the Investintech.com website.
1. Place the installer in the same directory as this folder's a2e.inf and Install-Able2Extract.ps1 files.
1. Specify the [Install-Able2Extract.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Able2Extract/Install-Able2Extract.ps1 "Install-Able2Extract.ps1") file in the ConfigMgr Deployment Method Installation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Install-Able2Extract.ps1"

### *Users will specify license manually, post-installation*

## Uninstallation

1. Specify the [Uninstall-Able2Extract.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Able2Extract/Uninstall-Able2Extract.ps1 "Uninstall-Able2Extract.ps1") file in the ConfigMgr Deployment Method Uninstallation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-Able2Extract.ps1"

## Detection Method

* File System
  * Path: '%ProgramFiles(x86)%\Investintech.com Inc\Able2Extract Professional 12.0'
  * File or folder name: 'Able2ExtractPro.exe'
    * [X] This file or folder is associated with a 32-bit application or 64-bit system
  * Version (Equals): '12.0.3'
