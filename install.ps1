# YoloPilot Installer for Windows PowerShell
# Run: iwr -useb https://raw.githubusercontent.com/Lukasedv/yolopilot/main/install.ps1 | iex

Write-Host "🚀 Installing YoloPilot..." -ForegroundColor Cyan

# Pull the latest image
Write-Host "📦 Pulling container image..." -ForegroundColor Yellow
docker pull ghcr.io/lukasedv/yolopilot:latest

# Create install directory
$InstallDir = "$env:USERPROFILE\.yolopilot\bin"
if (-not (Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
}

# Create the batch file
$BatchContent = @'
@echo off
docker run -it --rm --cap-add=NET_ADMIN --cap-add=NET_RAW -v "%cd%:/workspace" -w /workspace ghcr.io/lukasedv/yolopilot:latest sh -c "sudo /usr/local/bin/init-firewall.sh && copilot --yolo"
'@
Set-Content -Path "$InstallDir\yolopilot.cmd" -Value $BatchContent

# Create PowerShell function
$PwshContent = @'
function yolopilot {
    docker run -it --rm --cap-add=NET_ADMIN --cap-add=NET_RAW -v "${PWD}:/workspace" -w /workspace ghcr.io/lukasedv/yolopilot:latest sh -c "sudo /usr/local/bin/init-firewall.sh && copilot --yolo"
}
'@
Set-Content -Path "$InstallDir\yolopilot.ps1" -Value $PwshContent

# Add to PATH if not already there
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($UserPath -notlike "*$InstallDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$UserPath;$InstallDir", "User")
    $env:Path = "$env:Path;$InstallDir"
    Write-Host "✅ Added to PATH. Restart your terminal for changes to take effect." -ForegroundColor Green
}

# Add to PowerShell profile for function
$ProfileDir = Split-Path $PROFILE
if (-not (Test-Path $ProfileDir)) {
    New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null
}
if (-not (Test-Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}

$ProfileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
if ($ProfileContent -notlike "*yolopilot.ps1*") {
    Add-Content -Path $PROFILE -Value "`n. `"$InstallDir\yolopilot.ps1`""
}

Write-Host ""
Write-Host "✅ YoloPilot installed!" -ForegroundColor Green
Write-Host "   Restart your terminal, then run 'yolopilot' in any directory." -ForegroundColor White
