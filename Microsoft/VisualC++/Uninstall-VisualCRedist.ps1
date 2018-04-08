$2008Uninst = '/qu'
$2010Uninst = @(
    '/q'
    '/uninstall'
    '/norestart'
)
$2017Uninst = @(
    '/uninstall'
    '/quiet'
    '/norestart'
)

# Install 2008x64
Start-Process -FilePath "$PSScriptRoot\Files\2008\vcredist_x64.exe" -ArgumentList $2008Uninst -Wait -PassThru

# Install 2008x86
Start-Process -FilePath "$PSScriptRoot\Files\2008\vcredist_x86.exe" -ArgumentList $2008Uninst -Wait -PassThru

# Install 2010x64
Start-Process -FilePath "$PSScriptRoot\Files\2010\vcredist_x64.exe" -ArgumentList $2010Uninst -Wait -PassThru

# Install 2010x86
Start-Process -FilePath "$PSScriptRoot\Files\2010\vcredist_x86.exe" -ArgumentList $2010Uninst -Wait -PassThru

# Install 2012x64
Start-Process -FilePath "$PSScriptRoot\Files\2012\vcredist_x64.exe" -ArgumentList $2017Uninst -Wait -PassThru

# Install 2012x86
Start-Process -FilePath "$PSScriptRoot\Files\2012\vcredist_x86.exe" -ArgumentList $2017Uninst -Wait -PassThru

# Install 2013x64
Start-Process -FilePath "$PSScriptRoot\Files\2013\vcredist_x64.exe" -ArgumentList $2017Uninst -Wait -PassThru

# Install 2013x86
Start-Process -FilePath "$PSScriptRoot\Files\2013\vcredist_x86.exe" -ArgumentList $2017Uninst -Wait -PassThru

# Install 2017x64
Start-Process -FilePath "$PSScriptRoot\Files\2017\vc_redist.x64.exe" -ArgumentList $2017Uninst -Wait -PassThru

# Install 2017x86
Start-Process -FilePath "$PSScriptRoot\Files\2017\vc_redist.x86.exe" -ArgumentList $2017Uninst -Wait -PassThru

Start-Sleep -Seconds 3