# WordPress Site Backup Script

param(
    [string]$BackupDir = "backups"
)

$ProjectRoot = Split-Path -Parent $PSScriptRoot
$WebsiteDir = Join-Path $ProjectRoot "website"
$BackupPath = Join-Path $ProjectRoot $BackupDir

Write-Host "💾 Creating WordPress Backup..." -ForegroundColor Green

# Create backup directory
if (!(Test-Path $BackupPath)) {
    New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null
}

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$backupName = "wordpress-backup-$timestamp"
$backupFullPath = Join-Path $BackupPath $backupName

# Create backup directory for this backup
New-Item -ItemType Directory -Path $backupFullPath -Force | Out-Null

if (Test-Path $WebsiteDir) {
    Set-Location $WebsiteDir

    # Backup database
    Write-Host "🗄️ Backing up database..." -ForegroundColor Yellow
    $DbPasswordFile = Join-Path $ProjectRoot "mariadb-pw.txt"
    if (Test-Path $DbPasswordFile) {
        $DbPassword = Get-Content $DbPasswordFile -Raw | ForEach-Object { $_.Trim() }
        $DbName = "maflokids"
        $DbUser = "root"
        $DbHost = "localhost"

        $dbBackupFile = Join-Path $backupFullPath "database.sql"
        $mysqldumpCmd = "mysqldump -u$DbUser -p$DbPassword -h$DbHost $DbName"

        try {
            Invoke-Expression "$mysqldumpCmd > `"$dbBackupFile`""
            Write-Host "✅ Database backed up to: database.sql" -ForegroundColor Green
        } catch {
            Write-Warning "Could not backup database: $($_.Exception.Message)"
        }
    }

    # Backup WordPress files
    Write-Host "📁 Backing up WordPress files..." -ForegroundColor Yellow
    $filesBackupPath = Join-Path $backupFullPath "wordpress-files"
    Copy-Item -Path $WebsiteDir -Destination $filesBackupPath -Recurse -Force
    Write-Host "✅ WordPress files backed up" -ForegroundColor Green

    # Create backup info file
    $backupInfo = @"
WordPress Backup Information
===========================
Backup Date: $(Get-Date)
Backup Location: $backupFullPath
WordPress Path: $WebsiteDir
Database: maflokids
"@

    $backupInfo | Out-File (Join-Path $backupFullPath "backup-info.txt")

    Write-Host ""
    Write-Host "🎉 Backup completed successfully!" -ForegroundColor Green
    Write-Host "📍 Backup location: $backupFullPath" -ForegroundColor Cyan

} else {
    Write-Host "❌ WordPress installation not found at: $WebsiteDir" -ForegroundColor Red
}

# Return to project root
Set-Location $ProjectRoot
