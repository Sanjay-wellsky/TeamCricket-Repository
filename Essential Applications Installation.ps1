
# Set the execution policy to Unrestricted
Set-ExecutionPolicy Unrestricted -Force

# Install Active Directory Domain Services
Install-WindowsFeature -Name AD-Domain-Services, DNS -IncludeManagementTools
#Install-WindowsFeature -Name RSAT-DNS-Server                    
           

# Import ADDSDeployment module
Import-Module ADDSDeployment


# Check Google Chrome is already installed, verify the version, and updates/installs if required
Write-Host "Checking Google Chrome installation..."
try {
    # Check the version of Google Chrome installed by querying the registry
    $chromeVersion = Get-ItemPropertyValue "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome" -Name "DisplayVersion"
    
    if ($chromeVersion) {
        Write-Host "Google Chrome is installed, version: $chromeVersion"
        
        # Download the latest Chrome installer to check for updates
        $latestChromeInstaller = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
        Invoke-WebRequest -Uri $latestChromeInstaller -OutFile "$env:temp\chrome_installer.exe"
        
        # Get the version of the downloaded installer
        $latestVersion = (Get-Item "$env:temp\chrome_installer.exe").VersionInfo.ProductVersion
        
        # Compare the installed version with the latest version
        if ($chromeVersion -eq $latestVersion) {
            Write-Host "Google Chrome is already up-to-date."
        } else {
            Write-Host "Updating Google Chrome to the latest version..."
            Start-Process -FilePath "$env:temp\chrome_installer.exe" -ArgumentList "/silent", "/install" -NoNewWindow -Wait
            Remove-Item "$env:temp\chrome_installer.exe"  # Cleanup the installer
        }
    } else {
        # If Chrome is not installed, proceed with the installation
        Write-Host "Google Chrome not found. Installing the latest version..."
        $chromeInstaller = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
        Invoke-WebRequest -Uri $chromeInstaller -OutFile "$env:temp\chrome_installer.exe"
        Start-Process -FilePath "$env:temp\chrome_installer.exe" -ArgumentList "/silent", "/install" -NoNewWindow -Wait
        Remove-Item "$env:temp\chrome_installer.exe"  # Cleanup the installer file
    }
} catch {
    # Handle any errors during the Chrome check or installation
    Handle-Error "Failed to install or update Google Chrome. $_"
}

# Check and install PuTTY and proceeds with installation if it is not found
Write-Host "Checking PuTTY installation..."
try {
    # Define the installer URL and the expected installation path for PuTTY
    $puttyInstaller = "https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-installer.msi"
    $puttyPath = "C:\Program Files\PuTTY\putty.exe"
    
    if (Test-Path $puttyPath) {
        Write-Host "PuTTY is installed at $puttyPath."
        # (Optional) Logic to check the version and update can be added here
    } else {
        # If PuTTY is not installed, proceed with the installation
        Write-Host "PuTTY is not installed. Installing..."
        Invoke-WebRequest -Uri $puttyInstaller -OutFile "$env:temp\putty_installer.msi"
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", "$env:temp\putty_installer.msi", "/quiet", "/norestart" -NoNewWindow -Wait
        Remove-Item "$env:temp\putty_installer.msi"  # Cleanup the installer
    }
} catch {
    # Handle any errors during PuTTY installation
    Handle-Error "Failed to install PuTTY. $_"
}

# Final message indicating that all tasks have completed
Write-Host "All installations and checks are complete!"
