# KeePass Installer - Version 2.39.1 - ConfigMgr

The scripts on this page are designed to install [KeePass](https://keepass.info/) using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Download the [KeePass Installer](https://downloads.sourceforge.net/project/keepass/KeePass%202.x/2.39.1/KeePass-2.39.1-Setup.exe) from the KeePass website.
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/KeePass/Deploy-Application.ps1) script from this repository.
1. Download the [keepass.inf](https://github.com/aentringer/CMAppScripts/raw/master/KeePass/Files/keepass.inf) and [KeePass.config.enforced.xml](https://github.com/aentringer/CMAppScripts/raw/master/KeePass/Files/KeePass.config.enforced.xml) files from this repository.
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Place the KeePass installer, keepass.inf, and KeePass.config.enforced.xml files in the 'Files' directory
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

> * File System
>   * Type: File
>   * Path: %ProgramFiles(x86)%\KeePass Password Safe 2
>   * File or folder name: KeePass.exe
>     * [X] This file or folder is associated with a 32-bit application on 64-bit systems
>   * [X] The file system setting must satisfy the following rule to indicate the presence of this application
>     * Property: Version
>     * Operator: Equals
>     * Value: 2.39.1.0
>
> AND
>
> * File System
>   * Type: File
>   * Path: %ProgramFiles(x86)%\KeePass Password Safe 2
>   * File or folder name: KeePass.config.enforced.xml
>     * [X] This file or folder is associated with a 32-bit application on 64-bit systems
>   * [X] The file system setting must exist on the target system to indicate the presence of this application