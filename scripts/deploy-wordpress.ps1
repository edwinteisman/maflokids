# Ma Flo Kids WordPress Deployment Script
# This script sets up/updates the WordPress installation for maflokids.local

param(
    [switch]$Clean,           # Clean install (removes existing WordPress)
    [switch]$UpdateOnly,      # Only update content and theme, don't reinstall WordPress
    [switch]$SkipDownload     # Skip WordPress download (use existing)
)

# Configuration
$SiteName = "Ma Flo Kids"
$SiteURL = "http://maflokids.local"
$AdminUser = "admin"
$AdminEmail = "admin@maflokids.local"

# Paths
$ProjectRoot = Split-Path -Parent $PSScriptRoot
$WebsiteDir = Join-Path $ProjectRoot "website"
$ConfigDir = Join-Path $ProjectRoot "config"
$ContentDir = Join-Path $ProjectRoot "content"
$SourceDir = Join-Path $ProjectRoot "wordpress-source"

# Database configuration (read from mariadb-pw.txt)
$DbPasswordFile = Join-Path $ProjectRoot "mariadb-pw.txt"
if (Test-Path $DbPasswordFile) {
    $DbPassword = Get-Content $DbPasswordFile -Raw
    $DbPassword = $DbPassword.Trim()
} else {
    Write-Error "Database password file not found: $DbPasswordFile"
    exit 1
}

$DbName = "maflokids"
$DbUser = "root"
$DbHost = "localhost"

Write-Host "🚀 Ma Flo Kids WordPress Deployment Starting..." -ForegroundColor Green
Write-Host "Site URL: $SiteURL" -ForegroundColor Cyan
Write-Host "Target Directory: $WebsiteDir" -ForegroundColor Cyan

# Function to check if WP-CLI is installed
function Test-WPCLI {
    try {
        $null = wp --info 2>$null
        return $true
    } catch {
        return $false
    }
}

# Function to install WP-CLI if needed
function Install-WPCLI {
    Write-Host "📦 Installing WP-CLI..." -ForegroundColor Yellow

    # Download WP-CLI
    $wpCliPath = Join-Path $env:USERPROFILE "wp-cli.phar"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/wp-cli/wp-cli/v2.8.1/utils/wp-cli.phar" -OutFile $wpCliPath

    # Create wp.bat wrapper
    $wpBatContent = "@echo off`nphp `"$wpCliPath`" %*"
    $wpBatPath = Join-Path $env:USERPROFILE "wp.bat"
    $wpBatContent | Out-File -FilePath $wpBatPath -Encoding ASCII

    # Add to PATH if not already there
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $userProfileDir = $env:USERPROFILE
    if ($userPath -notlike "*$userProfileDir*") {
        [Environment]::SetEnvironmentVariable("Path", $userPath + ";$userProfileDir", "User")
        $env:Path += ";$userProfileDir"
    }

    Write-Host "✅ WP-CLI installed successfully" -ForegroundColor Green
}

# Function to setup database
function Setup-Database {
    Write-Host "🗄️ Setting up database..." -ForegroundColor Yellow

    # Connect to MariaDB and create database if it doesn't exist
    $mysqlCmd = "mysql -u$DbUser -p$DbPassword -h$DbHost -e `"CREATE DATABASE IF NOT EXISTS $DbName CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`""

    try {
        Invoke-Expression $mysqlCmd
        Write-Host "✅ Database '$DbName' ready" -ForegroundColor Green
    } catch {
        Write-Warning "Could not setup database automatically. Please ensure MariaDB is running and create database '$DbName' manually."
    }
}

# Function to download and setup WordPress
function Setup-WordPress {
    Write-Host "📥 Setting up WordPress..." -ForegroundColor Yellow

    # Clean installation if requested
    if ($Clean -and (Test-Path $WebsiteDir)) {
        Write-Host "🧹 Cleaning existing installation..." -ForegroundColor Yellow
        Remove-Item -Path $WebsiteDir -Recurse -Force
    }

    # Create website directory
    if (!(Test-Path $WebsiteDir)) {
        New-Item -ItemType Directory -Path $WebsiteDir -Force | Out-Null
    }

    Set-Location $WebsiteDir

    # Download WordPress if not updating only
    if (!$UpdateOnly -and !$SkipDownload) {
        Write-Host "📦 Downloading WordPress..." -ForegroundColor Yellow
        wp core download --force
    }

    # Create wp-config.php
    if (!(Test-Path "wp-config.php") -or !$UpdateOnly) {
        Write-Host "⚙️ Configuring WordPress..." -ForegroundColor Yellow
        wp config create --dbname=$DbName --dbuser=$DbUser --dbpass=$DbPassword --dbhost=$DbHost --force
    }

    # Install WordPress if not already installed
    $isInstalled = wp core is-installed 2>$null
    if (!$isInstalled -and !$UpdateOnly) {
        Write-Host "🔧 Installing WordPress..." -ForegroundColor Yellow
        $adminPassword = -join ((65..90) + (97..122) | Get-Random -Count 12 | ForEach-Object {[char]$_})
        wp core install --url=$SiteURL --title="$SiteName" --admin_user=$AdminUser --admin_password=$adminPassword --admin_email=$AdminEmail

        # Save admin password
        $passwordFile = Join-Path $ProjectRoot "wp-admin-password.txt"
        "WordPress Admin Credentials`nUsername: $AdminUser`nPassword: $adminPassword`nEmail: $AdminEmail" | Out-File $passwordFile
        Write-Host "✅ Admin password saved to wp-admin-password.txt" -ForegroundColor Green
    }

    Write-Host "✅ WordPress core ready" -ForegroundColor Green
}

