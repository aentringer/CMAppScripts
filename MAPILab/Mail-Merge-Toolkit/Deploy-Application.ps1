<#
.SYNOPSIS
    This script performs the installation or uninstallation of an application(s).
	# LICENSE #
	PowerShell App Deployment Toolkit - Provides a set of functions to perform common application deployment tasks on Windows. 
	Copyright (C) 2017 - Sean Lillis, Dan Cunningham, Muhammad Mashwani, Aman Motazedian.
	This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. 
	You should have received a copy of the GNU Lesser General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
.DESCRIPTION
	The script is provided as a template to perform an install or uninstall of an application(s).
	The script either performs an "Install" deployment type or an "Uninstall" deployment type.
	The install deployment type is broken down into 3 main sections/phases: Pre-Install, Install, and Post-Install.
	The script dot-sources the AppDeployToolkitMain.ps1 script which contains the logic and functions required to install or uninstall an application.
.PARAMETER DeploymentType
	The type of deployment to perform. Default is: Install.
.PARAMETER DeployMode
	Specifies whether the installation should be run in Interactive, Silent, or NonInteractive mode. Default is: Interactive. Options: Interactive = Shows dialogs, Silent = No dialogs, NonInteractive = Very silent, i.e. no blocking apps. NonInteractive mode is automatically set if it is detected that the process is not user interactive.
.PARAMETER AllowRebootPassThru
	Allows the 3010 return code (requires restart) to be passed back to the parent process (e.g. SCCM) if detected from an installation. If 3010 is passed back to SCCM, a reboot prompt will be triggered.
.PARAMETER TerminalServerMode
	Changes to "user install mode" and back to "user execute mode" for installing/uninstalling applications for Remote Destkop Session Hosts/Citrix servers.
.PARAMETER DisableLogging
	Disables logging to file for the script. Default is: $false.
.EXAMPLE
    powershell.exe -Command "& { & '.\Deploy-Application.ps1' -DeployMode 'Silent'; Exit $LastExitCode }"
.EXAMPLE
    powershell.exe -Command "& { & '.\Deploy-Application.ps1' -AllowRebootPassThru; Exit $LastExitCode }"
.EXAMPLE
    powershell.exe -Command "& { & '.\Deploy-Application.ps1' -DeploymentType 'Uninstall'; Exit $LastExitCode }"
.EXAMPLE
    Deploy-Application.exe -DeploymentType "Install" -DeployMode "Silent"
.NOTES
	Toolkit Exit Code Ranges:
	60000 - 68999: Reserved for built-in exit codes in Deploy-Application.ps1, Deploy-Application.exe, and AppDeployToolkitMain.ps1
	69000 - 69999: Recommended for user customized exit codes in Deploy-Application.ps1
	70000 - 79999: Recommended for user customized exit codes in AppDeployToolkitExtensions.ps1
.LINK
	http://psappdeploytoolkit.com
#>
[CmdletBinding()]
Param (
	[Parameter(Mandatory=$false)]
	[ValidateSet('Install','Uninstall')]
	[string]$DeploymentType = 'Install',
	[Parameter(Mandatory=$false)]
	[ValidateSet('Interactive','Silent','NonInteractive')]
	[string]$DeployMode = 'Interactive',
	[Parameter(Mandatory=$false)]
	[switch]$AllowRebootPassThru = $false,
	[Parameter(Mandatory=$false)]
	[switch]$TerminalServerMode = $false,
	[Parameter(Mandatory=$false)]
	[switch]$DisableLogging = $false
)

