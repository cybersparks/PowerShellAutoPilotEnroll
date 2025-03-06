# Set the execution policy to Unrestricted for this session (Process scope)
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted

# Prompt to run the script as Administrator
Write-Host "Run in PowerShell as ADMIN"
Read-Host "This script will now run, press ENTER to continue"

# Create a directory if it doesn't exist and navigate to it
$dirPath = "C:\HWID"
if (-not (Test-Path -Path $dirPath)) {
    New-Item -Type Directory -Path $dirPath
}
Set-Location -Path $dirPath

# Ensure PSGallery repository is trusted and add it if not
if (-not (Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue)) {
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}

# Install the script if it's not already installed
Install-Script -Name Get-WindowsAutoPilotInfo -Force -Confirm

# Run the script to gather hardware info and export to a CSV file
Get-WindowsAutoPilotInfo.ps1 -OutputFile AutoPilotHWID.csv

# Revert the execution policy to the default setting (Restricted for non-administrators)
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Default

# Prompt when the script is complete
Read-Host "Script is COMPLETE, check the C:\HWID for the file. Press Enter to close."

