# Content Setup Script
# This script sets up default content for the Ma Flo Kids website

Write-Host "📝 Setting up default content..." -ForegroundColor Yellow

# Set default content for pages
$pages = @{
    "home" = @{
        title = "Welcome to Ma Flo Kids"
        content = @"
<h1>Welcome to Ma Flo Kids</h1>

<p>Welcome to our website! We're excited to share our services with you.</p>

<div class="hero-section">
    <h2>What We Offer</h2>
    <p>Discover our range of services designed specifically for children and families.</p>
    <a href="/services" class="cta-button">View Our Services</a>
</div>

<div class="about-preview">
    <h2>About Us</h2>
    <p>Learn more about our mission and the team behind Ma Flo Kids.</p>
    <a href="/about">Read More About Us</a>
</div>

<div class="contact-preview">
    <h2>Get In Touch</h2>
    <p>Ready to get started? Contact us today!</p>
    <a href="/contact">Contact Us</a>
</div>
"@
    }

    "about" = @{
        title = "About Ma Flo Kids"
        content = @"
<h1>About Ma Flo Kids</h1>

<p>Welcome to Ma Flo Kids - we are passionate about providing excellent services for children and families.</p>

<h2>Our Story</h2>
<p>Ma Flo Kids was founded with the vision of creating a positive impact in the lives of children and families. We believe in [add your mission and values here].</p>

<h2>Our Mission</h2>
<p>Our mission is to [describe your mission here].</p>

<h2>What Makes Us Different</h2>
<ul>
    <li>Dedicated and experienced team</li>
    <li>Child-focused approach</li>
    <li>Safe and welcoming environment</li>
    <li>Personalized attention</li>
</ul>

<h2>Our Team</h2>
<p>[Add information about your team members here]</p>
"@
    }

    "services" = @{
        title = "Our Services"
        content = @"
<h1>Our Services</h1>

<p>We offer a range of services designed to support children and families.</p>

<div class="services-grid">
    <div class="service-item">
        <h3>Service 1</h3>
        <p>Description of your first service offering.</p>
    </div>

    <div class="service-item">
        <h3>Service 2</h3>
        <p>Description of your second service offering.</p>
    </div>

    <div class="service-item">
        <h3>Service 3</h3>
        <p>Description of your third service offering.</p>
    </div>
</div>

<h2>Why Choose Our Services?</h2>
<ul>
    <li>Professional and experienced staff</li>
    <li>Safe and nurturing environment</li>
    <li>Flexible scheduling options</li>
    <li>Competitive pricing</li>
</ul>

<div class="cta-section">
    <h2>Ready to Get Started?</h2>
    <p>Contact us today to learn more about our services.</p>
    <a href="/contact" class="cta-button">Contact Us Now</a>
</div>
"@
    }

    "contact" = @{
        title = "Contact Us"
        content = @"
<h1>Contact Us</h1>

<p>We'd love to hear from you! Get in touch with us using the information below or fill out our contact form.</p>

<div class="contact-info">
    <div class="contact-details">
        <h2>Contact Information</h2>
        <p><strong>Address:</strong><br>
        [Your Address Here]<br>
        [City, Postal Code]</p>

        <p><strong>Phone:</strong> [Your Phone Number]</p>
        <p><strong>Email:</strong> [Your Email Address]</p>

        <h3>Business Hours</h3>
        <p>Monday - Friday: 9:00 AM - 5:00 PM<br>
        Saturday: 10:00 AM - 2:00 PM<br>
        Sunday: Closed</p>
    </div>

    <div class="contact-form">
        <h2>Send Us a Message</h2>
        [contact-form-7 id="1" title="Contact form 1"]
    </div>
</div>

<div class="map-section">
    <h2>Find Us</h2>
    <p>We're located in [your area]. Visit us or contact us for directions!</p>
    <!-- Map embed would go here -->
</div>
"@
    }
}

# Update page content
foreach ($pageSlug in $pages.Keys) {
    $pageData = $pages[$pageSlug]

    # Get page ID
    $pageId = wp post list --post_type=page --name=$pageSlug --field=ID 2>$null

    if ($pageId) {
        Write-Host "📄 Updating content for: $($pageData.title)" -ForegroundColor Cyan

        # Update page content
        $tempFile = [System.IO.Path]::GetTempFileName()
        $pageData.content | Out-File -FilePath $tempFile -Encoding UTF8
        wp post update $pageId --post_content="$($pageData.content)"
        Remove-Item $tempFile

        Write-Host "✅ Updated: $($pageData.title)" -ForegroundColor Green
    }
}

# Create a basic contact form (Contact Form 7)
$cf7Active = wp plugin is-active contact-form-7 2>$null
if ($cf7Active) {
    Write-Host "📧 Creating contact form..." -ForegroundColor Cyan

    $contactFormExists = wp post list --post_type=wpcf7_contact_form --format=count 2>$null
    if ($contactFormExists -eq 0) {
        # Create contact form
        $formContent = @"
<label> Your Name (required)
    [text* your-name] </label>

<label> Your Email (required)
    [email* your-email] </label>

<label> Subject
    [text your-subject] </label>

<label> Your Message
    [textarea your-message] </label>

[submit "Send"]
"@

        $tempFormFile = [System.IO.Path]::GetTempFileName()
        $formContent | Out-File -FilePath $tempFormFile -Encoding UTF8

        # Note: Creating CF7 forms via WP-CLI requires more complex setup
        # For now, we'll create a placeholder
        Write-Host "📧 Contact form will be set up in WordPress admin" -ForegroundColor Yellow

        Remove-Item $tempFormFile
    }
}

Write-Host "✅ Default content setup completed" -ForegroundColor Green