Try {
	## Set the script execution policy for this process
	Try { Set-ExecutionPolicy -ExecutionPolicy 'ByPass' -Scope 'Process' -Force -ErrorAction 'Stop' } Catch {}

	##*===============================================
	##* VARIABLE DECLARATION
	##*===============================================
	## Variables: Application
	[string]$appVendor = 'MAPILab'
	[string]$appName = 'Mail Merge Toolkit'
	[string]$appVersion = '2.12.3.3'
	[string]$appArch = ''
	[string]$appLang = 'EN'
	[string]$appRevision = '01'
	[string]$appScriptVersion = '1.0.0'
	[string]$appScriptDate = '09/28/2017'
	[string]$appScriptAuthor = 'Alex Entringer'
	##*===============================================
	## Variables: Install Titles (Only set here to override defaults set by the toolkit)
	[string]$installName = ''
	[string]$installTitle = ''

	##* Do not modify section below
	#region DoNotModify

	## Variables: Exit Code
	[int32]$mainExitCode = 0

	## Variables: Script
	[string]$deployAppScriptFriendlyName = 'Deploy Application'
	[version]$deployAppScriptVersion = [version]'3.7.0'
	[string]$deployAppScriptDate = '02/13/2018'
	[hashtable]$deployAppScriptParameters = $psBoundParameters

	## Variables: Environment
	If (Test-Path -LiteralPath 'variable:HostInvocation') { $InvocationInfo = $HostInvocation } Else { $InvocationInfo = $MyInvocation }
	[string]$scriptDirectory = Split-Path -Path $InvocationInfo.MyCommand.Definition -Parent

	## Dot source the required App Deploy Toolkit Functions
	Try {
		[string]$moduleAppDeployToolkitMain = "$scriptDirectory\AppDeployToolkit\AppDeployToolkitMain.ps1"
		If (-not (Test-Path -LiteralPath $moduleAppDeployToolkitMain -PathType 'Leaf')) { Throw "Module does not exist at the specified location [$moduleAppDeployToolkitMain]." }
		If ($DisableLogging) { . $moduleAppDeployToolkitMain -DisableLogging } Else { . $moduleAppDeployToolkitMain }
	}
	Catch {
		If ($mainExitCode -eq 0){ [int32]$mainExitCode = 60008 }
		Write-Error -Message "Module [$moduleAppDeployToolkitMain] failed to load: `n$($_.Exception.Message)`n `n$($_.InvocationInfo.PositionMessage)" -ErrorAction 'Continue'
		## Exit the script, returning the exit code to SCCM
		If (Test-Path -LiteralPath 'variable:HostInvocation') { $script:ExitCode = $mainExitCode; Exit } Else { Exit $mainExitCode }
	}

	#endregion
	##* Do not modify section above
	##*===============================================
	##* END VARIABLE DECLARATION
	##*===============================================

	If ($deploymentType -ine 'Uninstall') {
		##*===============================================
		##* PRE-INSTALLATION
		##*===============================================
		[string]$installPhase = 'Pre-Installation'

		## Show Welcome Message
		Show-InstallationWelcome -CloseApps 'outlook,winword,mspub,iexplore' -CloseAppsCountdown 6000 -MinimizeWindows $false -PersistPrompt

		## Show Progress Message (with the default message)
		Show-InstallationProgress -WindowLocation 'BottomRight' -TopMost $false

		## <Perform Pre-Installation tasks here>
		# Remove any existing versions of the toolkit
		Execute-MSI -Action Uninstall -Path '{B008D66F-B796-4C06-B707-932F0B225531}'

		# Shut down the 'Why did you uninstall?' window
		Start-Sleep -Seconds 5
		Stop-Process -Name iexplore -Force -Confirm:$false

		$CurrentUser = (Get-CimInstance -ClassName Win32_ComputerSystem -Property Username).Username.Split('\')[-1]
		$UserProfile = Get-ChildItem -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\ProfileList' |
			ForEach-Object {
				[PSCustomObject]@{
					'SID' = $_.PSChildName
					'UserName' = (Get-ItemPropertyValue -Path $_.PSPath -Name ProfileImagePath).Split('\')[-1]
				}
			} | Where-Object { $_.UserName -eq $CurrentUser }
		$UserReg = "Registry::HKEY_USERS\$($UserProfile.SID)"

		# Remove old registration to allow it to prompt again for setup (in case of bad old installation)
		if (Test-Path -Path "$UserReg\Software\MAPILab Ltd") {
			Remove-Item -Path "$UserReg\Software\MAPILab Ltd" -Recurse -Force -Confirm:$false
		}

		##*===============================================
		##* INSTALLATION
		##*===============================================
		[string]$installPhase = 'Installation'

		## Handle Zero-Config MSI Installations
		If ($useDefaultMsi) {
			[hashtable]$ExecuteDefaultMSISplat =  @{ Action = 'Install'; Path = $defaultMsiFile }; If ($defaultMstFile) { $ExecuteDefaultMSISplat.Add('Transform', $defaultMstFile) }
			Execute-MSI @ExecuteDefaultMSISplat; If ($defaultMspFiles) { $defaultMspFiles | ForEach-Object { Execute-MSI -Action 'Patch' -Path $_ } }
		}

		## <Perform Installation tasks here>
		if ((Get-ItemPropertyValue 'HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration' -Name 'Platform') -eq 'x64') {
			Execute-Process -Path "$dirFiles\Setup for Outlook 64-bit.exe" -Parameters "/S /v`"/qn REBOOT=ReallySuppress ALLUSERS=1 ApplicationUsers=AllUsers AcceptLicense=Yes /log C:\Windows\Temp\MailMergeKit-Install-$(Get-Date -Format 'yyyyMMdd-hhmmss').log`""
		}
		else {
			Execute-Process -Path "$dirFiles\Setup for Outlook.exe" -Parameters "/S /v`"/qn REBOOT=ReallySuppress ALLUSERS=1 ApplicationUsers=AllUsers AcceptLicense=Yes /log C:\Windows\Temp\MailMergeKit-Install-$(Get-Date -Format 'yyyyMMdd-hhmmss').log`""
		}

		##*===============================================
		##* POST-INSTALLATION
		##*===============================================
		[string]$installPhase = 'Post-Installation'

		## <Perform Post-Installation tasks here>
		# Create necessary keys in HKCU to prompt for Mail Merge Setup/Key
		if (-not (Test-Path "$UserReg\Software\Microsoft\Office\Outlook\Addins\MAPILab.MMTOutlookSender")) {
			New-Item -Path "$UserReg\Software\Microsoft\Office\Outlook\Addins\MAPILab.MMTOutlookSender" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Microsoft\Office\Publisher\Addins\MAPILab.MMTAddin")) {
			New-Item -Path "$UserReg\Software\Microsoft\Office\Publisher\Addins\MAPILab.MMTAddin" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Microsoft\Office\Word\Addins\MAPILab.MMTAddin")) {
			New-Item -Path "$UserReg\Software\Microsoft\Office\Word\Addins\MAPILab.MMTAddin" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\AppID\MMTProg.DLL")) {
			New-Item -Path "$UserReg\Software\Classes\AppID\MMTProg.DLL" -Force -Confirm:$false > $null
		}
		if(-not (Test-Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}")) {
			New-Item -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\InprocServer32")) {
			New-Item -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\InprocServer32" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\ProgID")) {
			New-Item -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\ProgID" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\Programmable")) {
			New-Item -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\Programmable" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\TypeLib")) {
			New-Item -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\TypeLib" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\VersionIndependentProgID")) {
			New-Item -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\VersionIndependentProgID" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}")) {
			New-Item -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\InprocServer32")) {
			New-Item -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\InprocServer32" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\ProgID")) {
			New-Item -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\ProgID" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\Programmable")) {
			New-Item -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\Programmable" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\TypeLib")) {
			New-Item -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\TypeLib" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\VersionIndependentProgID")) {
			New-Item -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\VersionIndependentProgID" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\MAPILab.MMTAddin")) {
			New-Item -Path "$UserReg\Software\Classes\MAPILab.MMTAddin" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\MAPILab.MMTAddin\CLSID")) {
			New-Item -Path "$UserReg\Software\Classes\MAPILab.MMTAddin\CLSID" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\MAPILab.MMTAddin\CurVer")) {
			New-Item -Path "$UserReg\Software\Classes\MAPILab.MMTAddin\CurVer" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\MAPILab.MMTAddin.1")) {
			New-Item -Path "$UserReg\Software\Classes\MAPILab.MMTAddin.1" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\MAPILab.MMTAddin.1\CLSID")) {
			New-Item -Path "$UserReg\Software\Classes\MAPILab.MMTAddin.1\CLSID" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender")) {
			New-Item -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender\CLSID")) {
			New-Item -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender\CLSID" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender\CurVer")) {
			New-Item -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender\CurVer" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender.1")) {
			New-Item -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender.1" -Force -Confirm:$false > $null
		}
		if (-not (Test-Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender.1\CLSID")) {
			New-Item -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender.1\CLSID" -Force -Confirm:$false > $null
		}
		Set-ItemProperty -Path "$UserReg\Software\Microsoft\Office\Outlook\Addins\MAPILab.MMTOutlookSender" -Name 'LoadBehavior' -Value 3 -Type DWord -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Microsoft\Office\Outlook\Addins\MAPILab.MMTOutlookSender" -Name 'CommandLineSafe' -Value 0 -Type DWord -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Microsoft\Office\Outlook\Addins\MAPILab.MMTOutlookSender" -Name 'Description' -Value "MS Word and MS Publisher Addin to produce e-mail messages." -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Microsoft\Office\Outlook\Addins\MAPILab.MMTOutlookSender" -Name 'FriendlyName' -Value "Mail Merge Toolkit" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Microsoft\Office\Publisher\Addins\MAPILab.MMTAddin" -Name 'LoadBehavior' -Value 3 -Type DWord -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Microsoft\Office\Publisher\Addins\MAPILab.MMTAddin" -Name 'CommandLineSafe' -Value 0 -Type DWord -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Microsoft\Office\Publisher\Addins\MAPILab.MMTAddin" -Name 'FriendlyName' -Value "Mail Merge Toolkit" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Microsoft\Office\Publisher\Addins\MAPILab.MMTAddin" -Name 'Description' -Value "MS Word and MS Publisher Addin to produce e-mail messages." -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Microsoft\Office\Word\Addins\MAPILab.MMTAddin" -Name 'LoadBehavior' -Value 3 -Type DWord -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Microsoft\Office\Word\Addins\MAPILab.MMTAddin" -Name 'CommandLineSafe' -Value 0 -Type DWord -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Microsoft\Office\Word\Addins\MAPILab.MMTAddin" -Name 'Description' -Value "MS Word and MS Publisher Addin to produce e-mail messages." -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Microsoft\Office\Word\Addins\MAPILab.MMTAddin" -Name 'FriendlyName' -Value "Mail Merge Toolkit" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\AppID\MMTProg.DLL" -Name 'AppID' -Value "{3E25FA99-C8F9-453E-881E-A2DF8E12C07F}" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}" -Name '(default)' -Value "MMTOutlookSender Class" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}" -Name 'AppID' -Value "{09F3BA86-2BAC-4D09-82AC-15CD241E1281}" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\InprocServer32" -Name '(default)' -Value "C:\Program Files\MAPILab Ltd\Mail Merge Toolkit\OutlookSenderAddin.dll" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\InprocServer32" -Name 'InprocServer32' -Value @("~n(Yat}yL@T``b@3,Keq3>h5cWtmc!b9]Bq3gPiJnb") -Type MultiString -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\InprocServer32" -Name 'ThreadingModel' -Value "Apartment" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\ProgID" -Name '(default)' -Value "MAPILab.MMTOutlookSender.1" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\Programmable" -Name '(default)' -Value "" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\TypeLib" -Name '(default)' -Value "{3E880251-2120-416B-9F89-10EAA21B1969}" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}\VersionIndependentProgID" -Name '(default)' -Value "MAPILab.MMTOutlookSender" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}" -Name '(default)' -Value "MMTAddin Class" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}" -Name 'AppID' -Value "{3E25FA99-C8F9-453E-881E-A2DF8E12C07F}" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\InprocServer32" -Name '(default)' -Value "C:\Program Files\MAPILab Ltd\Mail Merge Toolkit\MMTProg.dll" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\InprocServer32" -Name 'InprocServer32' -Value @("~n(Yat}yL@T``b@3,Keq3>{5Hc1!F}]=!Ezg(LL{+1") -Type MultiString -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\InprocServer32" -Name 'ThreadingModel' -Value "Apartment" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\ProgID" -Name '(default)' -Value "MAPILab.MMTAddin.1" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\Programmable" -Name '(default)' -Value "" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\TypeLib" -Name '(default)' -Value "{9A4320B7-3A6D-43DC-B68B-223EDB05C5DD}" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}\VersionIndependentProgID" -Name '(default)' -Value "MAPILab.MMTAddin" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\MAPILab.MMTAddin" -Name '(default)' -Value "MMTAddin Class" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\MAPILab.MMTAddin\CLSID" -Name '(default)' -Value "{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\MAPILab.MMTAddin\CurVer" -Name '(default)' -Value "MAPILab.MMTAddin.1" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\MAPILab.MMTAddin.1" -Name '(default)' -Value "MMTAddin Class" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\MAPILab.MMTAddin.1\CLSID" -Name '(default)' -Value "{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender" -Name '(default)' -Value "MMTOutlookSender Class" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender\CLSID" -Name '(default)' -Value "{55664247-1A2D-418F-8988-435800054069}" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender\CurVer" -Name '(default)' -Value "MAPILab.MMTOutlookSender.1" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender.1" -Name '(default)' -Value "MMTOutlookSender Class" -Type String -Force -Confirm:$false
		Set-ItemProperty -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender.1\CLSID" -Name '(default)' -Value "{55664247-1A2D-418F-8988-435800054069}" -Type String -Force -Confirm:$false
	}
	ElseIf ($deploymentType -ieq 'Uninstall')
	{
		##*===============================================
		##* PRE-UNINSTALLATION
		##*===============================================
		[string]$installPhase = 'Pre-Uninstallation'

		## Show Welcome Message, close Internet Explorer with a 60 second countdown before automatically closing
		Show-InstallationWelcome -CloseApps 'outlook,winword,mspub,iexplore' -CloseAppsCountdown 300 -MinimizeWindows $false

		## Show Progress Message (with the default message)
		Show-InstallationProgress -WindowLocation 'BottomRight' -TopMost $false

		## <Perform Pre-Uninstallation tasks here>


		##*===============================================
		##* UNINSTALLATION
		##*===============================================
		[string]$installPhase = 'Uninstallation'

		## Handle Zero-Config MSI Uninstallations
		If ($useDefaultMsi) {
			[hashtable]$ExecuteDefaultMSISplat =  @{ Action = 'Uninstall'; Path = $defaultMsiFile }; If ($defaultMstFile) { $ExecuteDefaultMSISplat.Add('Transform', $defaultMstFile) }
			Execute-MSI @ExecuteDefaultMSISplat
		}

		# <Perform Uninstallation tasks here>
		Execute-MSI -Action Uninstall -Path '{B008D66F-B796-4C06-B707-932F0B225531}'

		##*===============================================
		##* POST-UNINSTALLATION
		##*===============================================
		[string]$installPhase = 'Post-Uninstallation'

		## <Perform Post-Uninstallation tasks here>
		# Shut down the 'Why did you uninstall?' window
		Start-Sleep -Seconds 5
		Stop-Process -Name iexplore -Force -Confirm:$false

		# Remove Registry Keys in HKCU
		$CurrentUser = (Get-CimInstance -ClassName Win32_ComputerSystem -Property Username).Username.Split('\')[-1]
		$UserProfile = Get-ChildItem -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\ProfileList' |
			ForEach-Object {
				[PSCustomObject]@{
					'SID' = $_.PSChildName
					'UserName' = (Get-ItemPropertyValue -Path $_.PSPath -Name ProfileImagePath).Split('\')[-1]
				}
			} | Where-Object { $_.UserName -eq $CurrentUser }
		$UserReg = "Registry::HKEY_USERS\$($UserProfile.SID)"
		if (Test-Path -Path "$UserReg\Software\MAPILab Ltd") {
			Remove-Item -Path "$UserReg\Software\MAPILab Ltd" -Recurse -Force -Confirm:$false
		}
		if (Test-Path -Path "$UserReg\Software\Microsoft\Office\Outlook\Addins\MAPILab.MMTOutlookSender") {
			Remove-Item -Path "$UserReg\Software\Microsoft\Office\Outlook\Addins\MAPILab.MMTOutlookSender" -Recurse -Force -Confirm:$false
		}
		if (Test-Path -Path "$UserReg\Software\Microsoft\Office\Publisher\Addins\MAPILab.MMTAddin") {
			Remove-Item -Path "$UserReg\Software\Microsoft\Office\Publisher\Addins\MAPILab.MMTAddin" -Recurse -Force -Confirm:$false
		}
		if (Test-Path -Path "$UserReg\Software\Microsoft\Office\Word\Addins\MAPILab.MMTAddin") {
			Remove-Item -Path "$UserReg\Software\Microsoft\Office\Word\Addins\MAPILab.MMTAddin" -Recurse -Force -Confirm:$false
		}
		if (Test-Path -Path "$UserReg\Software\Classes\AppID\MMTProg.DLL") {
			Remove-Item -Path "$UserReg\Software\Classes\AppID\MMTProg.DLL" -Recurse -Force -Confirm:$false
		}
		if (Test-Path -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}") {
			Remove-Item -Path "$UserReg\Software\Classes\CLSID\{55664247-1A2D-418F-8988-435800054069}" -Recurse -Force -Confirm:$false
		}
		if (Test-Path -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}") {
			Remove-Item -Path "$UserReg\Software\Classes\CLSID\{55FF2CB0-B50A-4600-861C-B9FC2F3425A8}" -Recurse -Force -Confirm:$false
		}
		if (Test-Path -Path "$UserReg\Software\Classes\MAPILab.MMTAddin") {
			Remove-Item -Path "$UserReg\Software\Classes\MAPILab.MMTAddin" -Recurse -Force -Confirm:$false
		}
		if (Test-Path -Path "$UserReg\Software\Classes\MAPILab.MMTAddin.1") {
			Remove-Item -Path "$UserReg\Software\Classes\MAPILab.MMTAddin.1" -Recurse -Force -Confirm:$false
		}
		if (Test-Path -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender") {
			Remove-Item -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender" -Recurse -Force -Confirm:$false
		}
		if (Test-Path -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender.1") {
			Remove-Item -Path "$UserReg\Software\Classes\MAPILab.MMTOutlookSender.1" -Recurse -Force -Confirm:$false
		}
	}

	##*===============================================
	##* END SCRIPT BODY
	##*===============================================

	## Call the Exit-Script function to perform final cleanup operations
	Exit-Script -ExitCode $mainExitCode
}
Catch {
	[int32]$mainExitCode = 60001
	[string]$mainErrorMessage = "$(Resolve-Error)"
	Write-Log -Message $mainErrorMessage -Severity 3 -Source $deployAppScriptFriendlyName
	Show-DialogBox -Text $mainErrorMessage -Icon 'Stop'
	Exit-Script -ExitCode $mainExitCode
}
