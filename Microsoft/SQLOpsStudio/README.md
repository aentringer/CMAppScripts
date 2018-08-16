# SQL Operations Studio Installer - Version 0.31.4 - ConfigMgr

The scripts on this page are designed to install [SQL Operations Studio](https://code.visualstudio.com/) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Download the [SQL Operations Studio Installer](https://github.com/Microsoft/sqlopsstudio/releases/download/0.31.4/sqlops-windows-setup-0.31.4.exe) from the Microsoft website.
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/SQLOpsStudio/Deploy-Application.ps1) script from this repository.
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Place the SQL Operations Studio installer in the 'Files' directory
1. Overwrite the toolkit's 'Deploy-Application.ps1' and 'AppDeployToolkitConfig.xml' with this repository's files.
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
  * Key: SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\\{EA457B21-9E10-494C-ACAB-1234DE069978}_is1
  * Value: DisplayVersion
  * Data Type: Version
  * [X] This registry setting must satisfy the following rule to indicate the presence of the application
    * Operator: Equals
    * Value: 0.31.4
