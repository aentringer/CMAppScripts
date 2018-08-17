# SQL Server Management Studio Installer - Version 18.1 (14.0.17277.0) - ConfigMgr

The scripts on this page are designed to install [SQL Server Management Studio](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Download the [SSMS Installer](https://go.microsoft.com/fwlink/?linkid=873126) from the Microsoft website.
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/SSMS/Deploy-Application.ps1) script from this repository.
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Place the SSMS installer in the 'Files' directory
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

* File System
  * Type: File
  * Path: %ProgramFiles(x86)%\Microsoft SQL Server\140\Tools\Binn\ManagementStudio
  * File or folder name: Ssms.exe
    * [X] This file or folder is associated with a 32-bit application on 64-bit systems
  * [X] The file system setting must satisfy the following rule to indicate the presence of this application
    * Property: Version
    * Operator: Equals
    * Value: 2017.140.17277.0
