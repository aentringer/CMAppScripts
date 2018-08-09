# ConfigMgr Console Installer - Version 1806 (5.1806.1074.1200) - ConfigMgr

The scripts on this page are designed to install ConfigMgr Console using ConfigMgr Current Branch Application Deployment. This installer leverages the [PowerShell App Deployment Toolkit](http://psappdeploytoolkit.com/).

## Installation

1. Acquire the Console Install files from your Primary Site: \\\SITESERVERNAME\SMS_SITECODE\tools\ConsoleSetup
1. Download the [latest release](https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/latest) of PowerShell App Deployment Toolkit.
1. Download the [Deploy-Application.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/ConfigMgrConsole/Deploy-Application.ps1) script from this repository.
1. Edit the installation command in 'Deploy-Application.ps1' (line 142) to change 'DefaultSiteServerName=YOURSITENAMEHERE' to your site server's FQDN, such as 'DefaultSiteServerName=cm01.contoso.local'
1. Extract the 'Toolkit' directory from the PowerShell App Deployment Toolkit
1. Place the Console Install files in the 'Files' directory
1. Overwrite the toolkit's 'Deploy-Application.ps1' with your edited copy of this repository's script.
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
>   * Path: %ProgramFiles(x86)%\Microsoft Configuration Manager\AdminConsole\bin
>   * File or folder name: Microsoft.ConfigurationManagement.exe
>     * [X] This file or folder is associated with a 32-bit application on 64-bit systems
>   * [X] The file system setting must satisfy the following rule to indicate the presence of this application
>   * Property: Version
>   * Operator: Equals
>   * Value: 5.1806.1074.1000
>
> AND
>
> * Registry
>   * Hive: HKEY_LOCAL_MACHINE
>   * Key: SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\\{664D6976-FEF0-4B9A-ABB4-3F0465D3FA7F}
>   * Value: Comments
>   * Data Type: String
>   * [X] This registry setting must satisfy the following rule to indicate the presence of the application
>     * Operator: Equals
>     * Value: Includes 5.1806.1074.1200 update