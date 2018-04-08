# IIS Manager for Remote Administration Installer - Version 1.2 - ConfigMgr

The scripts on this page are designed to install [IIS Manager for Remote Administration](https://www.microsoft.com/en-us/download/details.aspx?id=41177) using ConfigMgr Current Branch Application Deployment.

## Installation

1. Download the [IIS Manager for Remote Administration 64-bit Installer](https://www.microsoft.com/en-us/download/confirmation.aspx?id=41177&6B49FDFB-8E5B-4B07-BC31-15695C5A2143=1) from the Microsoft website.
1. Download the [Install-IISRM.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/IIS-Remote-Management/Install-IISRM.ps1) and [Uninstall-IISRM.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/IIS-Remote-Management/Uninstall-IISRM.ps1) scripts from this repository.
1. Extract the files from the downloaded installer into a directory
1. Place the install/uninstall scripts into the same directory
1. Rename the directory to follow your organization's naming scheme (*version number, perhaps*)
1. Place the directory on your ConfigMgr Package Source
1. Build ConfigMgr Application according to your organization's procedures
1. Specify the install script in the the ConfigMgr Application Deployment Installation Program field:
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Install-IISRM.ps1"

## Uninstallation

1. Specify the uninstall script in the the ConfigMgr Application Deployment Installation Program field:
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-IISRM.ps1"

## Detection Method

* Windows Installer
  * inetmgr_amd64_en-US.msi
    * MSI GUID: {2349E6AA-CFCA-4D17-B633-3ECDA92E38CD}
    * Version (Equals): 7.1.0.0
