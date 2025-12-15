# Fresh WordPress Installation Script

Write-Host "🆕 Fresh WordPress Installation" -ForegroundColor Green
Write-Host "This script does a complete clean installation of WordPress" -ForegroundColor Yellow

$ProjectRoot = Split-Path -Parent $PSScriptRoot

Write-Host "⚠️  WARNING: This will delete your existing WordPress installation!" -ForegroundColor Red
$confirm = Read-Host "Are you sure you want to continue? (y/N)"

if ($confirm -eq 'y' -or $confirm -eq 'Y') {
    & (Join-Path $ProjectRoot "scripts\deploy-wordpress.ps1") -Clean
} else {
    Write-Host "❌ Installation cancelled" -ForegroundColor Yellow
}
