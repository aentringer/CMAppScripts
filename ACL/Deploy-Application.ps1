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
	[string]$appVendor = 'ACL Services'
	[string]$appName = 'ACL for Windows'
	[string]$appVersion = '12.5.1.534'
	[string]$appArch = ''
	[string]$appLang = 'EN'
	[string]$appRevision = '01'
	[string]$appScriptVersion = '1.0.0'
	[string]$appScriptDate = '06/21/2017'
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

		## Show Welcome Message, close Internet Explorer if required, allow up to 3 deferrals, verify there is enough disk space to complete the install, and persist the prompt
		Show-InstallationWelcome -CloseApps 'ACLWin,ACLLauncher' -CloseAppsCountdown 900 -MinimizeWindows $false

		## Show Progress Message (with the default message)
		Show-InstallationProgress -WindowLocation 'BottomRight' -TopMost $false

		## <Perform Pre-Installation tasks here>
        # Access Database Engine 2010 32-bit
        Execute-MSI -Action Install -Path "$dirFiles\PRE\AceRedist.msi" -Parameters 'REBOOT=ReallySuppress /qn'
        # 2012 Visual C++ 64-bit
        Execute-Process -Path "$dirFiles\PRE\2012vcredist_x64.exe" -Parameters '/install /quiet /norestart'
        # 2013 Visual C++ 32-bit
        Execute-Process -Path "$dirFiles\PRE\2013vcredist_x64.exe" -Parameters '/install /quiet /norestart'
        # 2017 Visual C++ 64bit
        if ((Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64\' -Name 'Installed').Installed) {
            $2017x64 = [version](Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64\' -Name 'Version').Version.TrimStart('v')
            if ($2017x64 -lt [version]'14.14.26429.4') {
                Execute-Process -Path "$dirFiles\PRE\2017vc_redist.x64.exe" -Parameters '/uninstall /quiet /norestart'
                Execute-Process -Path "$dirFiles\PRE\2017vc_redist.x64.exe" -Parameters '/install /quiet /norestart'
            }
        }
        else {
            Execute-Process -Path "$dirFiles\PRE\2017vc_redist.x64.exe" -Parameters '/install /quiet /norestart'
        }
        # 2017 Visual C++ 32bit
        if ((Get-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\VisualStudio\14.0\VC\Runtimes\x86\' -Name 'Installed').Installed) {
            $2017x86 = [version](Get-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\VisualStudio\14.0\VC\Runtimes\x86\' -Name 'Version').Version.TrimStart('v')
            if ($2017x86 -lt [version]'14.14.26429.4') {
                Execute-Process -Path "$dirFiles\PRE\2017vc_redist.x86.exe" -Parameters '/uninstall /quiet /norestart'
                Execute-Process -Path "$dirFiles\PRE\2017vc_redist.x86.exe" -Parameters '/install /quiet /norestart'
            }
        }
        else {
            Execute-Process -Path "$dirFiles\PRE\2017vc_redist.x86.exe" -Parameters '/install /quiet /norestart'
        }
        # OpenXML SDK v2.5
        Execute-MSI -Action Install -Path "$dirFiles\PRE\OpenXMLSDKv25.msi" -Parameters 'REBOOT=ReallySuppress /qn'

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
		Execute-MSI -Action Install -Path "$dirFiles\ACL for Windows.msi" -Parameters 'REBOOT=ReallySuppress /qn'

		##*===============================================
		##* POST-INSTALLATION
		##*===============================================
		[string]$installPhase = 'Post-Installation'

		## <Perform Post-Installation tasks here>
        Remove-Item -Path "$env:PUBLIC\Desktop\ACL for Windows 12.lnk" -Force -Confirm:$false
	}
	ElseIf ($deploymentType -ieq 'Uninstall')
	{
		##*===============================================
		##* PRE-UNINSTALLATION
		##*===============================================
		[string]$installPhase = 'Pre-Uninstallation'

		## Show Welcome Message, close Internet Explorer with a 60 second countdown before automatically closing
		Show-InstallationWelcome -CloseApps 'ACLLauncher' -CloseAppsCountdown 300 -MinimizeWindows $false

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
        # Uninstall ACL 12.5.1.534
        Execute-MSI -Action Uninstall -Path '{FE4E1EC7-570F-489C-A667-55AB521A87E7}'
        # Uninstall OpenXML SDK v2.5
        Execute-MSI -Action Uninstall -Path '{3EA16E23-14D2-466A-8268-D7CD40DC46B6}'
        # Uninstall Access Database Engine 2010 32-bit
        Execute-MSI -Action Uninstall -Path '{90140000-00D1-0409-0000-0000000FF1CE}'


		##*===============================================
		##* POST-UNINSTALLATION
		##*===============================================
		[string]$installPhase = 'Post-Uninstallation'

		## <Perform Post-Uninstallation tasks here>

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