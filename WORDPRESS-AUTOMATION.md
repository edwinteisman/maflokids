# WordPress Automation Setup

## Overview
This repository contains a complete script-based WordPress deployment system for the Ma Flo Kids website. The system allows you to generate, refresh, and update your WordPress installation using PowerShell scripts.

## 🚀 Quick Start

### Prerequisites
1. **PHP** - Required for WordPress and WP-CLI
2. **MariaDB/MySQL** - Database server
3. **PowerShell** - For running deployment scripts

### First Time Setup
1. Ensure your database credentials are in `mariadb-pw.txt`
2. Run the deployment script:
   ```powershell
   .\scripts\deploy-wordpress.ps1
   ```

## 📁 Project Structure

```
c:\git\maflokids\
├── 📁 scripts/                     # Deployment and management scripts
│   ├── deploy-wordpress.ps1        # Main deployment script
│   ├── quick-update.ps1            # Update content only
│   ├── fresh-install.ps1           # Clean installation
│   └── backup-wordpress.ps1        # Backup WordPress
├── 📁 config/                      # WordPress configuration
│   └── apply-config.ps1            # Site configuration script
├── 📁 content/                     # Website content
│   └── setup-content.ps1          # Default content setup
├── 📁 wordpress-source/            # Version-controlled WordPress assets
│   ├── 📁 themes/maflokids-theme/  # Custom theme
│   └── 📁 plugins/                 # Custom plugins
├── 📁 website/                     # Live WordPress installation
└── 📁 docs/                       # Project documentation
```

## 🛠️ Available Scripts

### Main Deployment Script
```powershell
# Full deployment (fresh install)
.\scripts\deploy-wordpress.ps1

# Update content and theme only
.\scripts\deploy-wordpress.ps1 -UpdateOnly

# Clean install (removes existing)
.\scripts\deploy-wordpress.ps1 -Clean

# Skip WordPress download
.\scripts\deploy-wordpress.ps1 -SkipDownload
```

### Helper Scripts
```powershell
# Quick content update
.\scripts\quick-update.ps1

# Fresh installation with confirmation
.\scripts\fresh-install.ps1

# Create backup
.\scripts\backup-wordpress.ps1
```

## 🔄 Workflow

### Making Changes to Your Site

1. **Update Content**: Edit files in `/content/setup-content.ps1`
2. **Update Configuration**: Edit `/config/apply-config.ps1`
3. **Update Theme**: Edit files in `/wordpress-source/themes/maflokids-theme/`
4. **Deploy Changes**: Run `.\scripts\quick-update.ps1`

### Version Control

All changes are tracked in Git:
- ✅ Custom theme files
- ✅ Configuration scripts
- ✅ Content scripts
- ✅ Deployment scripts
- ❌ WordPress core files (excluded via .gitignore)
- ❌ Generated WordPress installation

## 🎨 Theme Development

The custom theme is located in `/wordpress-source/themes/maflokids-theme/`:

- `style.css` - Main stylesheet
- `functions.php` - Theme functionality
- `header.php` - Site header
- `footer.php` - Site footer
- `page.php` - General page template
- `page-home.php` - Homepage template
- `page-contact.php` - Contact page template
- `index.php` - Default template
- `js/main.js` - JavaScript functionality

## 📝 Content Management

Edit content in `/content/setup-content.ps1` to modify:
- Page content
- Menu structure
- Default settings

## ⚙️ Configuration

WordPress settings are managed in `/config/apply-config.ps1`:
- Site settings
- Plugin configurations
- Menu assignments
- Theme activation

## 🗄️ Database

- **Database Name**: maflokids
- **Credentials**: Stored in `mariadb-pw.txt`
- **Auto-creation**: Scripts will create the database if it doesn't exist

## 🔒 Security

- Admin credentials are auto-generated and saved to `wp-admin-password.txt`
- Database passwords are kept in separate file (not in scripts)
- Essential security plugins are installed automatically

## 🐛 Troubleshooting

### Common Issues

1. **WP-CLI not found**: The script will automatically install WP-CLI
2. **PHP not found**: Install PHP and add to PATH
3. **Database connection**: Check MariaDB is running and credentials are correct
4. **Permission errors**: Run PowerShell as Administrator

### Manual Fixes

If automation fails, you can manually:
1. Download WordPress: `wp core download`
2. Create config: `wp config create --dbname=maflokids --dbuser=root --dbpass=your_password`
3. Install WordPress: `wp core install --url=http://maflokids.local --title="Ma Flo Kids"`

## 📋 Maintenance

### Regular Tasks
- **Backups**: Run `.\scripts\backup-wordpress.ps1` regularly
- **Updates**: WordPress core updates are handled automatically
- **Plugin Updates**: Managed through WordPress admin

### Development Cycle
1. Make changes to theme/content files
2. Test locally with `.\scripts\quick-update.ps1`
3. Commit changes to Git
4. Deploy updates as needed

## 🌐 Access Points

- **Website**: http://maflokids.local/
- **Admin**: http://maflokids.local/wp-admin
- **Credentials**: Check `wp-admin-password.txt` after first deployment

## 📞 Support

For issues with the automation system, check:
1. PowerShell execution policy
2. PHP and MariaDB installation
3. File permissions
4. Network connectivity

The system is designed to be self-healing and will attempt to fix common issues automatically.