# Function to install theme and plugins
function Install-ThemeAndPlugins {
    Write-Host "🎨 Installing themes and plugins..." -ForegroundColor Yellow

    Set-Location $WebsiteDir

    # Install themes from wordpress-source/themes
    $themeSourceDir = Join-Path $SourceDir "themes"
    if (Test-Path $themeSourceDir) {
        Get-ChildItem $themeSourceDir -Directory | ForEach-Object {
            $themeName = $_.Name
            $themeTarget = Join-Path $WebsiteDir "wp-content\themes\$themeName"

            Write-Host "📁 Installing theme: $themeName" -ForegroundColor Cyan
            if (Test-Path $themeTarget) {
                Remove-Item $themeTarget -Recurse -Force
            }
            Copy-Item $_.FullName $themeTarget -Recurse
        }
    }

    # Install plugins from wordpress-source/plugins
    $pluginSourceDir = Join-Path $SourceDir "plugins"
    if (Test-Path $pluginSourceDir) {
        Get-ChildItem $pluginSourceDir -Directory | ForEach-Object {
            $pluginName = $_.Name
            $pluginTarget = Join-Path $WebsiteDir "wp-content\plugins\$pluginName"

            Write-Host "🔌 Installing plugin: $pluginName" -ForegroundColor Cyan
            if (Test-Path $pluginTarget) {
                Remove-Item $pluginTarget -Recurse -Force
            }
            Copy-Item $_.FullName $pluginTarget -Recurse
        }
    }

    # Install essential plugins via WP-CLI
    Write-Host "📦 Installing essential plugins..." -ForegroundColor Cyan

    $essentialPlugins = @(
        "contact-form-7",
        "yoast-seo",
        "wordfence",
        "updraftplus"
    )

    foreach ($plugin in $essentialPlugins) {
        $isInstalled = wp plugin is-installed $plugin 2>$null
        if (!$isInstalled) {
            Write-Host "📦 Installing plugin: $plugin" -ForegroundColor Cyan
            wp plugin install $plugin --activate
        } else {
            Write-Host "✅ Plugin already installed: $plugin" -ForegroundColor Green
        }
    }

    Write-Host "✅ Themes and plugins ready" -ForegroundColor Green
}

# Function to import content
function Import-Content {
    Write-Host "📝 Importing content..." -ForegroundColor Yellow

    Set-Location $WebsiteDir

    # Import content from content directory
    $contentFiles = Get-ChildItem $ContentDir -Filter "*.xml" -ErrorAction SilentlyContinue

    foreach ($file in $contentFiles) {
        Write-Host "📄 Importing: $($file.Name)" -ForegroundColor Cyan
        wp import $file.FullName --authors=create
    }

    # Run any custom content setup scripts
    $contentScript = Join-Path $ContentDir "setup-content.ps1"
    if (Test-Path $contentScript) {
        Write-Host "🔧 Running content setup script..." -ForegroundColor Cyan
        & $contentScript
    }

    Write-Host "✅ Content imported" -ForegroundColor Green
}

# Function to apply configuration
function Apply-Configuration {
    Write-Host "⚙️ Applying configuration..." -ForegroundColor Yellow

    Set-Location $WebsiteDir

    # Apply settings from config files
    $configScript = Join-Path $ConfigDir "apply-config.ps1"
    if (Test-Path $configScript) {
        Write-Host "🔧 Running configuration script..." -ForegroundColor Cyan
        & $configScript
    }

    # Update WordPress URLs
    wp option update home $SiteURL
    wp option update siteurl $SiteURL

    # Set permalink structure
    wp rewrite structure '/%postname%/'
    wp rewrite flush

    Write-Host "✅ Configuration applied" -ForegroundColor Green
}

# Main execution
try {
    # Check prerequisites
    Write-Host "🔍 Checking prerequisites..." -ForegroundColor Yellow

    if (!(Test-WPCLI)) {
        Install-WPCLI
    } else {
        Write-Host "✅ WP-CLI is available" -ForegroundColor Green
    }

    # Check PHP
    try {
        $phpVersion = php -v 2>$null
        Write-Host "✅ PHP is available" -ForegroundColor Green
    } catch {
        Write-Error "PHP is not installed or not in PATH. Please install PHP first."
        exit 1
    }

    # Setup database
    Setup-Database

    # Setup WordPress
    Setup-WordPress

    # Install themes and plugins
    Install-ThemeAndPlugins

    # Import content
    Import-Content

    # Apply configuration
    Apply-Configuration

    Write-Host ""
    Write-Host "🎉 Deployment completed successfully!" -ForegroundColor Green
    Write-Host "📍 Website URL: $SiteURL" -ForegroundColor Cyan
    Write-Host "🔐 Admin URL: $SiteURL/wp-admin" -ForegroundColor Cyan
    Write-Host "👤 Admin credentials are saved in wp-admin-password.txt" -ForegroundColor Cyan

} catch {
    Write-Host "❌ Deployment failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
} finally {
    # Return to project root
    Set-Location $ProjectRoot
}
