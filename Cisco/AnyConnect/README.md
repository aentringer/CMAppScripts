# Cisco AnyConnect - Version 4.5.03040 - ConfigMgr

The scripts on this page are designed to install [Cisco AnyConnect](https://www.cisco.com/c/en/us/support/security/anyconnect-secure-mobility-client/tsd-products-support-series-home.html) using ConfigMgr Current Branch.

## Installation

1. Download the [Cisco AnyConnect Windows Installer](https://software.cisco.com/portal/pub/download/portal/select.html?&i=!m&mdfid=283000185) from the Cisco website (requires login and entitlement).
1. Specify the [Install-AnyConnect.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Cisco/AnyConnect/Install-AnyConnect.ps1 "Install-AnyConnect.ps1") file in the ConfigMgr Deployment Method Installation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Install-AnyConnect.ps1"

## Uninstallation

1. Specify the [Uninstall-AnyConnect.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Cisco/AnyConnect/Uninstall-AnyConnect.ps1 "Uninstall-AnyConnect.ps1") file in the ConfigMgr Deployment Method Uninstallation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-AnyConnect.ps1"

## Detection Method

* Windows Installer
  * anyconnect-win-4.5.03040-core-vpn-predeploy-k9.msi
    * GUID: {F5DC7FFF-49E9-45F3-B42E-36FE963573DB}
    * Version (Equals): 4.5.03040
