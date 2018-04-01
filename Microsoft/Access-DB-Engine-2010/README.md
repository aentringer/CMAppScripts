# Access Database Engine 2010 Installer - Version 14.0.7015.1000 - ConfigMgr

The scripts on this page are designed to install [Access Database Engine 2010](https://www.microsoft.com/en-US/download/details.aspx?id=13255) using ConfigMgr Current Branch Application Deployment.

## Installation

*You can install 32-bit Access Database Engine 2010 alongside 64-bit Office if using Click-to-Run version of Office. It is recommended to install Office first and then install the Access Database Engine.*

1. Download the [Access Database Engine 2010 32-bit Installer](https://www.microsoft.com/en-us/download/confirmation.aspx?id=13255&6B49FDFB-8E5B-4B07-BC31-15695C5A2143=1) from the Microsoft website.
1. Download the [Install-AccessRedist.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/Access-DB-Engine-2010/Install-AccessRedist.ps1) and [Uninstall-AccessRedist.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/Access-DB-Engine-2010/Uninstall-AccessRedist.ps1) scripts from this repository.
1. Extract the files from the downloaded installer into a directory
1. Place the install/uninstall scripts into the same directory
1. Rename the directory to follow your organization's naming scheme (*version number, perhaps*)
1. Place the directory on your ConfigMgr Package Source
1. Build ConfigMgr Application according to your organization's procedures
1. Specify the install script in the the ConfigMgr Application Deployment Installation Program field:
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Install-AccessRedist.ps1"

## Uninstallation

1. Specify the uninstall script in the the ConfigMgr Application Deployment Installation Program field:
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-AccessRedist.ps1"

## Detection Method

* Windows Installer
  * AceRedist.msi
    * MSI GUID: {90140000-00D1-0409-0000-0000000FFICE}
    * Version (Equals): 14.0.7015.1000

AND

* File System
  * Type: File
  * Path: %ProgramFiles(x86)%\Common Files\Microsoft Shared\OFFICE14
  * File or folder name: ACEEXCL.DLL
    * [X] This file or folder is associated with a 32-bit application on 64-bit systems
  * [X] The file system setting must satisfy the following rule to indicate the presence of this application
    * Property: Version
    * Operator: Equals
    * Value: 14.0.7015.1000
