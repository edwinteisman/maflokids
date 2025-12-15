<?php
/*
Theme Name: Ma Flo Kids Theme
Description: Custom WordPress theme for Ma Flo Kids website
Version: 1.0
Author: Ma Flo Kids Team
*/

// Prevent direct access
if (!defined('ABSPATH')) {
    exit;
}

// Theme setup
function maflokids_theme_setup() {
    // Add theme support
    add_theme_support('title-tag');
    add_theme_support('post-thumbnails');
    add_theme_support('html5', array(
        'search-form',
        'comment-form',
        'comment-list',
        'gallery',
        'caption',
    ));
    add_theme_support('custom-logo');

    // Register navigation menus
    register_nav_menus(array(
        'primary' => __('Primary Menu', 'maflokids'),
        'footer' => __('Footer Menu', 'maflokids'),
    ));
}
add_action('after_setup_theme', 'maflokids_theme_setup');

// Enqueue styles and scripts
function maflokids_enqueue_assets() {
    wp_enqueue_style('maflokids-style', get_stylesheet_uri(), array(), '1.0.0');
    wp_enqueue_script('maflokids-script', get_template_directory_uri() . '/js/main.js', array('jquery'), '1.0.0', true);
}
add_action('wp_enqueue_scripts', 'maflokids_enqueue_assets');

// Register widget areas
function maflokids_widgets_init() {
    register_sidebar(array(
        'name'          => __('Sidebar', 'maflokids'),
        'id'            => 'sidebar-1',
        'description'   => __('Add widgets here to appear in your sidebar.', 'maflokids'),
        'before_widget' => '<section id="%1$s" class="widget %2$s">',
        'after_widget'  => '</section>',
        'before_title'  => '<h3 class="widget-title">',
        'after_title'   => '</h3>',
    ));

    register_sidebar(array(
        'name'          => __('Footer Area', 'maflokids'),
        'id'            => 'footer-1',
        'description'   => __('Add widgets here to appear in your footer.', 'maflokids'),
        'before_widget' => '<div id="%1$s" class="footer-widget %2$s">',
        'after_widget'  => '</div>',
        'before_title'  => '<h4 class="footer-widget-title">',
        'after_title'   => '</h4>',
    ));
}
add_action('widgets_init', 'maflokids_widgets_init');

// Custom excerpt length
function maflokids_excerpt_length($length) {
    return 30;
}
add_filter('excerpt_length', 'maflokids_excerpt_length');

// Custom logo setup
function maflokids_custom_logo_setup() {
    $defaults = array(
        'height'      => 100,
        'width'       => 400,
        'flex-height' => true,
        'flex-width'  => true,
        'header-text' => array('site-title', 'site-description'),
    );
    add_theme_support('custom-logo', $defaults);
}
add_action('after_setup_theme', 'maflokids_custom_logo_setup');

// Add custom CSS for admin
function maflokids_admin_styles() {
    echo '<style>
        .admin-color-scheme {
            --wp-admin-theme-color: #0073aa;
        }
    </style>';
}
add_action('admin_head', 'maflokids_admin_styles');
?>
