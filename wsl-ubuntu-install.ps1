
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Run as Administrator" -ForegroundColor Red
    exit 1
}

Write-Host "WSL Ubuntu Installation Script" -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This script will:" -ForegroundColor Yellow
Write-Host "- Enable WSL and Virtual Machine Platform features"
Write-Host "- Install Ubuntu Linux distribution"
Write-Host "- RESTART your computer automatically"
Write-Host ""
Write-Host "After restart, you'll need to launch Ubuntu and complete initial setup."
Write-Host ""

$confirmation = Read-Host "Do you want to proceed? (y/N)"
if ($confirmation -ne 'y' -and $confirmation -ne 'Y') {
    Write-Host "Installation cancelled." -ForegroundColor Red
    exit 0
}

$osInfo = Get-WmiObject -Class Win32_OperatingSystem
Write-Host "OS: $($osInfo.Caption)"

switch -Wildcard ($osInfo.Caption) {
    "*Windows 10*" {
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
        Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
    }
    "*Windows 11*" {
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
        Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
    }
    default {
        Write-Host "Unsupported OS" -ForegroundColor Red
        exit 1
    }
}

wsl --update

$existingDistros = wsl --list --quiet
if ($existingDistros -match "Ubuntu") {
    Write-Host "Ubuntu already installed. Skipping installation." -ForegroundColor Green
} else {
    Write-Host "Installing Ubuntu..." -ForegroundColor Green
    wsl --install -d Ubuntu
}

wsl --set-default-version 2

Write-Host "Restart required to complete WSL installation." -ForegroundColor Yellow
Write-Host ""
Write-Host "AFTER RESTART:" -ForegroundColor Cyan
Write-Host "1. Search 'Ubuntu' in Start menu and launch"
Write-Host "2. Complete initial setup (username/password)"
Write-Host "3. Installation will be complete"
Write-Host ""
Write-Host "OPTIONS:" -ForegroundColor Cyan
Write-Host "- Wait 10 seconds for automatic restart"
Write-Host "- Press Ctrl+C to cancel and restart manually later"
Write-Host ""
Write-Host "Auto-restart in:" -ForegroundColor Yellow

for ($i = 10; $i -gt 0; $i--) {
    Write-Host "$i..." -NoNewline -ForegroundColor Yellow
    Start-Sleep -Seconds 1
}

Write-Host ""
Restart-Computer -Force