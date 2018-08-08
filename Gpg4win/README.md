# Gpg4win Installer - Version 3.0.3 - ConfigMgr

The scripts on this page are designed to install [Gpg4win](https://www.gpg4win.org/index.html) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Download the [Gpg4win Installer](https://files.gpg4win.org/gpg4win-3.0.3.exe) from the Gpg4win website.
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Gpg4win/Deploy-Application.ps1) script from this repository.
1. Download the [gpg4win.ini](https://github.com/aentringer/CMAppScripts/raw/master/Gpg4win/Files/gpg4win.ini) file from this repository.
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Place the Gpg4win installer in the 'Files' directory
1. Place the 'gpg4win.ini' file in the 'Files' directory
1. Overwrite the toolkit's 'Deploy-Application.ps1' with this repository's script.
1. Rename 'Toolkit' directory to follow your organization's naming scheme (*version number, perhaps*)
1. Place the directory on your ConfigMgr Package Source
1. Build ConfigMgr Application according to your organization's procedures
1. Specify the Deploy-Application.exe installer in the the ConfigMgr Application Deployment Installation Program field:
    * Deploy-Application.exe -DeploymentType Install

## Uninstallation

1. Specify the Deploy-Application.exe uninstaller in the the ConfigMgr Application Deployment Installation Program field:
    * Deploy-Application.exe -DeploymentType Uninstall

## Detection Method

* Registry
  * Hive: HKEY_LOCAL_MACHINE
  * Key: SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Gpg4win
  * Value: DisplayVersion
    * [X] This registry key is associated with a 32-bit application on 64-bit systems
  * Data Type: String
  * [X] This registry setting must satisfy the following rule to indicate the presence of the application
    * Operator: Equals
    * Value: 3.1.2
