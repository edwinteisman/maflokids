# WordPress Configuration Script
# This script applies WordPress settings and configurations

# Set website basic settings
Write-Host "⚙️ Configuring WordPress settings..." -ForegroundColor Yellow

# Site settings
wp option update blogname "Ma Flo Kids"
wp option update blogdescription "Ma Flo Kids Website"
wp option update start_of_week 1
wp option update timezone_string "Europe/Amsterdam"

# Privacy and security settings
wp option update default_ping_status "closed"
wp option update default_comment_status "closed"
wp option update blog_public 1

# Media settings
wp option update thumbnail_size_w 150
wp option update thumbnail_size_h 150
wp option update medium_size_w 300
wp option update medium_size_h 300
wp option update large_size_w 1024
wp option update large_size_h 1024

# Reading settings
wp option update posts_per_page 10
wp option update show_on_front "page"

# Create default pages if they don't exist
$pages = @(
    @{title="Home"; slug="home"; template="page-home.php"},
    @{title="About"; slug="about"; template="page.php"},
    @{title="Services"; slug="services"; template="page.php"},
    @{title="Contact"; slug="contact"; template="page-contact.php"}
)

foreach ($page in $pages) {
    $pageExists = wp post list --post_type=page --name=$($page.slug) --format=count 2>$null
    if ($pageExists -eq 0) {
        Write-Host "📄 Creating page: $($page.title)" -ForegroundColor Cyan
        $pageId = wp post create --post_type=page --post_title="$($page.title)" --post_name="$($page.slug)" --post_status=publish --porcelain

        # Set page template if specified
        if ($page.template) {
            wp post meta update $pageId _wp_page_template $page.template
        }
    }
}

# Set homepage
$homePageId = wp post list --post_type=page --name=home --field=ID 2>$null
if ($homePageId) {
    wp option update page_on_front $homePageId
    Write-Host "🏠 Set homepage to: Home" -ForegroundColor Green
}

# Create navigation menu
$menuExists = wp menu list --format=count 2>$null
if ($menuExists -eq 0) {
    Write-Host "🧭 Creating navigation menu..." -ForegroundColor Cyan

    # Create primary menu
    wp menu create "Primary Menu"
    $menuId = wp menu list --field=term_id 2>$null

    # Add pages to menu
    foreach ($page in $pages) {
        $pageId = wp post list --post_type=page --name=$($page.slug) --field=ID 2>$null
        if ($pageId) {
            wp menu item add-post $menuId $pageId
        }
    }

    # Assign menu to primary location
    wp menu location assign $menuId primary

    Write-Host "✅ Navigation menu created" -ForegroundColor Green
}

# Activate theme (if custom theme exists)
$customThemes = wp theme list --field=name --status=inactive 2>$null
if ($customThemes -contains "maflokids-theme") {
    wp theme activate maflokids-theme
    Write-Host "🎨 Activated custom theme: maflokids-theme" -ForegroundColor Green
} else {
    # Use a default theme suitable for business sites
    wp theme install twentytwentyfour --activate
    Write-Host "🎨 Activated default theme: Twenty Twenty-Four" -ForegroundColor Green
}

# Configure essential plugins
Write-Host "🔌 Configuring plugins..." -ForegroundColor Cyan

# Configure Contact Form 7 (if installed)
$cf7Active = wp plugin is-active contact-form-7 2>$null
if ($cf7Active) {
    Write-Host "📧 Contact Form 7 is active" -ForegroundColor Green
}

# Configure Yoast SEO (if installed)
$yoastActive = wp plugin is-active wordpress-seo 2>$null
if ($yoastActive) {
    Write-Host "🔍 Yoast SEO is active" -ForegroundColor Green
}

Write-Host "✅ WordPress configuration completed" -ForegroundColor Green
