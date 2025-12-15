# Test WordPress Deployment System

Write-Host "🧪 Testing WordPress Deployment System" -ForegroundColor Green

$ProjectRoot = Split-Path -Parent $PSScriptRoot

# Test 1: Check if all required files exist
Write-Host "`n📁 Checking project structure..." -ForegroundColor Yellow

$requiredFiles = @(
    "scripts\deploy-wordpress.ps1",
    "scripts\quick-update.ps1",
    "scripts\fresh-install.ps1",
    "scripts\backup-wordpress.ps1",
    "config\apply-config.ps1",
    "content\setup-content.ps1",
    "wordpress-source\themes\maflokids-theme\style.css",
    "wordpress-source\themes\maflokids-theme\functions.php"
)

$allFilesExist = $true
foreach ($file in $requiredFiles) {
    $fullPath = Join-Path $ProjectRoot $file
    if (Test-Path $fullPath) {
        Write-Host "✅ $file" -ForegroundColor Green
    } else {
        Write-Host "❌ $file" -ForegroundColor Red
        $allFilesExist = $false
    }
}

# Test 2: Check prerequisites
Write-Host "`n🔧 Checking prerequisites..." -ForegroundColor Yellow

# Check PHP
try {
    $phpVersion = php -v 2>$null
    if ($phpVersion) {
        Write-Host "✅ PHP is installed" -ForegroundColor Green
    } else {
        Write-Host "❌ PHP not found" -ForegroundColor Red
    }
} catch {
    Write-Host "❌ PHP not available" -ForegroundColor Red
}

# Check MySQL/MariaDB
try {
    $mysqlVersion = mysql --version 2>$null
    if ($mysqlVersion) {
        Write-Host "✅ MySQL/MariaDB is available" -ForegroundColor Green
    } else {
        Write-Host "⚠️ MySQL/MariaDB not found in PATH" -ForegroundColor Yellow
    }
} catch {
    Write-Host "⚠️ MySQL/MariaDB not available via command line" -ForegroundColor Yellow
}

# Check database password file
$DbPasswordFile = Join-Path $ProjectRoot "mariadb-pw.txt"
if (Test-Path $DbPasswordFile) {
    Write-Host "✅ Database password file exists" -ForegroundColor Green
} else {
    Write-Host "❌ Database password file missing" -ForegroundColor Red
}

# Test 3: Validate scripts syntax
Write-Host "`n📝 Validating script syntax..." -ForegroundColor Yellow

$scriptFiles = @(
    "scripts\deploy-wordpress.ps1",
    "scripts\quick-update.ps1",
    "scripts\fresh-install.ps1",
    "scripts\backup-wordpress.ps1",
    "config\apply-config.ps1",
    "content\setup-content.ps1"
)

$allScriptsValid = $true
foreach ($script in $scriptFiles) {
    $scriptPath = Join-Path $ProjectRoot $script
    if (Test-Path $scriptPath) {
        try {
            $null = Get-Command $scriptPath -ErrorAction Stop
            Write-Host "✅ $script syntax OK" -ForegroundColor Green
        } catch {
            Write-Host "❌ $script has syntax errors" -ForegroundColor Red
            $allScriptsValid = $false
        }
    }
}

# Test 4: Check theme structure
Write-Host "`n🎨 Checking theme structure..." -ForegroundColor Yellow

$themeFiles = @(
    "wordpress-source\themes\maflokids-theme\style.css",
    "wordpress-source\themes\maflokids-theme\functions.php",
    "wordpress-source\themes\maflokids-theme\header.php",
    "wordpress-source\themes\maflokids-theme\footer.php",
    "wordpress-source\themes\maflokids-theme\page.php",
    "wordpress-source\themes\maflokids-theme\index.php"
)

$allThemeFilesExist = $true
foreach ($file in $themeFiles) {
    $fullPath = Join-Path $ProjectRoot $file
    if (Test-Path $fullPath) {
        Write-Host "✅ $($file.Split('\')[-1])" -ForegroundColor Green
    } else {
        Write-Host "❌ $($file.Split('\')[-1])" -ForegroundColor Red
        $allThemeFilesExist = $false
    }
}

# Summary
Write-Host "`n📊 Test Summary:" -ForegroundColor Cyan
Write-Host "=================" -ForegroundColor Cyan

if ($allFilesExist -and $allScriptsValid -and $allThemeFilesExist) {
    Write-Host "🎉 All tests passed! Your WordPress deployment system is ready." -ForegroundColor Green
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Yellow
    Write-Host "1. Ensure PHP and MySQL/MariaDB are running" -ForegroundColor White
    Write-Host "2. Run: .\scripts\deploy-wordpress.ps1" -ForegroundColor White
    Write-Host "3. Visit: http://maflokids.local/" -ForegroundColor White
} else {
    Write-Host "⚠️ Some tests failed. Please fix the issues above before deploying." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "📖 For detailed instructions, see: WORDPRESS-AUTOMATION.md" -ForegroundColor Cyan
