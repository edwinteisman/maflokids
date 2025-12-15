# Quick WordPress Management Scripts

# Quick Update Script
Write-Host "🔄 Quick WordPress Update Script" -ForegroundColor Green
Write-Host "This script updates content and configuration without reinstalling WordPress" -ForegroundColor Yellow

$ProjectRoot = Split-Path -Parent $PSScriptRoot
& (Join-Path $ProjectRoot "scripts\deploy-wordpress.ps1") -UpdateOnly
