# Cisco VPN Client - Version 5.0.07.0440 - ConfigMgr

The scripts on this page are designed to install the deprecated/unsupported Cisco VPN client using ConfigMgr Current Branch. Instructions/downloads obtained from [IT That Should Just Work](https://itthatshouldjustwork.blogspot.com/2017/04/solved-cisco-vpn-client-on-windows-10.html).

## Installation

1. Download the [Dell Sonicwall 64-bit Installer](https://www.dropbox.com/s/8yqw74n4mrgpff0/GVCSetup64_4.9.4.0306_EN.exe?dl=0).
    * Using archive software, such as 7-Zip, extract GVCInstall64.msi from downloaded .exe.
1. Download the [Cisco VPN 64-bit Installer](https://www.dropbox.com/s/8xkijxtnu2lbdev/vpnclient-winx64-msi-5.0.07.0440-k9.exe?dl=0).
    * Using archive software, such as 7-Zip, extract vpnclient_setup.msi from downloaded .exe.
1. Specify the [Install-CiscoVPN.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Cisco/CiscoVPN/Install-CiscoVPN.ps1 "Install-CiscoVPN.ps1") file in the ConfigMgr Deployment Method Installation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Install-CiscoVPN.ps1"

## Uninstallation

1. Specify the [Uninstall-CiscoVPN.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Cisco/CiscoVPN/Uninstall-CiscoVPN.ps1 "Uninstall-CiscoVPN.ps1") file in the ConfigMgr Deployment Method Uninstallation Box.
    * powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-CiscoVPN.ps1"

## Detection Method

* Windows Installer
  * vpnclient_setup.msi
    * GUID: {5FDC06BF-3D3D-4367-8FFB-4FAFCB61972D}
* Registry
  * Hive: HKEY_LOCAL_MACHINE
  * Key: SYSTEM\CurrentControlSet\Services\CVirtA
  * Value: DisplayName
  * Data Type: String
  * Equals: Cisco Systems VPN Adapter for 64-bit Windows
