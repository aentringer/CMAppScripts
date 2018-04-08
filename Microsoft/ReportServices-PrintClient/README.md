# Reporting Services Print Client - Version 11.0.7462.6 - ConfigMgr

The scripts on this page are designed to install SQL Server Reporting Services Print Client using ConfigMgr Current Branch Application Deployment.

## Installation

1. Acquire the 32 and 64-bit Print Client files from your SQL Server Instance (substitute path as applicable:
    * 'C:\Program Filex\Microsoft SQL Server\MSRS11.INSTANCENAME\Reporting Services\ReportServer\bin\RSClientPrint-x64.cab'
    * 'C:\Program Filex\Microsoft SQL Server\MSRS11.INSTANCENAME\Reporting Services\ReportServer\bin\RSClientPrint-x86.cab'
1. Download the [Install-RSPC.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/ReportServices-PrintClient/Install-RSPC.ps1) and [Uninstall-RSPC.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/ReportServices-PrintClient/Uninstall-RSPC.ps1) scripts from this repository.
1. Create a package directory, plus two sub-directories: 'x86' and 'x64'
1. Extract the applicable .cab files into the 'x86' and 'x64' directories
1. Place the install/uninstall scripts into the root directory
1. Rename the directory to follow your organization's naming scheme (*version number, perhaps*)
1. Place the directory on your ConfigMgr Package Source
1. Build ConfigMgr Application according to your organization's procedures
1. Specify the install script in the the ConfigMgr Application Deployment Installation Program field:
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Install-RSPC.ps1"

## Uninstallation

1. Specify the uninstall script in the the ConfigMgr Application Deployment Installation Program field:
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-RSPC.ps1"

## Detection Method

* File System
  * Type: File
  * Path: %Windir%\SysWOW64\srs_rpe
  * File or folder name: rsclientprint.dll
    * [X] This file or folder is associated with a 32-bit application on 64-bit systems
  * [X] The file system setting must satisfy the following rule to indicate the presence of this application
    * Property: Version
    * Operator: Equals
    * Value: 2011.110.7462.6

AND

* File System
  * Type: File
  * Path: %Windir%\System32\srs_rpe
  * File or folder name: rsclientprint64.dll
    * [X] This file or folder is associated with a 32-bit application on 64-bit systems
  * [X] The file system setting must satisfy the following rule to indicate the presence of this application
    * Property: Version
    * Operator: Equals
    * Value: 2011.110.7462.6
