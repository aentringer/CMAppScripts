# Visual C++ Installer - Version 2008 - 2017 - ConfigMgr

The scripts on this page are designed to install [Visual C++ Redistributables](https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads) using ConfigMgr Current Branch Application Deployment.

## Installation

1. Download the [Install-VisualCRedist.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/VisualC++/Install-VisualCRedist.ps1) and [Uninstall-VisualCRedist.ps1](https://github.com/aentringer/CMAppScripts/raw/master/Microsoft/VisualC++/Uninstall-VisualCRedist.ps1) scripts from this repository.
1. Extract the files from the downloaded installer into a directory
1. Place the install/uninstall scripts into the same directory
1. Rename the directory to follow your organization's naming scheme (*version number, perhaps*)
1. Place the directory on your ConfigMgr Package Source
1. Build ConfigMgr Application according to your organization's procedures
1. Specify the install script in the the ConfigMgr Application Deployment Installation Program field:
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Install-VisualCRedist.ps1"

## Uninstallation

***It is not recommended to use this unless you know for certain that you want to remove all Visual C++ Redistributables on the system. This could break applications. The script is provided for future use when versions become deprecated/unsupported.***

1. Specify the install script in the the ConfigMgr Application Deployment Installation Program field:
    * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File ".\Uninstall-VisualCRedist.ps1"

## Detection Method

    * Windows Installer
    * Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.6161
        * MSI GUID: {9BE518E6-ECC6-35A9-88E4-87755C07200F}
        * Version (Equals): 9.0.30729.6161

    AND

    * Windows Installer
    * Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.6161
        * MSI GUID: {5FCE6D76-F5DC-37AB-B2B8-22AB8CEDB1D4}
        * Version (Equals): 9.0.30729.6161

    AND

    * Windows Installer
    * Microsoft Visual C++ 2010  x86 Redistributable - 10.0.40219
        * MSI GUID: {F0C3E5D1-1ADE-321E-8167-68EF0DE699A5}
        * Version (Equals): 10.0.40219

    AND

    * Windows Installer
    * Microsoft Visual C++ 2010  x64 Redistributable - 10.0.40219
        * MSI GUID: {1D8E6291-B0D5-35EC-8441-6616F567A0F7}
        * Version (Equals): 10.0.40219

    AND

    * Windows Installer
    * Microsoft Visual C++ 2012 x86 Minimum Runtime - 11.0.61030
        * MSI GUID: {BD95A8CD-1D9F-35AD-981A-3E7925026EBB}
        * Version (Equals): 11.0.61030

    AND

    * Windows Installer
    * Microsoft Visual C++ 2012 x64 Minimum Runtime - 11.0.61030
        * MSI GUID: {CF2BEA3C-26EA-32F8-AA9B-331F7E34BA97}
        * Version (Equals): 11.0.61030

    AND

    * Windows Installer
    * Microsoft Visual C++ 2013 x86 Minimum Runtime - 12.0.40660
        * MSI GUID: {E30D8B21-D82D-3211-82CC-0F0A5D1495E8}
        * Version (Equals): 12.0.40660

    AND

    * Windows Installer
    * Microsoft Visual C++ 2013 x64 Minimum Runtime
        * MSI GUID: {CB0836EC-B072-368D-82B2-D3470BF95707}
        * Version (Equals): 12.0.40660

    AND

    * Windows Installer
    * Microsoft Visual C++ 2017 x86 Minimum Runtime - 14.13.26020
        * MSI GUID: {8F271F6C-6E7B-3D0A-951B-6E7B694D78BD}
        * Version (Equals): 14.13.26020

    AND

    * Windows Installer
    * Microsoft Visual C++ 2017 x64 Minimum Runtime - 14.13.26020
        * MSI GUID: {221D6DB4-46E2-333C-B09B-5F49351D0980}
        * Version (Equals): 14.13.26020
