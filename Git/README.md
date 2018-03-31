# Git Installer - Version 2.16.2 - ConfigMgr

The scripts on this page are designed to install [Git](https://git-scm.com/) using ConfigMgr Current Branch Application Deployment.

## Installation

1. Download the [Git Installer](https://github.com/git-for-windows/git/releases/download/v2.16.2.windows.1/Git-2.16.2-64-bit.exe) from the Git website.
1. Download the [Install-Git.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Git/Install-Git.ps1) and [Uninstall-Git.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Git/Uninstall-Git.ps1) scripts from this repository.
1. Place the Git installer and install/uninstall scripts into a directory
1. Rename the directory to follow your organization's naming scheme (*version number, perhaps*)
1. Place the directory on your ConfigMgr Package Source
1. Build ConfigMgr Application according to your organization's procedures
1. Specify the install script in the the ConfigMgr Application Deployment Installation Program field:
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Install-Git.ps1"

## Uninstallation

1. Specify the uninstall script in the the ConfigMgr Application Deployment Installation Program field:
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-Git.ps1"

## Detection Method

* Registry
  * Hive: HKEY_LOCAL_MACHINE
  * Key: SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1
  * Value: DisplayVersion
  * Data Type: String
  * [X] This registry setting must satisfy the following rule to indicate the presence of the application
    * Operator: Equals
    * Value: 2.16.2
